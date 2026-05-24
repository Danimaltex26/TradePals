import CertPrepLandingPage from '../../components/CertPrepLandingPage'

// NFPA 70E exam-prep landing page on the marketing hub.
// URL: /voltpal/nfpa-70e
// Drives traffic to the existing public practice quiz at voltpal.tradepals.net/nfpa-70e-practice.
//
// Different framing from license tiers — NFPA 70E is a safety standard, not a pay-tier
// license. Hook is "employer-required, annual, don't burn a Saturday on it."

export default function VoltPalNfpa70e() {
  return (
    <CertPrepLandingPage
      app="voltpal"
      certCode="NFPA 70E"
      certName="NFPA 70E Standard for Electrical Safety in the Workplace"
      certIssuer="National Fire Protection Association (NFPA)"

      metaTitle="NFPA 70E Practice Test + Arc Flash Safety Prep | VoltPal"
      metaDescription="Pass NFPA 70E without burning a Saturday. Free practice questions on arc flash, shock hazard, PPE categories, and LOTO. AI-powered study tool for industrial electricians."
      pathOverride="/voltpal/nfpa-70e"

      hookHeadline="Pass NFPA 70E without burning a Saturday."
      hookSubline="Arc-flash-rated work requires it. Most electricians dread it. Get it done in a week."
      overview="NFPA 70E is the electrical safety standard most industrial and commercial employers require annually — and it's the gate to working on energized equipment, data center maintenance, and arc-flash-rated jobs. The 60-question exam covers electrical safety programs, shock hazard analysis, arc flash hazard analysis, PPE categories, and lockout/tagout. VoltPal walks you through all 4 domains with AI tutoring on every wrong answer."

      examInfo={{
        totalQuestions: 60,
        timeMinutes: 90,
        passPercent: 70,
        cost: '$150–$600',
        renewalCycle: 'Annually (employer-required)',
      }}

      domains={[
        { number: 1, name: 'Electrical Safety Program', questionCount: 15, weightPercent: 25, topics: ['Article 105 + 110 requirements', 'Energized work permits', 'Safety program elements', 'Audit requirements'] },
        { number: 2, name: 'Shock Hazard Analysis', questionCount: 15, weightPercent: 25, topics: ['Limited approach boundary', 'Restricted approach boundary', 'Test instrument safety', 'Live-dead-live testing'] },
        { number: 3, name: 'Arc Flash Hazard Analysis', questionCount: 18, weightPercent: 30, topics: ['Incident energy calculation', 'Arc flash boundary', 'PPE Categories Table 130.7(C)(15)', 'Equipment labeling 130.5(H)'] },
        { number: 4, name: 'Lockout/Tagout and Safe Work Practices', questionCount: 12, weightPercent: 20, topics: ['Article 120 LOTO requirements', 'Complex lockout procedures', 'Group lockout', 'Temporary grounding'] },
      ]}

      sampleQuestions={[
        {
          text: 'A maintenance supervisor needs to calculate the arc flash boundary for 4160V switchgear with an incident energy of 8.5 cal/cm² at 24 inches working distance. What is the approximate arc flash boundary?',
          options: [
            { key: 'A', text: '48 inches' },
            { key: 'B', text: '36 inches' },
            { key: 'C', text: '60 inches' },
            { key: 'D', text: '72 inches' },
          ],
          correctAnswer: 'B',
          explanation: 'The arc flash boundary is the distance where incident energy equals 1.2 cal/cm² (the burn threshold for bare skin). Since incident energy drops with distance squared, and we know 8.5 cal/cm² at 24 inches, the boundary works to approximately 36 inches. This is one of the most common arc-flash calculations on the exam and in field labels.',
          standardReference: 'NFPA 70E 130.5(G)',
        },
        {
          text: 'A facility manager discovers a 2000A, 480V switchboard arc flash label showing 45 cal/cm². Workers need to perform infrared scanning with the equipment energized. What PPE approach should be implemented?',
          options: [
            { key: 'A', text: 'Use PPE Category 4 which covers up to 40 cal/cm²' },
            { key: 'B', text: 'Perform incident energy analysis to select appropriate PPE exceeding 40 cal/cm²' },
            { key: 'C', text: 'De-energize the equipment since it exceeds Category 4 limits' },
            { key: 'D', text: 'Use Category 3 PPE with additional face protection' },
          ],
          correctAnswer: 'B',
          explanation: 'When incident energy exceeds 40 cal/cm² (the upper limit of PPE Category 4), NFPA 70E requires an incident energy analysis to select PPE with arc ratings that meet or exceed the calculated incident energy. The categories table doesn\'t cover above 40 cal/cm² — you have to spec custom PPE per the analysis. De-energizing is preferable when feasible (hierarchy of controls), but the question specifies the work requires energized equipment.',
          standardReference: 'NFPA 70E 130.5(G), 130.7(C)(15)',
        },
        {
          text: 'An electrician is preparing maintenance on a 480V MCC with three separate disconnects feeding different sections. The work requires coordination with two other trades on connected equipment. According to NFPA 70E Article 120, what type of lockout procedure is required?',
          options: [
            { key: 'A', text: 'Simple lockout with master lock' },
            { key: 'B', text: 'Complex lockout procedure' },
            { key: 'C', text: 'Group lockout procedure' },
            { key: 'D', text: 'Individual lockout by each worker' },
          ],
          correctAnswer: 'B',
          explanation: 'A complex lockout procedure is required when the lockout involves multiple energy sources (three disconnects here) AND coordination between multiple workers/trades. Simple lockout (A) applies to single-source, single-worker scenarios. Group lockout (C) is for multiple workers but typically single-source. Individual lockout (D) doesn\'t address the multi-source coordination requirement. NFPA 70E specifically calls for written complex lockout procedures in this scenario.',
          standardReference: 'NFPA 70E Article 120.2',
        },
      ]}

      quizUrl="https://voltpal.tradepals.net/nfpa-70e-practice"
      quizCtaLabel="Take the Free NFPA 70E Practice Quiz →"
      signupUrl="https://voltpal.tradepals.net/signup?utm_source=cert_prep&utm_medium=hub&utm_campaign=nfpa_70e"
      signupCtaLabel="Try VoltPal Pro Free"

      faqs={[
        {
          q: 'Is NFPA 70E a license?',
          a: 'No — it is a safety standard, not a license. There is no "NFPA 70E certified electrician" credential the way there is for journeyman or master. What you take is a course + competency test demonstrating you understand the standard. Most employers require annual refresher training and a passing score on a competency exam before you work on energized equipment.',
        },
        {
          q: 'Who requires NFPA 70E?',
          a: 'OSHA enforces NFPA 70E through the General Duty Clause. Industrial employers (manufacturing, data centers, utilities, refineries), commercial contractors doing energized work, and any employer with arc-flash-rated equipment require it. If you work on or near energized industrial gear, you need it.',
        },
        {
          q: 'How long does NFPA 70E prep take?',
          a: '1–2 weeks of focused study is typical if you already work in industrial or commercial. The arc-flash math (boundary calculations, incident energy, PPE categories) is the bulk of what trips people up. VoltPal\'s readiness scoring shows you when you\'re consistently above the 70% pass mark across all 4 domains.',
        },
        {
          q: 'How much does NFPA 70E training cost?',
          a: 'Employer-provided training is often free for employees. Public courses run $150–$600 for a 1-day class with exam included. VoltPal Pro is $12.95/mo — useful for the refresher or as study material before a paid class to make the most of your seat time.',
        },
        {
          q: 'How often do I need to retake?',
          a: 'NFPA 70E requires annual refresher training and competency reassessment for workers exposed to electrical hazards. Most employers run this as a 1-day annual training. Standalone NFPA 70E courses are typically valid 1–3 years depending on the provider. The standard itself updates every 3 years; the most recent edition is NFPA 70E-2024.',
        },
      ]}
    />
  )
}
