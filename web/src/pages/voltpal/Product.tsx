import ProductPage from '../../components/ProductPage'

export default function VoltPalProduct() {
  return (
    <ProductPage
      app="voltpal"
      description="Diagnose electrical faults from photos, troubleshoot motors, VFDs, PLCs, and breakers, look up NEC codes and wire sizing, and prep for apprentice and journeyman exams — all from your phone on the jobsite."
      features={[
        'Photo-based panel and fault diagnosis',
        'Structured troubleshooting for motors, VFDs, PLCs, and breakers',
        'NEC code reference & wire sizing calculators',
        'Apprentice / journeyman exam prep',
        'History of every analysis you run',
        'Works on iOS and any modern browser',
      ]}
      screenshots={[
        { label: 'Panel / Fault Analysis', beforeTitle: 'Photo the panel or fault', afterTitle: 'Code violations + severity ranking' },
        { label: 'VFD / Motor Troubleshoot', beforeTitle: 'Enter fault code & equipment', afterTitle: 'Root cause + wiring fix steps' },
      ]}
    />
  )
}
