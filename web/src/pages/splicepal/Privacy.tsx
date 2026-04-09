import LegalPage from '../../components/LegalPage'

const EFFECTIVE_DATE = 'April 9, 2026'

export default function SplicePalPrivacy() {
  return (
    <LegalPage title="SplicePal Privacy Policy">
      <p><strong>Effective date:</strong> {EFFECTIVE_DATE}</p>
      <p>
        This Privacy Policy describes how TradePals, LLC ("TradePals," "we," "our," or "us") collects, uses,
        and shares information when you use the SplicePal mobile app and the SplicePal sections of
        tradepals.net (collectively, the "Service"). By using SplicePal, you agree to the practices described
        below.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">1. Who we are</h2>
      <p>
        SplicePal is operated by <strong>TradePals, LLC</strong>, a Texas limited liability company located
        in Bexar County, Texas. You can reach us at{' '}
        <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">support@tradepals.net</a>.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">2. Information we collect</h2>
      <p>We collect the following categories of information:</p>
      <ul className="list-disc pl-6 space-y-1">
        <li><strong>Account information</strong> — email address, password (hashed), display name, and any optional profile fields you provide (such as splicer models, certifications, and experience level).</li>
        <li><strong>Content you submit</strong> — OTDR trace images and other photos you upload for AI analysis, troubleshooting forms you fill out, reference lookups, certification quiz activity, and any notes you save.</li>
        <li><strong>Usage data</strong> — analyses you create, sessions you start, features you use, and timestamps. We use this to provide history, save your work, and enforce subscription limits.</li>
        <li><strong>Device and technical data</strong> — device type, operating system version, app version, language, IP address, and crash diagnostics. We use this to operate the Service and debug issues.</li>
        <li><strong>Subscription state</strong> — whether you have an active subscription, your tier, and renewal/expiration dates. Apple is the source of truth for purchases; we receive entitlement updates and store them.</li>
      </ul>
      <p>
        We <strong>do not</strong> collect precise location, contacts, microphone audio, health data, or any
        sensitive personal information that is not necessary to operate the Service.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">3. How we use your information</h2>
      <ul className="list-disc pl-6 space-y-1">
        <li>To provide AI-powered OTDR analysis and troubleshooting features.</li>
        <li>To save your history so you can revisit past work.</li>
        <li>To authenticate you and keep your account secure.</li>
        <li>To enforce subscription entitlements and usage limits.</li>
        <li>To send transactional emails (account confirmation, password reset, sign-in links).</li>
        <li>To diagnose bugs, prevent abuse, and improve the Service.</li>
        <li>To comply with legal obligations.</li>
      </ul>
      <p>
        We do <strong>not</strong> use your content to train third-party AI models, sell your data to
        advertisers, or use your information for advertising purposes.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">4. Third parties we share with</h2>
      <p>We share information only with service providers that help us operate SplicePal:</p>
      <ul className="list-disc pl-6 space-y-1">
        <li><strong>Anthropic (Claude API)</strong> — image and text content you submit for analysis is sent to Anthropic solely to generate the AI response. Anthropic processes this content under their own terms; per their published API policy, content sent through the API is not used to train their models.</li>
        <li><strong>Supabase</strong> — provides our database, authentication, and file storage. Your account, profile, history, and uploaded images are stored on Supabase infrastructure (United States).</li>
        <li><strong>Resend</strong> — delivers transactional emails (signup confirmation, password reset, sign-in links) on our behalf.</li>
        <li><strong>Apple</strong> — handles all subscription billing through the App Store. We receive subscription status from Apple; we never see your payment details.</li>
        <li><strong>Vercel</strong> — hosts tradepals.net.</li>
      </ul>
      <p>
        We do <strong>not</strong> sell or rent personal information. We do not share your data with
        advertising networks or data brokers.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">5. Data location and transfers</h2>
      <p>
        SplicePal is operated from the United States. By using the Service, you understand that your
        information will be processed in the U.S., which may have different data protection laws than your
        country of residence.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">6. How long we keep data</h2>
      <p>
        We keep your account information and history for as long as your account is active. If you delete
        your account, we delete your personal data within 30 days, except where we are required to retain
        certain records (for example, tax or fraud-prevention records).
      </p>

      <h2 className="text-xl font-bold text-white mt-6">7. Your rights and choices</h2>
      <p>You have the right to:</p>
      <ul className="list-disc pl-6 space-y-1">
        <li><strong>Access</strong> the personal information we hold about you.</li>
        <li><strong>Correct</strong> inaccurate information by editing your profile in the app.</li>
        <li><strong>Delete</strong> your account and all associated data.</li>
        <li><strong>Export</strong> a copy of your data in a portable format.</li>
        <li><strong>Withdraw consent</strong> for processing where consent is the legal basis.</li>
      </ul>
      <p>
        To exercise any of these rights, email{' '}
        <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">support@tradepals.net</a>.
        We will respond within 30 days.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">8. California residents (CCPA / CPRA)</h2>
      <p>
        If you are a California resident, you have additional rights under the California Consumer Privacy
        Act, including the right to know what personal information we collect, the right to delete that
        information, the right to correct inaccurate information, and the right to opt out of the "sale" or
        "sharing" of personal information. We do not sell or share personal information as those terms are
        defined under the CCPA. To exercise your rights, email{' '}
        <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">support@tradepals.net</a>.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">9. European users (GDPR)</h2>
      <p>
        If you are in the European Economic Area, United Kingdom, or Switzerland, our legal bases for
        processing your information are: (a) <em>contract</em> — to provide the Service you signed up for;
        (b) <em>legitimate interests</em> — to operate, secure, and improve the Service; (c) <em>consent</em>
        {' '}where required; and (d) <em>legal obligation</em>. You have the rights of access, rectification,
        erasure, restriction, portability, and objection. You may also lodge a complaint with your local
        data protection authority.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">10. Children</h2>
      <p>
        SplicePal is not directed to children under 13 (or under 16 in the EEA), and we do not knowingly
        collect personal information from children. If you believe a child has provided us personal
        information, contact us and we will delete it.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">11. Security</h2>
      <p>
        We use industry-standard safeguards including encryption in transit (HTTPS/TLS), encryption at rest
        for stored content, hashed passwords, and access controls. No method of transmission or storage is
        100% secure, and we cannot guarantee absolute security.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">12. Changes to this policy</h2>
      <p>
        We may update this Privacy Policy from time to time. If we make material changes we will notify
        you in the app and/or by email. The "Effective date" at the top will always reflect the latest
        version.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">13. Contact us</h2>
      <p>
        TradePals, LLC<br />
        Bexar County, Texas, USA<br />
        Email: <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">support@tradepals.net</a>
      </p>
    </LegalPage>
  )
}
