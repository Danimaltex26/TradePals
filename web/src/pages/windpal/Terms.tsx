import LegalPage from '../../components/LegalPage'

const EFFECTIVE_DATE = 'April 10, 2026'

export default function WindPalTerms() {
  return (
    <LegalPage title="WindPal Terms of Service">
      <p><strong>Effective date:</strong> {EFFECTIVE_DATE}</p>
      <p>
        These Terms of Service ("Terms") are a binding agreement between you and{' '}
        <strong>TradePals, LLC</strong> ("TradePals," "we," "our," or "us"), a Texas limited liability
        company located in Bexar County, Texas. They govern your use of the WindPal mobile application
        and the WindPal sections of tradepals.net (together, the "Service"). By creating an account or
        using WindPal you agree to these Terms. If you do not agree, do not use the Service.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">1. Eligibility</h2>
      <p>
        You must be at least 18 years old (or the age of majority in your jurisdiction) to use WindPal.
        By using the Service you represent that you meet this requirement and have the legal capacity to
        enter into these Terms.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">2. Your account</h2>
      <p>
        You are responsible for maintaining the confidentiality of your login credentials and for all
        activity that occurs under your account. Notify us immediately at{' '}
        <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">support@tradepals.net</a>
        {' '}if you suspect unauthorized access. We may suspend or terminate accounts that violate these
        Terms.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">3. Subscriptions and billing</h2>
      <p>
        WindPal offers paid subscriptions purchased through Apple's App Store. The following terms apply
        to all subscriptions:
      </p>
      <ul className="list-disc pl-6 space-y-1">
        <li>Payment is charged to your Apple ID at confirmation of purchase.</li>
        <li>Subscriptions automatically renew unless auto-renew is turned off at least 24 hours before the end of the current period.</li>
        <li>Your account will be charged for renewal within 24 hours prior to the end of the current period at the price of the selected plan.</li>
        <li>You can manage and cancel subscriptions in your Apple ID account settings (Settings → your name → Subscriptions → WindPal). Cancellation takes effect at the end of the current billing period.</li>
        <li>No refunds are provided for partial subscription periods, except where required by law or by Apple's refund policy.</li>
        <li>Prices may change with reasonable notice; continued use after a price change constitutes acceptance.</li>
      </ul>
      <p>
        TradePals does not directly process or store payment card details. All billing is handled by Apple.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">4. Acceptable use</h2>
      <p>You agree not to:</p>
      <ul className="list-disc pl-6 space-y-1">
        <li>Use the Service for any unlawful purpose or in violation of any applicable law or regulation.</li>
        <li>Reverse engineer, decompile, or attempt to extract source code from the Service.</li>
        <li>Scrape, harvest, or mass-download content from the Service.</li>
        <li>Resell, sublicense, or commercially exploit the Service without our written permission.</li>
        <li>Interfere with or disrupt the Service, its security, or other users' use of it.</li>
        <li>Upload content that is illegal, infringes intellectual property rights, or contains malware.</li>
        <li>Misrepresent yourself or impersonate others.</li>
      </ul>

      <h2 className="text-xl font-bold text-white mt-6">5. AI features and important disclaimer</h2>
      <p>
        WindPal uses AI to analyze wind turbine photos, suggest troubleshooting steps, and provide NEC
        reference information. <strong>AI output is provided for informational purposes only and is not a
        substitute for professional judgment.</strong>
      </p>
      <p>
        Specifically, you understand and agree that:
      </p>
      <ul className="list-disc pl-6 space-y-1">
        <li>WindPal analyzes <strong>photos and descriptions only</strong>. It is <strong>NOT</strong> a substitute for proper testing with calibrated meters (multimeter, megger, clamp meter), nor for the judgment of a licensed electrician, master electrician, or wind turbine inspector.</li>
        <li>AI analysis can be incomplete, inaccurate, or wrong. You are solely responsible for verifying any AI-suggested diagnosis against actual meter readings, equipment manufacturer specifications, applicable codes (NEC, local amendments), and your jurisdiction's requirements.</li>
        <li>You must not rely on WindPal as the sole basis for energized work decisions, circuit modifications, equipment replacement, or any action affecting life safety.</li>
        <li>Exam prep content is intended as study material only and does not guarantee passing any exam or qualify you for any license (apprentice, journeyman, master, or otherwise).</li>
      </ul>

      <h2 className="text-xl font-bold text-white mt-6">6. Intellectual property</h2>
      <p>
        TradePals owns the WindPal application, its content (other than user-submitted content), trademarks,
        logos, and the underlying technology. We grant you a personal, non-exclusive, non-transferable,
        revocable license to use the Service in accordance with these Terms.
      </p>
      <p>
        You retain ownership of content you upload (such as wind turbine photos). By uploading content, you
        grant TradePals a worldwide, royalty-free license to host, process, transmit, and display that
        content solely to provide the Service to you.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">7. Disclaimer of warranties</h2>
      <p>
        THE SERVICE IS PROVIDED "AS IS" AND "AS AVAILABLE," WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING WITHOUT LIMITATION ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
        PARTICULAR PURPOSE, ACCURACY, RELIABILITY, OR NON-INFRINGEMENT. WE DO NOT WARRANT THAT THE SERVICE
        WILL BE UNINTERRUPTED, ERROR-FREE, SECURE, OR THAT AI OUTPUTS WILL BE ACCURATE OR COMPLETE.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">8. Limitation of liability</h2>
      <p>
        TO THE FULLEST EXTENT PERMITTED BY LAW, TRADEPALS, LLC AND ITS OFFICERS, MEMBERS, EMPLOYEES, AND
        AGENTS SHALL NOT BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE
        DAMAGES, OR FOR ANY LOST PROFITS, LOST DATA, BUSINESS INTERRUPTION, EQUIPMENT DAMAGE, ELECTRICAL
        INCIDENTS, OR OTHER LOSSES ARISING OUT OF OR RELATED TO YOUR USE OF OR INABILITY TO USE THE
        SERVICE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
      </p>
      <p>
        OUR TOTAL CUMULATIVE LIABILITY TO YOU FOR ANY CLAIM ARISING OUT OF OR RELATING TO THESE TERMS OR
        THE SERVICE SHALL NOT EXCEED THE GREATER OF (A) THE AMOUNT YOU PAID US IN THE TWELVE MONTHS
        PRECEDING THE CLAIM, OR (B) ONE HUNDRED U.S. DOLLARS ($100).
      </p>
      <p>
        Some jurisdictions do not allow the exclusion or limitation of certain damages; in such
        jurisdictions our liability is limited to the greatest extent permitted by law.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">9. Indemnification</h2>
      <p>
        You agree to indemnify, defend, and hold harmless TradePals, LLC and its officers, members,
        employees, and agents from and against any claims, liabilities, damages, losses, and expenses
        (including reasonable attorneys' fees) arising out of or related to (a) your use of the Service,
        (b) your violation of these Terms, (c) your violation of any law or third-party right, or (d) any
        decision or work product you produced in reliance on the Service.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">10. Termination</h2>
      <p>
        You may stop using the Service at any time and may delete your account by emailing{' '}
        <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">support@tradepals.net</a>.
        We may suspend or terminate your access to the Service at any time, with or without notice, for
        conduct that we believe violates these Terms or is harmful to other users, to us, or to third
        parties. Sections 5 through 12 survive termination.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">11. Governing law and venue</h2>
      <p>
        These Terms are governed by the laws of the State of Texas, without regard to its conflict-of-laws
        principles. Any dispute arising out of or relating to these Terms or the Service that is not
        subject to arbitration shall be brought exclusively in the state or federal courts located in
        Bexar County, Texas, and you consent to the personal jurisdiction of those courts.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">12. Dispute resolution and arbitration</h2>
      <p>
        Any dispute, claim, or controversy arising out of or relating to these Terms or the Service shall
        first be addressed by good-faith informal negotiation by emailing{' '}
        <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">support@tradepals.net</a>.
        If not resolved within 60 days, the dispute shall be settled by binding arbitration administered
        by the American Arbitration Association under its Consumer Arbitration Rules, with the seat of
        arbitration in Bexar County, Texas. <strong>You and TradePals each waive the right to a jury
        trial and the right to participate in a class action.</strong> Notwithstanding the foregoing,
        either party may seek injunctive relief in a court of competent jurisdiction to protect
        intellectual property rights.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">13. Apple-specific terms</h2>
      <p>
        If you downloaded WindPal from Apple's App Store, you acknowledge that these Terms are between
        you and TradePals only, not Apple, and that Apple has no obligation to provide maintenance or
        support for WindPal. Apple is a third-party beneficiary of these Terms and may enforce them
        against you. You also represent that you are not located in a country subject to a U.S. Government
        embargo and are not on any U.S. Government list of prohibited or restricted parties.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">14. Changes to these Terms</h2>
      <p>
        We may revise these Terms from time to time. If we make material changes we will notify you in the
        app and/or by email and update the "Effective date" above. Continued use after changes take effect
        constitutes acceptance.
      </p>

      <h2 className="text-xl font-bold text-white mt-6">15. Contact</h2>
      <p>
        TradePals, LLC<br />
        Bexar County, Texas, USA<br />
        Email: <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">support@tradepals.net</a>
      </p>
    </LegalPage>
  )
}
