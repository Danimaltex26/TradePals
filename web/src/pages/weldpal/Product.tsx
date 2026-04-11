import ProductPage from '../../components/ProductPage'

export default function WeldPalProduct() {
  return (
    <ProductPage
      app="weldpal"
      description="Photo-based weld defect analysis, structured troubleshooting, a growing reference library, and certification prep for AWS, API, and ASME welding codes."
      longDescription={`Every weld tells a story — undercut, porosity, lack of fusion, excessive convexity — and reading that story correctly is the difference between a part that holds and one that fails in service. For CWIs doing visual inspection, the judgment calls are constant. For welders learning the craft, the feedback loop from weld to correction is where the real learning happens.

WeldPal accelerates that feedback loop. Photograph a weld and get an instant defect analysis: what's wrong, how severe it is, whether it passes or fails to code, and what parameter adjustments will fix it. The AI has been trained on AWS D1.1, API 1104, and ASME Section IX acceptance criteria — so it speaks the same language your inspector does.

The troubleshooting wizard goes deeper. Select your process (SMAW, GMAW, FCAW, GTAW, SAW), describe the defect, and get ranked probable causes with specific fixes: adjust voltage, change travel speed, switch gas mix, check for moisture in electrodes. It thinks like a welding engineer, explains like a foreman.

The reference library covers WPS essentials, filler metal selection, preheat requirements, and code-specific acceptance criteria. Certification prep covers AWS CWI, CAWI, and related credentials with practical study content — not just memorizing charts, but understanding why the code says what it says.`}
      features={[
        'Visual weld defect analysis — photo your weld, get accept/reject verdict',
        'Defect identification — undercut, porosity, LOF, cracks, convexity',
        'Process troubleshooting — SMAW, GMAW, FCAW, GTAW, SAW',
        'Code-referenced — AWS D1.1, API 1104, ASME Section IX criteria',
        'Reference library — WPS, fillers, preheat, defect types',
        'Certification prep — CWI, CAWI, CW, CRAW, CWEng',
        'History — every weld analysis saved with notes',
        'Offline photo queue — capture in the field, process when connected',
      ]}
      screenshots={[
        { label: 'Weld Defect Analysis', beforeTitle: 'Photo your weld', afterTitle: 'Defect ID + accept/reject verdict' },
        { label: 'Weld Troubleshooting', beforeTitle: 'Describe the defect & process', afterTitle: 'Root cause + parameter fix' },
      ]}
    />
  )
}
