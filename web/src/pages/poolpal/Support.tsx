import LegalPage from '../../components/LegalPage'

export default function PoolPalSupport() {
  return (
    <LegalPage title="PoolPal Support">
      <p>
        Need help with PoolPal? We're here to assist.
      </p>
      <h2 className="text-xl font-bold text-white mt-6">Contact</h2>
      <p>
        Email: <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">support@tradepals.net</a>
      </p>
      <p>We aim to respond within one business day.</p>
      <h2 className="text-xl font-bold text-white mt-6">Frequently asked</h2>
      <p><strong>How do I cancel my subscription?</strong> Subscriptions are managed through your Apple ID. On iOS, open Settings → your name → Subscriptions → PoolPal.</p>
      <p><strong>How do I restore a purchase on a new device?</strong> Open the app and tap Profile → Restore Purchases.</p>
      <p><strong>I forgot my password.</strong> Use the password reset on the sign-in screen, or email support and we'll help you recover access.</p>
      <p><strong>Does PoolPal replace professional water testing?</strong> No. PoolPal analyzes visual conditions only. Always confirm results with a certified test kit (such as Taylor K-2005 or FAS-DPD) and follow your local health code requirements.</p>
      <p><strong>Can PoolPal diagnose equipment problems?</strong> PoolPal can suggest troubleshooting steps based on photos and symptoms you describe, but it cannot replace hands-on inspection by a qualified technician. Always verify against manufacturer specs before replacing parts.</p>
      <p><strong>Does PoolPal help with certification exams?</strong> PoolPal includes study material for CPO, AFO, PHTA CST, and CPI prep, but it does not guarantee passing any exam or qualify you for any certification.</p>
    </LegalPage>
  )
}
