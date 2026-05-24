import CertPrepLandingPage from '../../components/CertPrepLandingPage'

// Master Electrician exam-prep landing page on the marketing hub.
// URL: /voltpal/master
// Drives traffic to the existing public practice quiz at voltpal.tradepals.net/master-practice.

export default function VoltPalMaster() {
  return (
    <CertPrepLandingPage
      app="voltpal"
      certCode="Master"
      certName="Master Electrician"
      certIssuer="State licensing board (varies by state)"

      metaTitle="Master Electrician Exam Prep + NEC 2026 | VoltPal"
      metaDescription="Pass the master electrician exam and unlock $75K–$100K+ jobs in data center, industrial, and renewable energy. Free practice questions + AI-powered study tools."
      pathOverride="/voltpal/master"

      hookHeadline="Pass master. Run your own work."
      hookSubline="Master license pays $15K–$25K+ over journeyman. Free practice quiz to see where you stand."
      overview="The master electrician license is the top tier of the electrical trade — required to pull permits, run your own shop, supervise journeymen, and bid commercial/industrial projects. The 100-question exam is the hardest in the trade: advanced load calculations, electrical system design, special occupancies (healthcare, hazardous locations, marinas), and business + code administration. VoltPal mirrors the most common state blueprint and adds AI tutoring on every wrong answer."

      examInfo={{
        totalQuestions: 100,
        timeMinutes: 150,
        passPercent: 75,
        cost: '$300–$1,500',
        renewalCycle: 'Varies (1–3 yrs)',
      }}

      domains={[
        { number: 1, name: 'Advanced Load Calculations and System Design', questionCount: 25, weightPercent: 25, topics: ['Dwelling unit + commercial load calcs', 'Optional vs standard methods', 'Demand factors Article 220', 'Service sizing'] },
        { number: 2, name: 'Electrical System Design and Engineering', questionCount: 25, weightPercent: 25, topics: ['Voltage drop + conductor sizing', 'Short-circuit calculations', 'Coordination studies', 'Power factor correction'] },
        { number: 3, name: 'Special Occupancies and Conditions', questionCount: 25, weightPercent: 25, topics: ['Healthcare facilities Article 517', 'Hazardous locations Articles 500–516', 'Assembly + theaters Articles 518–520', 'Marinas + boatyards Article 555'] },
        { number: 4, name: 'Business Management and Code Administration', questionCount: 25, weightPercent: 25, topics: ['Estimating + bidding', 'Plan reading + specifications', 'Permits + inspections', 'OSHA + state compliance'] },
      ]}

      sampleQuestions={[
        {
          text: 'An electrician is performing an arc flash analysis on a 480V MCC. The calculated incident energy is 12 cal/cm². The working distance is 18 inches. What PPE category is required?',
          options: [
            { key: 'A', text: 'PPE Category 1' },
            { key: 'B', text: 'PPE Category 2' },
            { key: 'C', text: 'PPE Category 3' },
            { key: 'D', text: 'PPE Category 4' },
          ],
          correctAnswer: 'C',
          explanation: 'PPE Category 3 covers incident energy from 8.1 to 25 cal/cm². The calculated 12 cal/cm² falls within this range. Category 1: ≤4 cal/cm². Category 2: 4.1–8 cal/cm². Category 4: 25.1–40 cal/cm². Above 40 cal/cm² requires an incident energy analysis with custom PPE — NFPA 70E does not assign a category above 40.',
          standardReference: 'NFPA 70E Table 130.5(C)',
        },
        {
          text: 'You are designing the electrical system for a new movie theater with 400 seats. What is the minimum emergency egress illumination level required?',
          options: [
            { key: 'A', text: '0.5 foot-candles measured at floor level' },
            { key: 'B', text: '1.0 foot-candle average with 0.1 minimum at floor level' },
            { key: 'C', text: '2.0 foot-candles average with 0.5 minimum at floor level' },
            { key: 'D', text: '5.0 foot-candles measured at 3 feet above floor level' },
          ],
          correctAnswer: 'B',
          explanation: 'Article 518.4(B) references the Life Safety Code (NFPA 101) which requires emergency lighting to provide 1.0 fc average with 0.1 fc minimum at floor level along the path of egress. The average-with-minimum spec matters: a hallway with 5 fc bright spots and 0.05 fc dim spots fails even if the math averages to 1 fc.',
          standardReference: 'NEC Article 518.4(B) / NFPA 101',
        },
        {
          text: 'A commercial kitchen contains: (4) 6 kW fryers, (2) 8 kW ovens, (3) 3.5 kW griddles, (1) 12 kW range, and (2) 2 kW warmers. All equipment is thermostatically controlled. Using NEC Table 220.56, what is the demand load?',
          options: [
            { key: 'A', text: '45.5 kW' },
            { key: 'B', text: '52.8 kW' },
            { key: 'C', text: '58.2 kW' },
            { key: 'D', text: '65.5 kW' },
          ],
          correctAnswer: 'B',
          explanation: 'Total connected load: (4×6) + (2×8) + (3×3.5) + 12 + (2×2) = 24 + 16 + 10.5 + 12 + 4 = 66.5 kW. Per NEC Table 220.56, demand factors for thermostatically controlled commercial cooking equipment with 6+ units: first 50 kW at 100%, remaining at ~80%. The math works to ~52.8 kW. This is exactly the kind of multi-step calc that trips up master candidates.',
          standardReference: 'NEC Table 220.56',
        },
      ]}

      salaryBlock={{
        uncertifiedLabel: 'Journeyman',
        uncertifiedRange: '$55K–$75K',
        certifiedLabel: 'Master Electrician',
        certifiedRange: '$75K–$100K+',
        sourceLabel: 'BLS SOC 47-2111 + IBEW/NECA + Zippia master-electrician wage data',
        note: 'Master license is the second biggest pay multiplier after journeyman — +$15K–$25K/yr on top of the journeyman bump. Specializations push higher: renewable energy + industrial automation routinely $100K+. Master license also unlocks contractor work (you can pull permits, run your own shop, bid larger commercial jobs), which is where the real money is.',
      }}

      quizUrl="https://voltpal.tradepals.net/master-practice"
      quizCtaLabel="Take the Free Master Practice Quiz →"
      signupUrl="https://voltpal.tradepals.net/signup?utm_source=cert_prep&utm_medium=hub&utm_campaign=master"
      signupCtaLabel="Try VoltPal Pro Free"

      faqs={[
        {
          q: 'How is the master exam different from journeyman?',
          a: 'Master tests design + supervision, not just installation. Expect deep load calcs (commercial dwelling units, multi-family, optional method), special occupancies (Articles 500-series for hazardous, 517 for healthcare, 555 for marinas), short-circuit + voltage-drop calculations, and a business/code-administration section that journeyman skips entirely. The pass mark is also higher — 75% in most states vs 70% for journeyman.',
        },
        {
          q: 'How long should I study for master?',
          a: 'Most journeymen study 3–6 months while continuing to work. The blueprint is broader than journeyman and the calculations are deeper. VoltPal\'s readiness scoring tells you specifically when your weak-area drills are paying off — particularly the Special Occupancies domain, which is the section most candidates underestimate.',
        },
        {
          q: 'Do I need experience hours to sit for the master exam?',
          a: 'Yes. Most states require 2–4 years (3,000–8,000 hours) of work as a licensed journeyman before you can sit for master. A few states also require a specific number of supervisory hours. The hours requirement is the bigger gate than the exam itself.',
        },
        {
          q: 'What can I do with a master license that I can\'t do as a journeyman?',
          a: 'Pull electrical permits, run your own electrical contracting business, supervise journeymen on a job site, sign-off on inspections, bid commercial/industrial projects, and act as the qualifying party for a contractor license. In most states, master is the only path to owning your own electrical company legally.',
        },
        {
          q: 'How much does the master exam cost?',
          a: 'Exam fees range $100–$300. Prep courses run $400–$1,500 depending on length and depth. Total typical out-of-pocket is $300–$1,500. VoltPal Pro is $12.95/mo — less than a single prep-course session, with unlimited practice and AI tutoring across all 4 domains.',
        },
      ]}
    />
  )
}
