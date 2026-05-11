import ProductPage from '../../components/ProductPage'

export default function SplicePalProduct() {
  return (
    <ProductPage
      app="splicepal"
      description="Analyze OTDR traces, troubleshoot bad splices, look up reference data, and prep for fiber-optic certifications — all from your phone on the jobsite."
      demoVideo="/ExampleSplice.mp4"
      longDescription={`The fiber industry is booming — BEAD funding, 5G buildouts, and data center expansion are creating unprecedented demand for qualified splicers. But the learning curve is steep, and there aren't enough senior techs to mentor every apprentice.

SplicePal puts that expertise in your pocket. Photograph your OTDR screen and get a splice-by-splice analysis in seconds — event type, loss values, gainer detection, and a clear pass/fail recommendation. The troubleshooting wizard walks you through high-loss splices from cleave quality to electrode condition.`}
      features={[
        'OTDR trace analysis — photo your screen, get splice-by-splice diagnosis',
        'Full link analysis — end-to-end loss budget, pass/fail verdict',
        'Splice troubleshooting — ranked causes from cleave to electrodes',
        'Fiber type reference — 50+ fibers with arc settings and MFD data',
        'Color code charts — TIA-598 strand and buffer tube mapping',
        'Loss budget calculator — SMF/MMF at 1310/1550/850/1300 nm',
        'Certification prep — CFOT, CFOS/S, CFOS/T, CFOS/O, BFT, FOT',
        'Offline photo queue — capture in the field, process when connected',
      ]}
      trainingImages={['/cert1.png', '/cert2.png', '/cert4.png']}
      screenshots={[
        { label: 'OTDR Trace Analysis', beforeTitle: 'Photo your OTDR screen', afterTitle: 'Get splice-by-splice diagnosis', beforeImage: '/in.png', afterImage: '/out.png' },
        { label: 'Splice Troubleshooting', beforeTitle: 'Enter loss & error code', afterTitle: 'Ranked causes + step-by-step fix', beforeImage: '/in2.png', afterImage: '/out2.png' },
      ]}
    />
  )
}
