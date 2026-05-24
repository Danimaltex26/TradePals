import CertPrepLandingPage from '../../components/CertPrepLandingPage'

// Apprentice Electrician exam-prep landing page on the marketing hub.
// URL: /voltpal/apprentice
// Drives traffic to the existing public practice quiz at voltpal.tradepals.net/apprentice-practice.

export default function VoltPalApprentice() {
  return (
    <CertPrepLandingPage
      app="voltpal"
      certCode="Apprentice"
      certName="Apprentice Electrician"
      certIssuer="State licensing board (varies by state)"

      metaTitle="Apprentice Electrician Exam Prep + NEC 2026 | VoltPal"
      metaDescription="Pass the apprentice exam and start your electrical apprenticeship strong. Free practice questions, full NEC fundamentals, and AI-powered study tools for first-year electricians."
      pathOverride="/voltpal/apprentice"

      hookHeadline="Start your apprenticeship strong."
      hookSubline="Master NEC fundamentals before you're on the job. Free practice quiz to see where you stand."
      overview="The apprentice electrician exam (aptitude test, JATC entrance test, or first-year competency exam — varies by state and program) covers the electrical fundamentals every apprentice should know before working on energized equipment. The 50-question test covers electrical theory, NEC code basics, wiring methods, residential wiring, and safety. VoltPal mirrors what most apprenticeship programs test and adds AI tutoring on every wrong answer."

      examInfo={{
        totalQuestions: 50,
        timeMinutes: 75,
        passPercent: 70,
        cost: 'Free–$200',
        renewalCycle: 'One-time entrance',
      }}

      domains={[
        { number: 1, name: 'Electrical Theory Fundamentals', questionCount: 13, weightPercent: 25, topics: ["Ohm's law", 'Series + parallel circuits', 'Kirchhoffs laws', 'AC vs DC', 'Power formula'] },
        { number: 2, name: 'NEC Code Basics', questionCount: 10, weightPercent: 20, topics: ['Article 90 scope', 'Article 100 definitions', 'Article 110 requirements', 'Code book navigation', 'Code cycles'] },
        { number: 3, name: 'Wiring Methods and Materials', questionCount: 10, weightPercent: 20, topics: ['NM-B Romex', 'MC cable', 'EMT + rigid conduit', 'Wire types THHN/THWN/XHHW', 'Conduit fill basics'] },
        { number: 4, name: 'Residential Wiring', questionCount: 10, weightPercent: 20, topics: ['Service entrance', 'GFCI/AFCI requirements', 'Branch circuits', 'Receptacle + lighting layout'] },
        { number: 5, name: 'Electrical Safety Fundamentals', questionCount: 7, weightPercent: 15, topics: ['Live-dead-live testing', 'PPE basics', 'OSHA + NFPA 70E intro', 'Lockout/tagout'] },
      ]}

      sampleQuestions={[
        {
          text: 'A homeowner is adding a family room addition with new 15-amp branch circuits supplying general lighting and receptacle outlets. What AFCI protection requirements apply?',
          options: [
            { key: 'A', text: 'AFCI protection is only required for bedroom circuits' },
            { key: 'B', text: 'AFCI protection is required for all 15- and 20-amp branch circuits in the family room' },
            { key: 'C', text: 'AFCI protection is only required for receptacle circuits, not lighting circuits' },
            { key: 'D', text: 'AFCI protection is not required for rooms under 500 sq ft' },
          ],
          correctAnswer: 'B',
          explanation: 'NEC 210.12(A) requires AFCI protection on all 120V, single-phase, 15- and 20-amp branch circuits supplying outlets or devices in dwelling unit family rooms, dining rooms, living rooms, bedrooms, dens, libraries, and similar spaces. The requirement covers BOTH lighting and receptacle circuits — and is not square-footage dependent.',
          standardReference: 'NEC 210.12(A)',
        },
        {
          text: 'According to Article 100, what defines a "qualified person" in the context of electrical work?',
          options: [
            { key: 'A', text: 'A person who has completed a four-year electrical apprenticeship program' },
            { key: 'B', text: 'A person who has passed a state licensing examination' },
            { key: 'C', text: 'One who has skills and knowledge related to the construction and operation of the electrical equipment and has received safety training on the hazards involved' },
            { key: 'D', text: "A person who holds a bachelor's degree in electrical engineering" },
          ],
          correctAnswer: 'C',
          explanation: 'Article 100 defines "Qualified Person" as one with skills + knowledge of the equipment AND safety training on the specific hazards involved. The definition is intentionally about competency + safety training together — not credentials. A licensed journeyman who has never worked on medium-voltage gear is NOT a qualified person for that work.',
          standardReference: 'NEC Article 100',
        },
        {
          text: 'A journeyman is installing conduit in a basement where ambient temperature regularly reaches 50°C (122°F) due to nearby boiler equipment. What must be considered regarding conductor ampacity?',
          options: [
            { key: 'A', text: 'Use standard ampacity tables since basement installations are exempt' },
            { key: 'B', text: 'Apply temperature correction factors from Table 310.15(B)(2)(a) based on 50°C ambient' },
            { key: 'C', text: 'Increase conductor size by one AWG size to compensate for heat' },
            { key: 'D', text: 'Install additional conduits to reduce conductor density' },
          ],
          correctAnswer: 'B',
          explanation: 'Per Article 110.14(C) and Article 310, when ambient temperature exceeds 30°C (86°F), temperature correction factors from Table 310.15(B)(2)(a) must be applied to conductor ampacities. At 50°C, the correction factor significantly reduces allowable ampacity — sizing up one AWG by intuition (Option C) is the wrong approach because the code prescribes specific multipliers.',
          standardReference: 'NEC 110.14(C), Table 310.15(B)(2)(a)',
        },
      ]}

      salaryBlock={{
        uncertifiedLabel: '1st-year Apprentice',
        uncertifiedRange: '$30K–$40K',
        certifiedLabel: '4th-year Apprentice',
        certifiedRange: '$50K–$60K',
        sourceLabel: 'IBEW apprenticeship scale (50–90% of journeyman rate by year) · BLS SOC 47-2111',
        note: 'IBEW apprentices typically start at 50–60% of journeyman scale and step up 5–10% per year. By year 4–5, you are at 80–90% of journeyman rate. Passing the entrance / first-year competency exam is the door to the apprenticeship — and to the $25K+ pay lift waiting at journeyman.',
      }}

      quizUrl="https://voltpal.tradepals.net/apprentice-practice"
      quizCtaLabel="Take the Free Apprentice Practice Quiz →"
      signupUrl="https://voltpal.tradepals.net/signup?utm_source=cert_prep&utm_medium=hub&utm_campaign=apprentice"
      signupCtaLabel="Try VoltPal Pro Free"

      faqs={[
        {
          q: 'Is the apprentice exam the same in every state?',
          a: 'No. The format depends on your path: IBEW/JATC programs use the Electrical Training Alliance Aptitude Test; non-union programs may use the NJATC test or a state-specific exam; some states test at the end of year 1 instead of for entry. The underlying content is universal NEC + electrical theory, which is what VoltPal covers.',
        },
        {
          q: 'How long does it take to prep?',
          a: 'Most candidates spend 4–8 weeks studying electrical theory, basic NEC navigation, and basic math (algebra + reading comprehension on most aptitude tests). VoltPal\'s readiness scoring shows you when you\'re consistently above the pass mark in each domain.',
        },
        {
          q: 'Do I need to know NEC code yet?',
          a: 'Not in depth — but you need to know how to navigate the code book, find articles, and apply basic rules (Article 100 definitions, Article 110, basic conductor sizing). The deep code application comes during your apprenticeship. VoltPal\'s Apprentice content focuses on what you need on day one.',
        },
        {
          q: 'What happens after the apprentice exam?',
          a: 'You start your apprenticeship — typically 4–5 years of on-the-job training (8,000+ hours) plus ~144 hours/year of related instruction. At the end you sit for the journeyman exam. VoltPal\'s training spans all three tiers — Apprentice → Journeyman → Master — so the app stays useful through your full career.',
        },
        {
          q: 'How much does the apprentice exam cost?',
          a: 'IBEW/JATC tests are typically free for applicants. State-administered tests run $40–$200 depending on the state. Non-union programs may charge $50–$150. VoltPal Pro is $12.95/mo — less than the test fee in most cases, with unlimited practice.',
        },
      ]}
    />
  )
}
