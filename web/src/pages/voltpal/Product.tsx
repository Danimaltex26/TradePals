import ProductPage from '../../components/ProductPage'

export default function VoltPalProduct() {
  return (
    <ProductPage
      app="voltpal"
      languageToggle={{ enPath: '/voltpal', esPath: '/voltpal/es', currentLang: 'en' }}
      // Cert-first hero — Option A style
      certHook="Pass journeyman on the first try. Win the data-center boom."
      certSubhook="Journeyman pays $25K+ more than apprentice. VoltPal gets you there."
      description="AI electrical companion + NEC 2026 + journeyman exam prep, built for apprentices, journeymen, and master electricians. Diagnose panels, troubleshoot motors and VFDs, look up code, and study for the exam — all from your phone."
      quizUrl="https://voltpal.tradepals.net/journeyman-practice"
      stats={[
        { value: '81,000/yr', label: 'Electrician openings through 2034', source: 'BLS Occupational Outlook (SOC 47-2111)' },
        { value: '+$25K/yr', label: 'Journeyman vs apprentice pay lift', source: 'BLS 2024 median + industry surveys' },
        { value: '45–70%', label: 'Of data center build cost is electrical', source: 'CBRE / construction industry surveys' },
        { value: '+$10/hr', label: 'IBEW union electrician premium', source: 'PTTI / NEIEP wage data' },
      ]}
      salaryBlock={{
        uncertifiedRange: '$30K–$55K',
        certifiedRange: '$55K–$75K',
        sourceLabel: 'BLS SOC 47-2111 (2024 median $62,350) + IBEW/NECA state wage surveys',
        note: 'Journeyman license is the single biggest pay multiplier in the trade — +$25K/yr over apprentice. Master electricians earn $75K–$100K+, especially in renewable energy and industrial. IBEW union electricians earn ~$10/hr more than non-union peers, with total comp 30–40% higher in gateway markets. With 81,000 openings per year through 2034 and a 9% growth rate, licensed techs are in a seller\'s market.',
      }}
      certTrustLine="NEC 2026 in your pocket · Apprentice · Journeyman · Master Electrician · NFPA 70E"
      longDescription={`The electrical trade spans everything from residential panel swaps to industrial VFD commissioning — and the NEC gets thicker every cycle. An apprentice wiring their first sub-panel needs to know conductor sizing, breaker coordination, and grounding requirements. A journeyman troubleshooting a VFD ground fault needs to know whether to megger the motor or check the cable before resetting. The knowledge required is vast, and the consequences of getting it wrong are serious.

VoltPal covers the full spectrum. Photograph a panel, a burned contactor, a motor nameplate, or a tripped VFD display and get an instant diagnosis with NEC code references and severity rankings. The troubleshooting wizard covers 27 equipment types — from residential GFCI outlets and ceiling fans to industrial PLCs and medium-voltage disconnects — with brand-specific guidance for Allen-Bradley, Siemens, ABB, Eaton, Square D, and dozens more.

The wire sizing calculator factors in both ampacity (NEC 310.16) and voltage drop — showing you when a long run requires upsizing beyond the minimum code requirement. The conduit fill calculator handles NEC Chapter 9 tables so you don't have to. The motor FLA tables cover single-phase and three-phase with the NEC 430 sizing rules that trip up even experienced electricians.

From a first-year apprentice studying for their state exam to a master electrician quoting a service upgrade, VoltPal is the code book, the reference card, and the senior tech all in one app.`}
      features={[
        'Apprentice, Journeyman, Master, NFPA 70E exam prep — timed mocks, weak-area drills, readiness scoring',
        'Panel & fault photo diagnosis — code violations, burn marks, improper wiring',
        'Troubleshooting — 27 equipment types, 200+ brand/model options',
        'Wire sizing calculator — ampacity + voltage drop, copper & aluminum',
        'Conduit fill calculator — NEC Chapter 9, EMT/IMC/RMC',
        'Motor FLA tables — single & three phase, NEC 430 sizing rules',
        'NEC code reference — GFCI, AFCI, grounding, overcurrent, motor circuits',
        'Arc flash / LOTO safety reference — NFPA 70E PPE categories',
        'Offline photo queue — capture on-site, process when connected',
      ]}
      screenshots={[
        { label: 'Panel / Fault Analysis', beforeTitle: 'Photo the panel or fault', afterTitle: 'Code violations + severity ranking' },
        { label: 'VFD / Motor Troubleshoot', beforeTitle: 'Enter fault code & equipment', afterTitle: 'Root cause + wiring fix steps' },
      ]}
    />
  )
}
