import LegalPage from '../../components/LegalPage'

export default function SplicePalPrivacy() {
  return (
    <LegalPage title="SplicePal Privacy Policy">
      <p>Last updated: {new Date().toLocaleDateString()}</p>
      <p>
        SplicePal ("we", "our", "us") respects your privacy. This policy explains what data we collect, why,
        and how we use it.
      </p>
      <h2 className="text-xl font-bold text-white mt-6">Information we collect</h2>
      <ul className="list-disc pl-6 space-y-1">
        <li>Account info: email address, display name, profile preferences.</li>
        <li>Usage: OTDR analyses, troubleshooting sessions, and reference lookups you create.</li>
        <li>Images you upload for AI analysis.</li>
      </ul>
      <h2 className="text-xl font-bold text-white mt-6">How we use it</h2>
      <ul className="list-disc pl-6 space-y-1">
        <li>To provide AI analysis features.</li>
        <li>To save your history so you can revisit past work.</li>
        <li>To enforce subscription entitlements.</li>
      </ul>
      <h2 className="text-xl font-bold text-white mt-6">Sharing</h2>
      <p>
        We share image and text content with Anthropic (Claude) solely to provide analysis. We do not sell
        personal data. We use Supabase for storage and authentication, and Apple/RevenueCat for subscription
        processing.
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
