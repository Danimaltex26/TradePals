import LegalPage from '../../components/LegalPage'

export default function SplicePalSupport() {
  return (
    <LegalPage title="SplicePal Support">
      <p>
        Need help with SplicePal? We're here to assist.
      </p>
      <h2 className="text-xl font-bold text-white mt-6">Contact</h2>
      <p>
        Email: <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">support@tradepals.net</a>
      </p>
      <p>We aim to respond within one business day.</p>
      <h2 className="text-xl font-bold text-white mt-6">Frequently asked</h2>
      <p><strong>How do I cancel my subscription?</strong> Subscriptions are managed through your Apple ID. On iOS, open Settings → your name → Subscriptions → SplicePal.</p>
      <p><strong>How do I restore a purchase on a new device?</strong> Open the app and tap Profile → Restore Purchases.</p>
      <p><strong>I forgot my password.</strong> Use the password reset on the sign-in screen, or email support and we'll help you recover access.</p>
    </LegalPage>
  )
}
