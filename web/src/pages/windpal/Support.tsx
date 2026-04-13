import LegalPage from '../../components/LegalPage'

export default function WindPalSupport() {
  return (
    <LegalPage title="WindPal Support">
      <p>
        Need help with WindPal? We're here to assist.
      </p>
      <h2 className="text-xl font-bold text-white mt-6">Contact</h2>
      <p>
        Email: <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">support@tradepals.net</a>
      </p>
      <p>We aim to respond within one business day.</p>
      <h2 className="text-xl font-bold text-white mt-6">Frequently asked</h2>
      <p><strong>How do I cancel my subscription?</strong> Subscriptions are managed through your Apple ID. On iOS, open Settings → your name → Subscriptions → WindPal.</p>
      <p><strong>How do I restore a purchase on a new device?</strong> Open the app and tap Profile → Restore Purchases.</p>
      <p><strong>I forgot my password.</strong> Use the password reset on the sign-in screen, or email support and we'll help you recover access.</p>
      <p><strong>Can WindPal diagnose wind turbine faults from photos?</strong> WindPal can analyze photos of panels, wiring, and equipment to suggest possible faults and troubleshooting steps. However, it cannot replace hands-on testing with calibrated meters. Always verify with proper test equipment before making any repairs.</p>
      <p><strong>Does WindPal help with VFD fault codes?</strong> Yes. You can describe or photograph a VFD fault display and WindPal will suggest likely causes and troubleshooting steps based on common manufacturer fault code tables. Always cross-reference the drive's specific manual.</p>
      <p><strong>Can I look up NEC codes?</strong> WindPal includes NEC reference and wire sizing tools. Enter your scenario and WindPal will point you to the relevant code sections. Always confirm against the current adopted edition in your jurisdiction.</p>
      <p><strong>Does WindPal help with exam prep?</strong> WindPal includes study material for apprentice and journeyman wind turbine exams, but it does not guarantee passing any exam or qualify you for any license.</p>
    </LegalPage>
  )
}
