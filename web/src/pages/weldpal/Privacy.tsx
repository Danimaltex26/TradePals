import LegalPage from '../../components/LegalPage'

export default function WeldPalPrivacy() {
  return (
    <LegalPage title="WeldPal Privacy Policy">
      <p>Last updated: {new Date().toLocaleDateString()}</p>
      <p>
        WeldPal ("we", "our", "us") respects your privacy. This policy explains what data we collect, why,
        and how we use it.
      </p>
      <h2 className="text-xl font-bold text-white mt-6">Information we collect</h2>
      <ul className="list-disc pl-6 space-y-1">
        <li>Account info: email address, display name, profile preferences (welding processes, certifications, industry).</li>
        <li>Usage: weld analyses, troubleshooting sessions, reference lookups, cert-prep activity.</li>
        <li>Photos you upload for AI analysis.</li>
      </ul>
      <h2 className="text-xl font-bold text-white mt-6">How we use it</h2>
      <ul className="list-disc pl-6 space-y-1">
        <li>To provide AI weld defect analysis.</li>
        <li>To save your history so you can revisit past work.</li>
        <li>To enforce subscription entitlements.</li>
      </ul>
      <h2 className="text-xl font-bold text-white mt-6">Sharing</h2>
      <p>
        We share image and text content with Anthropic (Claude) solely to provide analysis. We do not sell
        personal data. We use Supabase for storage and authentication, and Apple/RevenueCat for subscription
        processing.
      </p>
      <h2 className="text-xl font-bold text-white mt-6">Disclaimer</h2>
      <p>
        WeldPal analyzes <strong>visual surface defects only</strong>. It is not a substitute for non-destructive
        testing (ultrasonic, radiographic, magnetic particle, or penetrant), nor for the judgment of a qualified
        Certified Welding Inspector.
      </p>
      <h2 className="text-xl font-bold text-white mt-6">Your rights</h2>
      <p>
        You can request deletion of your account and all associated data by emailing{' '}
        <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.com">support@tradepals.com</a>.
      </p>
      <h2 className="text-xl font-bold text-white mt-6">Contact</h2>
      <p>Questions? Email <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.com">support@tradepals.com</a>.</p>
    </LegalPage>
  )
}
