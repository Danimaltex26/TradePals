import ProductPage from '../../components/ProductPage'

export default function VoltPalProduct() {
  return (
    <ProductPage
      app="voltpal"
      description="Diagnose electrical faults from photos, troubleshoot motors, VFDs, PLCs, and breakers, look up NEC codes and wire sizing, and prep for apprentice and journeyman exams — all from your phone on the jobsite."
      longDescription={`The electrical trade spans everything from residential panel swaps to industrial VFD commissioning — and the NEC gets thicker every cycle. An apprentice wiring their first sub-panel needs to know conductor sizing, breaker coordination, and grounding requirements. A journeyman troubleshooting a VFD ground fault needs to know whether to megger the motor or check the cable before resetting. The knowledge required is vast, and the consequences of getting it wrong are serious.

VoltPal covers the full spectrum. Photograph a panel, a burned contactor, a motor nameplate, or a tripped VFD display and get an instant diagnosis with NEC code references and severity rankings. The troubleshooting wizard covers 27 equipment types — from residential GFCI outlets and ceiling fans to industrial PLCs and medium-voltage disconnects — with brand-specific guidance for Allen-Bradley, Siemens, ABB, Eaton, Square D, and dozens more.

The wire sizing calculator factors in both ampacity (NEC 310.16) and voltage drop — showing you when a long run requires upsizing beyond the minimum code requirement. The conduit fill calculator handles NEC Chapter 9 tables so you don't have to. The motor FLA tables cover single-phase and three-phase with the NEC 430 sizing rules that trip up even experienced electricians.

From a first-year apprentice studying for their state exam to a master electrician quoting a service upgrade, VoltPal is the code book, the reference card, and the senior tech all in one app.`}
      features={[
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
