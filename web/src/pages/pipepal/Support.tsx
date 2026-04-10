import LegalPage from '../../components/LegalPage'

export default function PipePalSupport() {
  return (
    <LegalPage title="PipePal Support">
      <p>
        Need help with PipePal? We're here to assist.
      </p>
      <h2 className="text-xl font-bold text-white mt-6">Contact</h2>
      <p>
        Email: <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">support@tradepals.net</a>
      </p>
      <p>We aim to respond within one business day.</p>
      <h2 className="text-xl font-bold text-white mt-6">Frequently asked</h2>
      <p><strong>How do I cancel my subscription?</strong> Subscriptions are managed through your Apple ID. On iOS, open Settings → your name → Subscriptions → PipePal.</p>
      <p><strong>How do I restore a purchase on a new device?</strong> Open the app and tap Profile → Restore Purchases.</p>
      <p><strong>I forgot my password.</strong> Use the password reset on the sign-in screen, or email support and we'll help you recover access.</p>
      <p><strong>Can PipePal diagnose plumbing issues from photos?</strong> PipePal can analyze photos of leaks, pipe installations, and fixtures to identify possible code violations and suggest troubleshooting steps. However, it cannot replace hands-on inspection and testing. Always verify with proper leak detection and pressure testing before making any repairs.</p>
      <p><strong>Does PipePal help with drain issues?</strong> Yes. You can describe or photograph a drain problem and PipePal will suggest likely causes and troubleshooting steps. It covers common scenarios like slow drains, backups, venting issues, and improper slope.</p>
      <p><strong>Can PipePal help troubleshoot water heaters?</strong> Yes. PipePal can help diagnose common water heater problems including no hot water, insufficient temperature, leaks, strange noises, and pilot light issues for both tank and tankless units.</p>
      <p><strong>Can I look up plumbing codes?</strong> PipePal includes IPC and UPC code reference tools. Enter your scenario and PipePal will point you to the relevant code sections. Always confirm against the current adopted edition in your jurisdiction.</p>
      <p><strong>Does PipePal help with exam prep?</strong> PipePal includes study material for journeyman and master plumber exams, but it does not guarantee passing any exam or qualify you for any license.</p>
    </LegalPage>
  )
}
