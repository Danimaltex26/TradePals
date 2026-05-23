import CertPrepLandingPage from '../../components/CertPrepLandingPage'

// CFOT exam-prep landing page on the marketing hub.
// URL: /splicepal/cfot
// CTA flows to the existing public practice quiz at splicepal.tradepals.net/cfot-practice.
//
// Distinct from /splicepal/certprep (auth-gated practice tool).
// Exam blueprint mirrors SplicePal server's config/examBlueprints.js.
// Salary block + cert cost verified earlier (PayScale + Glassdoor + DataX Connect + BLS SOC 49-2022).

export default function SplicePalCfot() {
  return (
    <CertPrepLandingPage
      app="splicepal"
      certCode="CFOT"
      certName="Certified Fiber Optic Technician"
      certIssuer="FOA (Fiber Optic Association)"

      metaTitle="CFOT Exam Prep — Certified Fiber Optic Technician | SplicePal"
      metaDescription="Pass CFOT on the first try with free practice questions, full exam blueprint, and AI-powered study tools built for fiber splicers and OSP techs."
      pathOverride="/splicepal/cfot"

      hookHeadline="Pass CFOT on the first try."
      hookSubline="CFOT pays for itself in ~6 months. Free practice quiz to see where you stand."
      overview="The FOA Certified Fiber Optic Technician (CFOT) is the foundational fiber-optic certification — required by most ISPs, telcos, and BEAD-funded contractors. The 100-question exam covers everything from fusion splicing to OTDR trace analysis to OSP installation. SplicePal's training mirrors the FOA blueprint exactly and adds AI tutoring on every wrong answer."

      examInfo={{
        totalQuestions: 100,
        timeMinutes: 150,
        passPercent: 70,
        cost: '$650–$2,000',
        renewalCycle: 'Every 3 years',
      }}

      domains={[
        { number: 1, name: 'Advanced Fiber Theory', questionCount: 15, weightPercent: 15, topics: ['NA + acceptance angle', 'Dispersion (modal, chromatic, PMD)', 'Wavelength windows', 'Singlemode vs multimode'] },
        { number: 2, name: 'Fusion Splicing', questionCount: 20, weightPercent: 20, topics: ['Cleave quality', 'Arc parameters', 'Core alignment (PAS, LID)', 'Splice loss targets'] },
        { number: 3, name: 'OTDR Theory', questionCount: 15, weightPercent: 15, topics: ['Backscatter principles', 'Dead zones', 'Pulse width selection', 'Bidirectional averaging'] },
        { number: 4, name: 'OTDR Trace Analysis', questionCount: 15, weightPercent: 15, topics: ['Event identification', 'Gainer detection', 'Macrobend vs splice', 'Reflectance values'] },
        { number: 5, name: 'OSP Installation', questionCount: 15, weightPercent: 15, topics: ['Aerial + buried', 'Loose tube vs ribbon', 'Closure prep', 'Pull tension limits'] },
        { number: 6, name: 'ISP Installation', questionCount: 10, weightPercent: 10, topics: ['Riser + plenum cable', 'Distribution + zone', 'Patch panels', 'Bend radius'] },
        { number: 7, name: 'Fiber Networks', questionCount: 5, weightPercent: 5, topics: ['PON + GPON', 'WDM + DWDM', 'Network topologies'] },
        { number: 8, name: 'Standards', questionCount: 5, weightPercent: 5, topics: ['TIA-568', 'ITU-T G.652–G.657', 'IEC 61300'] },
      ]}

      sampleQuestions={[
        {
          text: 'At what wavelength does standard singlemode fiber (ITU-T G.652) have zero chromatic dispersion?',
          options: [
            { key: 'A', text: '1270 nm' },
            { key: 'B', text: '1310 nm' },
            { key: 'C', text: '1490 nm' },
            { key: 'D', text: '1550 nm' },
          ],
          correctAnswer: 'B',
          explanation: 'Standard G.652 singlemode fiber is engineered so that material and waveguide dispersion cancel out around 1310 nm — the historical "zero-dispersion wavelength." 1550 nm has lower attenuation but exhibits significant chromatic dispersion in standard SMF (which is why dispersion-shifted G.653 / NZ-DSF G.655 were developed for long-haul DWDM).',
          standardReference: 'ITU-T G.652',
        },
        {
          text: 'What is the dead zone in OTDR measurements?',
          options: [
            { key: 'A', text: 'The distance beyond which no signal can be detected' },
            { key: 'B', text: 'The distance after a reflective event where accurate measurements cannot be made' },
            { key: 'C', text: 'The fiber length that exceeds the OTDR\'s maximum range' },
            { key: 'D', text: 'The area of fiber where bending losses occur' },
          ],
          correctAnswer: 'B',
          explanation: 'The dead zone is the recovery period after a strong reflection (typically a connector) during which the OTDR receiver is saturated and cannot resolve closely-spaced events. Event dead zone (~1–5 m) limits how close two events can be distinguished; attenuation dead zone (~5–20 m) limits how soon after an event you can accurately measure loss. Both shrink with shorter pulse widths.',
        },
        {
          text: 'What is the typical splice loss target for single-mode fiber fusion splicing using modern core alignment equipment?',
          options: [
            { key: 'A', text: 'Less than 0.05 dB' },
            { key: 'B', text: 'Less than 0.1 dB' },
            { key: 'C', text: 'Less than 0.3 dB' },
            { key: 'D', text: 'Less than 0.5 dB' },
          ],
          correctAnswer: 'A',
          explanation: 'Modern core-alignment fusion splicers (Fujikura, Sumitomo, Fitel) routinely achieve <0.05 dB on identical SMF under good cleave + clean conditions. The TIA-568 / ANSI-OSP acceptance limit is typically 0.3 dB, but that\'s the maximum allowable — not what a CFOT-certified splicer should be aiming for. If your average is above 0.1 dB, suspect cleave quality or contamination before blaming the splicer.',
        },
      ]}

      salaryBlock={{
        uncertifiedLabel: 'Uncertified',
        uncertifiedRange: '$45K–$60K',
        certifiedLabel: 'CFOT Certified',
        certifiedRange: '$55K–$75K',
        sourceLabel: 'PayScale & Glassdoor (CFOT holders, 2026) · DataX Connect 2025 · BLS SOC 49-2022 baseline',
        note: 'CFOT pays for itself in ~6 months. PayScale puts the CFOT-holder median at ~$69K; uncertified splicers average ~$55K. The ~$10K/yr delta covers the $650–$2,000 cert cost in under half a year — and unlocks BEAD-funded contract work and data-center rates ($34.80/hr avg, often $85K+ with shift differentials).',
      }}

      quizUrl="https://splicepal.tradepals.net/cfot-practice"
      quizCtaLabel="Take the Free CFOT Practice Quiz →"
      signupUrl="https://splicepal.tradepals.net/signup?utm_source=cert_prep&utm_medium=hub&utm_campaign=cfot"
      signupCtaLabel="Try SplicePal Pro Free"

      faqs={[
        {
          q: 'How long does it take to prep for CFOT?',
          a: 'Most candidates take 4–8 weeks of focused study, assuming hands-on splicing experience. The FOA recommends 70+ hours of study time. SplicePal\'s readiness scoring shows you exactly when you\'re consistently above the 70% pass mark in each of the 8 domains.',
        },
        {
          q: 'How much does the CFOT cost?',
          a: 'The exam itself runs $200–$500 through an FOA-approved training organization. Add a prep course ($400–$1,500) and the total typically lands at $650–$2,000. SplicePal Pro is $12.95/mo or $89.95/yr — a fraction of a single-day prep course, with unlimited practice and AI tutoring.',
        },
        {
          q: 'Do I need to take an FOA-approved course before sitting the exam?',
          a: 'Yes — CFOT is administered through FOA-approved training organizations after a course or skills assessment. SplicePal is a study tool, not an FOA-approved testing center; we\'re what you use during and after the course to lock in the material and pass on the first try.',
        },
        {
          q: 'How often does the CFOT need to be renewed?',
          a: 'Every 3 years through FOA membership maintenance and continuing education credits (typically 6 CEUs per cycle). The renewal cycle is also a re-engagement moment for the underlying standards updates.',
        },
        {
          q: 'Will CFOT help me get on a BEAD project?',
          a: 'Yes — the $42.45B BEAD broadband program is rolling out across all 50 states, and most contractors require fiber-certified technicians on crews. CFOT is the most widely-recognized entry credential and the BEAD buildout is creating an unprecedented demand spike for licensed splicers through at least 2032.',
        },
      ]}
    />
  )
}
