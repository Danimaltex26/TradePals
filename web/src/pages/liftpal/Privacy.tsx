import LegalPage from '../../components/LegalPage'

const EFFECTIVE_DATE = 'April 13, 2026'

export default function LiftPalPrivacy() {
  return (
    <LegalPage title="LiftPal Privacy Policy">
      <p><strong>Effective date:</strong> {EFFECTIVE_DATE}</p>

      <h2>1. Information We Collect</h2>
      <p>When you create a LiftPal account we collect your email address and an optional display name. When you use the app we collect the photos you upload for analysis, your troubleshooting queries, reference lookups, and training progress. We also collect standard usage analytics (pages viewed, feature usage) to improve the product.</p>

      <h2>2. How We Use Your Information</h2>
      <p>Your data is used solely to provide the LiftPal service: analyzing photos, generating diagnoses, storing your history, tracking training progress, and sending you notifications about completed analyses. We do not sell your data to third parties or use it to train AI models.</p>

      <h2>3. Data Storage & Security</h2>
      <p>Your data is stored in Supabase (cloud infrastructure) with row-level security ensuring only you can access your own records. Photos are stored in private cloud storage buckets. All data is encrypted in transit (TLS) and at rest.</p>

      <h2>4. Data Retention</h2>
      <p>Your data is retained as long as your account is active. You can delete individual records from the History tab at any time. To delete your entire account and all associated data, contact support@tradepals.net.</p>

      <h2>5. Your Rights</h2>
      <p>You have the right to access, correct, or delete your personal data. California residents have additional rights under the CCPA. EU residents have additional rights under the GDPR. Contact support@tradepals.net to exercise these rights.</p>

      <h2>6. Contact</h2>
      <p>Questions about this policy? Email support@tradepals.net.</p>
    </LegalPage>
  )
}
