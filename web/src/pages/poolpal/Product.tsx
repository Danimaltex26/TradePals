import ProductPage from '../../components/ProductPage'

export default function PoolPalProduct() {
  return (
    <ProductPage
      app="poolpal"
      description="Analyze pool water and equipment photos, troubleshoot pumps, heaters, filters, and salt cells, look up chemical dosing and code requirements, and prep for pool certifications — all from your phone on the jobsite."
      features={[
        'Pool photo analysis: water chemistry, algae ID, equipment inspection',
        'Troubleshooting wizard for pumps, heaters, filters, salt cells',
        'Reference library: chemical dosing, equipment specs, codes',
        'Certification prep (CPO, AFO, PHTA CST)',
        'History of every analysis you run',
        'Works on iOS and any modern browser',
      ]}
    />
  )
}
