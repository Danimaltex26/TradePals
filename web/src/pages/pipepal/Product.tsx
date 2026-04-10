import ProductPage from '../../components/ProductPage'

export default function PipePalProduct() {
  return (
    <ProductPage
      app="pipepal"
      description="Diagnose leaks and code violations from photos, troubleshoot water heaters, drains, and fixtures, calculate pipe sizing and gas pipe loads, and prep for journeyman and master plumber exams — all from your phone on the jobsite."
      features={[
        'Leak & code violation photo diagnosis',
        'Water heater, drain & fixture troubleshooting',
        'Pipe sizing & gas pipe calculators',
        'Journeyman / master plumber exam prep',
        'History of every analysis you run',
        'Works on iOS and any modern browser',
      ]}
    />
  )
}
