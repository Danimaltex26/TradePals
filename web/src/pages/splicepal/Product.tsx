import ProductPage from '../../components/ProductPage'

export default function SplicePalProduct() {
  return (
    <ProductPage
      app="splicepal"
      name="SplicePal"
      tagline="AI assistant for fiber splicers"
      description="Analyze OTDR traces, troubleshoot bad splices, look up reference data, and prep for fiber-optic certifications — all from your phone on the jobsite."
      features={[
        'OTDR trace analysis with Claude vision',
        'Splice loss troubleshooting workflow',
        'Reference library: connectors, splicers, codes',
        'Certification prep (CFOT, CFOS, BFT, FOT)',
        'History of every analysis you run',
        'Works on iOS and any modern browser',
      ]}
    />
  )
}
