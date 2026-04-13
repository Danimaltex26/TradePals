import ProductPage from '../../components/ProductPage'

export default function LiftPalProduct() {
  return (
    <ProductPage
      app="liftpal"
      description="Inspect elevator components from photos, troubleshoot controller faults and door problems, look up ASME A17.1 code requirements, and prep for CET and QEI certifications — from the machine room to the pit."
      longDescription={`Elevator and lift technicians maintain some of the most safety-critical equipment in any building — and callbacks cost time, money, and reputation. A technician staring at a relay-logic controller board needs to trace the fault before the building manager calls again. A modernization tech needs to verify that a new door operator meets current code before the inspector arrives. The stakes are real — people ride in the equipment you maintain.

LiftPal covers the full scope of elevator service. Photograph a worn sheave groove, a corroded controller board, a frayed hoist rope, or a misaligned door interlock and get an instant assessment with severity classification, code references, and recommended corrective action. The troubleshooting engine handles door operator faults, leveling problems, ride quality complaints, hydraulic valve issues, and controller fault codes across Otis, Schindler, ThyssenKrupp, Kone, and other major platforms.

The reference library includes ASME A17.1 code lookups, rope safety factor calculations, door timing requirements, pit depth tables, and governor speed settings. Quick-reference specs cover the parameters inspectors check most often.

From an apprentice elevator constructor learning to adjust door operators to a QEI inspector verifying code compliance across a portfolio, LiftPal is the code book, the troubleshooting manual, and the senior mechanic all in one app.`}
      features={[
        'Equipment photo analysis — controllers, doors, ropes, sheaves, governors, pit equipment',
        'Fault diagnosis — door problems, leveling, ride quality, hydraulic, controller faults',
        'Code reference — ASME A17.1 lookups, safety requirements, inspection criteria',
        'Quick specs — rope safety factors, door timing, clearances, governor trip speeds',
        'Safety reference — LOTO procedures, pit entry, car top operation, hoistway access',
        'Offline photo queue — capture in the hoistway, process when back on the ground',
        'Certification training — CET, QEI, and manufacturer cert prep',
      ]}
      screenshots={[
        { label: 'Equipment Inspection', beforeTitle: 'Photo the component', afterTitle: 'Severity + code references' },
        { label: 'Fault Diagnosis', beforeTitle: 'Enter symptoms & fault codes', afterTitle: 'Root cause + fix steps' },
      ]}
    />
  )
}
