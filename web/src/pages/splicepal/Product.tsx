import ProductPage from '../../components/ProductPage'

export default function SplicePalProduct() {
  return (
    <ProductPage
      app="splicepal"
      description="Analyze OTDR traces, troubleshoot bad splices, look up reference data, and prep for fiber-optic certifications — all from your phone on the jobsite."
      longDescription={`The fiber industry is booming. BEAD funding, 5G buildouts, and data center expansion are creating unprecedented demand for qualified splicers — but the learning curve is steep. Reading an OTDR trace, identifying gainers vs real splice loss, understanding MFD mismatch across fiber types — this knowledge used to take years riding alongside a senior tech.

SplicePal puts that expertise in your pocket. Photograph your OTDR screen and get a splice-by-splice analysis in seconds: event type, loss values, gainer detection with MFD mismatch explanation, and a clear pass/fail recommendation. The troubleshooting wizard walks you through high-loss splices from cleave quality to electrode condition to environmental factors.

The reference library covers every major fiber type — SMF-28, bend-insensitive, NZDSF, multimode — with arc settings, compatibility warnings, and OTDR behavior notes. It grows automatically: if you look up a fiber that's not in the database, the AI generates verified specs and caches them for the next tech who asks.

Whether you're a first-year apprentice learning to read traces or a 20-year veteran hitting an unfamiliar fiber type on a new build, SplicePal is the field companion that makes you faster and more confident.`}
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
      screenshots={[
        { label: 'OTDR Trace Analysis', beforeTitle: 'Photo your OTDR screen', afterTitle: 'Get splice-by-splice diagnosis', beforeImage: '/in.png', afterImage: '/out.png' },
        { label: 'Splice Troubleshooting', beforeTitle: 'Enter loss & error code', afterTitle: 'Ranked causes + step-by-step fix' },
      ]}
    />
  )
}
