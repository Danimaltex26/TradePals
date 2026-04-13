import LegalPage from '../../components/LegalPage'

const EFFECTIVE_DATE = 'April 13, 2026'

export default function LiftPalTerms() {
  return (
    <LegalPage title="LiftPal Terms of Service">
      <p><strong>Effective date:</strong> {EFFECTIVE_DATE}</p>

      <h2>1. Acceptance</h2>
      <p>By creating an account or using LiftPal, you agree to these Terms. If you do not agree, do not use the service.</p>

      <h2>2. Eligibility</h2>
      <p>You must be at least 18 years old and legally able to enter into contracts. LiftPal is intended for use by elevator and lift industry professionals.</p>

      <h2>3. Account</h2>
      <p>You are responsible for maintaining the security of your account credentials. You must not share your account with others.</p>

      <h2>4. Subscriptions</h2>
      <p>LiftPal offers a free tier with limited usage and a Pro tier with unlimited access. Subscription management and billing are handled through the Apple App Store (iOS) or directly through our platform (web). Refunds follow the applicable store's refund policy.</p>

      <h2>5. Acceptable Use</h2>
      <p>You must not use LiftPal to generate content that violates any law, upload content you do not have the right to share, attempt to reverse-engineer the service, or use automated tools to access the service.</p>

      <h2>6. Disclaimer</h2>
      <p>LiftPal provides AI-assisted analysis as a supplementary tool. It does not replace professional judgment, manufacturer service manuals, or applicable codes and standards. Always verify AI-generated recommendations against ASME A17.1, manufacturer documentation, and local Authority Having Jurisdiction (AHJ) requirements before taking action. TradePals, LLC is not liable for decisions made based on AI output.</p>

      <h2>7. Limitation of Liability</h2>
      <p>To the maximum extent permitted by law, TradePals, LLC's total liability is limited to the amount you paid for the service in the 12 months preceding the claim.</p>

      <h2>8. Contact</h2>
      <p>Questions? Email support@tradepals.net.</p>
    </LegalPage>
  )
}
