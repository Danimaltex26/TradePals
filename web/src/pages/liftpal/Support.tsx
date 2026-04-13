import LegalPage from '../../components/LegalPage'

export default function LiftPalSupport() {
  return (
    <LegalPage title="LiftPal Support">
      <p>Need help? Contact us at <a href="mailto:support@tradepals.net">support@tradepals.net</a>.</p>

      <h2>Frequently Asked Questions</h2>

      <h3>What does the free tier include?</h3>
      <p>2 photo inspections, 2 troubleshoot sessions, and 5 AI reference lookups per month. Quick-reference specs are always free with no limits.</p>

      <h3>How do I upgrade to Pro?</h3>
      <p>Pro subscriptions will be available through the Apple App Store (iOS) and directly on the web. Pro removes all usage limits and unlocks certification exam prep features.</p>

      <h3>How do I reset my password?</h3>
      <p>On the sign-in screen, enter your email and tap "Send Magic Link". You'll receive a one-time sign-in link — once signed in, you can update your password from your profile.</p>

      <h3>How accurate is the photo analysis?</h3>
      <p>The AI provides a ranked diagnosis with confidence levels and always recommends verification against manufacturer documentation and applicable codes. It's a field assistant, not a replacement for your professional judgment or a code-required inspection.</p>

      <h3>Can LiftPal replace an ASME A17.1 code book?</h3>
      <p>No. LiftPal provides quick code lookups and references for convenience, but you should always verify against the current edition of ASME A17.1 and your local AHJ amendments for code compliance decisions.</p>

      <h3>Is my data private?</h3>
      <p>Yes. Your photos and analysis data are yours. We don't share them with other users, sell them to third parties, or use them to train AI models.</p>
    </LegalPage>
  )
}
