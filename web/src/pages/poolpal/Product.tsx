import ProductPage from '../../components/ProductPage'

export default function PoolPalProduct() {
  return (
    <ProductPage
      app="poolpal"
      description="Analyze pool water and equipment photos, troubleshoot pumps, heaters, filters, and salt cells, look up chemical dosing and code requirements, and prep for pool certifications — all from your phone on the jobsite."
      longDescription={`Pool service is part chemistry, part mechanical, and part detective work. A green pool could be algae, copper staining, or pollen — and the treatment for each is completely different. A heater that won't fire could be a flow switch, a gas valve, an igniter, or a cracked heat exchanger. Getting the diagnosis right the first time saves you a return trip and keeps your customer happy.

PoolPal gives you a master tech's diagnostic instinct on every call. Photograph the pool and get an instant water chemistry analysis with treatment recommendations. The troubleshooting wizard covers pumps, heaters, filters, salt cells, and automation systems with brand-specific guidance for Pentair, Hayward, Jandy, and Raypak equipment.

The LSI calculator is the standout tool — enter your current readings, set your desired values, and get an exact chemical treatment plan: how much muriatic acid, soda ash, calcium chloride, or stabilizer to add, calculated for your pool volume. The FC/CYA chart, chemical dosing calculator, and code reference tables are always free and always available — even offline.

Whether you're a solo route tech running 8 pools a day or an apprentice studying for your CPO, PoolPal keeps the chemistry and the troubleshooting in your pocket where you need it.`}
      features={[
        'Pool photo analysis — water chemistry, algae ID, equipment condition',
        'Equipment troubleshooting — pumps, heaters, filters, salt cells, automation',
        'LSI calculator — current vs desired with chemical treatment plan',
        'Chemical dosing calculator — chlorine, acid, soda ash, bicarb, CaCl2, CYA',
        'FC/CYA chart — chlorine targets by stabilizer level + SLAM doses',
        'Code reference — VGB Act, barrier requirements, commercial chlorine minimums',
        'Browse reference database — 18+ verified entries across 8 categories',
        'Offline photo queue — capture at the pool, process in the truck',
      ]}
      screenshots={[
        { label: 'Pool Photo Analysis', beforeTitle: 'Photo the pool or equipment', afterTitle: 'Water chemistry + treatment plan' },
        { label: 'Equipment Troubleshoot', beforeTitle: 'Select heater, pump, or salt cell', afterTitle: 'Ranked causes + parts to check' },
      ]}
    />
  )
}
