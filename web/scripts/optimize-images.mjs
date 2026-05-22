// One-shot image optimizer. Walks public/, generates WebP at sensible
// dimensions and quality, and reports size deltas. Run with:
//   node scripts/optimize-images.mjs
//
// Source PNGs are left in place so we can fall back if needed and so
// the favicon (which must stay PNG) keeps working. Generated WebPs sit
// alongside as e.g. `splicepal-logo.webp`. Update component references
// to point at the .webp paths.
//
// Dimension caps below assume retina (~2x) usage. A header logo that
// renders at 240px gets a 480px-wide WebP; bigger source images get
// downscaled, smaller ones stay as-is (sharp's `withoutEnlargement`).

import { readdir, stat } from 'node:fs/promises'
import path from 'node:path'
import sharp from 'sharp'

const PUBLIC_DIR = path.resolve(process.cwd(), 'public')

// Filename glob → max edge length. First matching pattern wins.
// 'longest edge' preserves aspect ratio; sharp picks the constraining dimension.
const SIZE_RULES = [
  { match: /Flavicon\.png$/i, skip: true },                  // favicon must stay PNG
  { match: /^.*-logo(-dark)?\.png$/i, maxEdge: 480 },        // app + master logos (header use ~240px)
  { match: /^cert\d+\.png$/i, maxEdge: 600 },                // training cert thumbnails (200x356 mockup max)
  { match: /^watch\d+\.png$/i, maxEdge: 800 },               // legacy/landing assets
  { match: /^(in|out)\d?\.png$/i, maxEdge: 1000 },           // before/after screenshots (rendered ~440px mockup)
  { match: /\.png$/i, maxEdge: 1200 },                       // anything else
]

function ruleFor(filename) {
  for (const r of SIZE_RULES) if (r.match.test(filename)) return r
  return null
}

function pct(before, after) {
  return ((1 - after / before) * 100).toFixed(0) + '%'
}

async function main() {
  const entries = await readdir(PUBLIC_DIR)
  const pngFiles = entries.filter((f) => f.toLowerCase().endsWith('.png'))

  let totalBefore = 0
  let totalAfter = 0
  let skipped = 0
  let converted = 0

  for (const file of pngFiles) {
    const rule = ruleFor(file)
    if (rule?.skip) {
      const s = await stat(path.join(PUBLIC_DIR, file))
      console.log(`  skip   ${file.padEnd(28)} (${(s.size / 1024).toFixed(0)}K) — favicon`)
      skipped++
      continue
    }

    const srcPath = path.join(PUBLIC_DIR, file)
    const outName = file.replace(/\.png$/i, '.webp')
    const outPath = path.join(PUBLIC_DIR, outName)

    const before = (await stat(srcPath)).size

    await sharp(srcPath)
      .resize({
        width: rule?.maxEdge,
        height: rule?.maxEdge,
        fit: 'inside',
        withoutEnlargement: true,
      })
      .webp({ quality: 82, effort: 5 })
      .toFile(outPath)

    const after = (await stat(outPath)).size
    totalBefore += before
    totalAfter += after
    converted++

    console.log(
      `  conv   ${file.padEnd(28)} ${(before / 1024).toFixed(0)}K → ${(after / 1024).toFixed(0)}K  (${pct(before, after)})`,
    )
  }

  console.log()
  console.log(`Converted ${converted} files, skipped ${skipped}.`)
  console.log(
    `Total: ${(totalBefore / 1024).toFixed(0)}K → ${(totalAfter / 1024).toFixed(0)}K  (saved ${pct(totalBefore, totalAfter)}, ${((totalBefore - totalAfter) / 1024).toFixed(0)}K)`,
  )
}

main().catch((err) => {
  console.error('optimize-images failed:', err)
  process.exit(1)
})
