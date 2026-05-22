// Post-build prerender script.
//
// After `vite build` produces dist/, we spin up `vite preview`, drive headless
// Chrome to each public marketing route, capture the fully-rendered HTML
// (Helmet meta + React content baked in), and write per-route static files
// to dist/<route>/index.html.
//
// Vercel will then prefer the static files over the SPA fallback rewrite,
// so crawlers (including ones that don't run JS — LinkedIn, Twitter, FB,
// Discord) see the correct per-page title, description, and og:* meta.
//
// Run via: `node scripts/prerender.mjs` (chained into npm build).

import { spawn } from 'node:child_process'
import { mkdir, writeFile } from 'node:fs/promises'
import { existsSync } from 'node:fs'
import path from 'node:path'
import puppeteer from 'puppeteer'

const PORT = process.env.PRERENDER_PORT ? Number(process.env.PRERENDER_PORT) : 4173
const PREVIEW_HOST = `http://localhost:${PORT}`
const DIST_DIR = path.resolve(process.cwd(), 'dist')
const PREVIEW_READY_TIMEOUT_MS = 30000
const PAGE_NAV_TIMEOUT_MS = 30000

// Public marketing routes. Mirror this list with web/public/sitemap.xml — both
// must agree about what's a real page. Dynamic auth-gated routes (training,
// certprep, team, join, profile, account, signin, admin) are intentionally
// excluded — they live in the SPA and don't need crawling.
const APPS = ['splicepal', 'weldpal', 'poolpal', 'voltpal', 'pipepal', 'windpal', 'liftpal']
const STATIC_ROUTES = [
  '/',
  '/about',
  '/training',
  ...APPS.flatMap((a) => [`/${a}`, `/${a}/privacy`, `/${a}/terms`, `/${a}/support`]),
]

// ── Helpers ────────────────────────────────────────────────────────────────

function log(...args) {
  console.log('[prerender]', ...args)
}

async function waitForPreviewReady() {
  const start = Date.now()
  while (Date.now() - start < PREVIEW_READY_TIMEOUT_MS) {
    try {
      const res = await fetch(PREVIEW_HOST + '/')
      if (res.ok) return
    } catch {
      // not ready yet
    }
    await new Promise((r) => setTimeout(r, 200))
  }
  throw new Error(`vite preview did not become ready within ${PREVIEW_READY_TIMEOUT_MS}ms`)
}

function startPreview() {
  // shell:true is required on Windows to resolve npx/npx.cmd. On Unix it's harmless.
  const child = spawn('npx vite preview --port ' + PORT + ' --strictPort', {
    cwd: process.cwd(),
    stdio: ['ignore', 'pipe', 'pipe'],
    shell: true,
  })
  child.stdout.on('data', (chunk) => process.stdout.write(`[preview] ${chunk}`))
  child.stderr.on('data', (chunk) => process.stderr.write(`[preview] ${chunk}`))
  return child
}

function routeToOutputPath(route) {
  // '/' → dist/index.html
  // '/splicepal' → dist/splicepal/index.html
  // '/splicepal/privacy' → dist/splicepal/privacy/index.html
  if (route === '/') return path.join(DIST_DIR, 'index.html')
  const segments = route.replace(/^\//, '').split('/').filter(Boolean)
  return path.join(DIST_DIR, ...segments, 'index.html')
}

// Strip the Vite preview port out of any absolute URLs we accidentally captured
// (e.g. a canonical or og:url that included http://localhost:4173 — shouldn't
// happen with our PageMeta but defensive belt-and-suspenders).
function normalizeHtml(html) {
  return html
    .replaceAll(`http://localhost:${PORT}`, 'https://tradepals.net')
    .replaceAll(`https://localhost:${PORT}`, 'https://tradepals.net')
}

async function prerenderRoute(page, route) {
  const url = PREVIEW_HOST + route
  log(`→ ${route}`)
  try {
    await page.goto(url, { waitUntil: 'networkidle0', timeout: PAGE_NAV_TIMEOUT_MS })
    // Give Helmet one extra tick to flush any deferred state changes.
    await new Promise((r) => setTimeout(r, 250))
    const html = await page.content()
    const outPath = routeToOutputPath(route)
    await mkdir(path.dirname(outPath), { recursive: true })
    await writeFile(outPath, normalizeHtml(html), 'utf8')
  } catch (err) {
    console.error(`[prerender] FAILED ${route}:`, err.message)
    throw err
  }
}

// ── Main ───────────────────────────────────────────────────────────────────

async function main() {
  if (!existsSync(DIST_DIR)) {
    throw new Error('dist/ not found — run `vite build` before prerender.')
  }

  log(`Prerendering ${STATIC_ROUTES.length} routes...`)
  const preview = startPreview()
  let browser

  try {
    await waitForPreviewReady()
    log('preview ready, launching browser')
    browser = await puppeteer.launch({
      headless: true,
      args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage'],
    })
    const page = await browser.newPage()
    await page.setViewport({ width: 1280, height: 800 })

    const t0 = Date.now()
    for (const route of STATIC_ROUTES) {
      await prerenderRoute(page, route)
    }
    log(`done in ${((Date.now() - t0) / 1000).toFixed(1)}s`)
  } finally {
    if (browser) await browser.close().catch(() => {})
    preview.kill('SIGTERM')
  }
}

main().catch((err) => {
  console.error('[prerender] fatal:', err)
  process.exit(1)
})
