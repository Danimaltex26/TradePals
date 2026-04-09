import ProductPage from '../../components/ProductPage'

export default function WeldPalProduct() {
  return (
    <ProductPage
      app="weldpal"
      description="Photo-based weld defect analysis, structured troubleshooting, a growing reference library, and certification prep for AWS, API, and ASME welding codes."
      features={[
        'Visual weld defect analysis with Claude vision',
        'Troubleshooting wizard for ranked causes & fixes',
        'Reference: WPS, codes, fillers, defect types',
        'Cert prep: AWS CW, CAWI, CWI, CRAW, CWEng',
        'History of every analysis you run',
        'Works on iOS and any modern browser',
      ]}
    />
  )
}
