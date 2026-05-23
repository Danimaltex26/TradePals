import CertPrepLandingPage from '../../components/CertPrepLandingPage'

// Journeyman electrician exam-prep landing page on the marketing hub.
// URL: /voltpal/journeyman
// CTA flows to the existing public practice quiz at voltpal.tradepals.net/journeyman-practice.
//
// Distinct from /voltpal/certprep (auth-gated practice tool).
// Exam blueprint mirrors VoltPal server's config/examBlueprints.js JOURNEYMAN entry.
// Salary block + BLS data verified earlier (BLS SOC 47-2111 + IBEW/NECA + PayScale).

export default function VoltPalJourneyman() {
  return (
    <CertPrepLandingPage
      app="voltpal"
      certCode="Journeyman"
      certName="Journeyman Electrician"
      certIssuer="State licensing board (varies by state)"

      metaTitle="Journeyman Electrician Exam Prep + NEC 2026 | VoltPal"
      metaDescription="Pass journeyman on the first try. Free practice questions, full exam blueprint, NEC 2026 reference, and AI-powered study tools for apprentice + journeyman electricians."
      pathOverride="/voltpal/journeyman"

      hookHeadline="Pass journeyman on the first try."
      hookSubline="Journeyman pays $25K+ more than apprentice. Free practice quiz to see where you stand."
      overview="The journeyman electrician license is the single biggest pay multiplier in the trade — and the toughest exam in most states. The 80-question test covers NEC code application, motor circuits, grounding, transformers, and troubleshooting. VoltPal's training mirrors the most common state exam blueprint and adds AI tutoring on every wrong answer, with NEC 2026 references built in."

      examInfo={{
        totalQuestions: 80,
        timeMinutes: 120,
        passPercent: 70,
        cost: '$500–$1,500',
        renewalCycle: 'Varies (2–3 yrs)',
      }}

      domains={[
        { number: 1, name: 'Advanced NEC Code Application', questionCount: 16, weightPercent: 20, topics: ['Article 210 branch circuits', 'Article 220 load calcs', 'Article 250 grounding', 'Chapter 9 tables'] },
        { number: 2, name: 'Motor Circuits and Controls', questionCount: 16, weightPercent: 20, topics: ['Article 430 sizing', 'FLA + locked rotor', 'Overload + short-circuit protection', 'Motor disconnects'] },
        { number: 3, name: 'Commercial and Industrial Wiring', questionCount: 16, weightPercent: 20, topics: ['Feeders + branch circuits', 'Panelboards + switchboards', 'Conduit fill', 'Voltage drop'] },
        { number: 4, name: 'Grounding and Bonding', questionCount: 16, weightPercent: 20, topics: ['Service grounding', 'Equipment grounding conductor sizing', 'Bonding jumpers', 'Ground-fault paths'] },
        { number: 5, name: 'Transformers and Power Distribution', questionCount: 8, weightPercent: 10, topics: ['Single + 3-phase', 'Delta vs wye', 'Transformer sizing', 'Secondary connections'] },
        { number: 6, name: 'Troubleshooting and Testing', questionCount: 8, weightPercent: 10, topics: ['Megger + insulation', 'Ground continuity', 'Voltage testing', 'Motor diagnostics'] },
      ]}

      sampleQuestions={[
        {
          text: 'An electrician is installing a main bonding jumper for a 400-amp service with three sets of 500 kcmil copper service entrance conductors run in parallel. What is the minimum size copper main bonding jumper required?',
          options: [
            { key: 'A', text: '2/0 AWG' },
            { key: 'B', text: '3/0 AWG' },
            { key: 'C', text: '350 kcmil' },
            { key: 'D', text: '500 kcmil' },
          ],
          correctAnswer: 'C',
          explanation: 'Per NEC 250.28(D) and Table 250.102(C)(1), the main bonding jumper must be sized based on the area of the largest service entrance conductor on the line side of the service disconnect. With three sets of 500 kcmil in parallel, the total area is 1500 kcmil. The table requires a copper main bonding jumper of 350 kcmil for that area.',
          standardReference: 'NEC 250.28(D), Table 250.102(C)(1)',
        },
        {
          text: 'A contractor is installing a feeder tap connection to an existing 800-ampere busway system. The tap conductors are 25 feet long and will supply a 200-ampere panelboard. What is the minimum ampacity required for the tap conductors?',
          options: [
            { key: 'A', text: '160 amperes' },
            { key: 'B', text: '200 amperes' },
            { key: 'C', text: '240 amperes' },
            { key: 'D', text: '267 amperes' },
          ],
          correctAnswer: 'D',
          explanation: 'Per NEC 368.17(C), busway tap conductors must have an ampacity of not less than one-third the rating of the overcurrent device protecting the busway, or not less than the ampacity of the load-side conductor — whichever is greater. One-third of 800 A equals 267 A, which governs over the 200 A panelboard load.',
          standardReference: 'NEC 368.17(C)',
        },
        {
          text: 'According to NEC Article 392, what is the maximum allowable sag for cable tray spans between supports?',
          options: [
            { key: 'A', text: '1 inch in 8 feet' },
            { key: 'B', text: '1 inch in 10 feet' },
            { key: 'C', text: '1 inch in 12 feet' },
            { key: 'D', text: '1 inch in 15 feet' },
          ],
          correctAnswer: 'C',
          explanation: 'NEC Article 392 specifies that cable trays shall not have a sag exceeding 1 inch in 12 feet between supports. This is a structural-integrity rule to prevent cable damage from prolonged stress. The other answers represent common distractors — knowing the actual ratio is a quick-recall point on the exam.',
          standardReference: 'NEC Article 392',
        },
      ]}

      salaryBlock={{
        uncertifiedLabel: 'Apprentice',
        uncertifiedRange: '$30K–$55K',
        certifiedLabel: 'Journeyman',
        certifiedRange: '$55K–$75K',
        sourceLabel: 'BLS SOC 47-2111 (2024 median $62,350) + IBEW/NECA state wage surveys',
        note: 'Journeyman license is the single biggest pay multiplier in the trade — +$25K/yr over apprentice. Master electricians earn $75K–$100K+, especially in renewable energy and industrial. IBEW union electricians earn ~$10/hr more than non-union peers, with total comp 30–40% higher in gateway markets. With 81,000 openings per year through 2034, licensed techs are in a seller\'s market.',
      }}

      quizUrl="https://voltpal.tradepals.net/journeyman-practice"
      quizCtaLabel="Take the Free Journeyman Practice Quiz →"
      signupUrl="https://voltpal.tradepals.net/signup?utm_source=cert_prep&utm_medium=hub&utm_campaign=journeyman"
      signupCtaLabel="Try VoltPal Pro Free"

      faqs={[
        {
          q: 'How long does it take to prep for the journeyman exam?',
          a: 'Most apprentices study 8–16 weeks while finishing the on-the-job hours required by their state (typically 4,000–8,000 hours). VoltPal\'s readiness scoring tells you when you\'re consistently above the 70% pass mark in each domain — particularly NEC code application and grounding, the two domains that trip up the most candidates.',
        },
        {
          q: 'How much does the journeyman exam cost?',
          a: 'Exam fees range $75–$200 depending on the state. Prep courses run $300–$1,000. Total typical out-of-pocket is $500–$1,500. VoltPal Pro is $12.95/mo or $89.95/yr — less than a single prep-course session, with unlimited practice and AI tutoring on NEC code questions.',
        },
        {
          q: 'Is the journeyman exam different in each state?',
          a: 'Yes. Most states use a variant of the ICC or PSI national exam with state-specific amendments. Texas, California, and Florida have their own state-administered tests. Core NEC content is the same everywhere; VoltPal\'s training focuses on the universal NEC + the most common state amendment patterns.',
        },
        {
          q: 'Do I need IBEW or union affiliation to take the journeyman exam?',
          a: 'No. The license is state-issued and doesn\'t require union membership. That said — IBEW journeymen earn ~$10/hr more on average and have access to better benefits packages in unionized markets (NYC, Chicago, Seattle, San Francisco). The license is what unlocks the union job, not the other way around.',
        },
        {
          q: 'Does NEC 2026 affect the exam?',
          a: 'Yes — when your state adopts NEC 2026 (most states adopt within 1–2 years of publication), the exam updates to the new code. VoltPal automatically updates the question bank when each NEC cycle ships, so you\'re always studying against the version your state is testing on.',
        },
      ]}
    />
  )
}
