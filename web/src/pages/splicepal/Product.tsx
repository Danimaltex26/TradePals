import ProductPage from '../../components/ProductPage'

export default function SplicePalProduct() {
  return (
    <ProductPage
      app="splicepal"
      // Cert-first hero — Option A
      certHook="Pass CFOT on the first try. Get on a BEAD project."
      certSubhook="CFOT pays for itself in ~6 months. SplicePal gets you there."
      description="AI fiber companion + CFOT exam prep, built for splicers and OSP technicians. Photograph your OTDR, troubleshoot bad splices, and study for the exam — all from your phone."
      quizUrl="https://splicepal.tradepals.net/cfot-practice"
      stats={[
        { value: '$42.45B', label: 'BEAD broadband investment', source: 'NTIA federal allocations' },
        { value: '178,000', label: 'Fiber workers needed by 2032', source: 'Fiber Broadband Association' },
        { value: '+$10K/yr', label: 'CFOT pay premium vs uncertified', source: 'DataX Connect 2025 (11% lift)' },
        { value: '$650–$2,000', label: 'Typical CFOT exam + prep cost', source: 'FOA + accredited training providers' },
      ]}
      salaryBlock={{
        uncertifiedRange: '$45K–$60K',
        certifiedRange: '$55K–$75K',
        sourceLabel: 'PayScale & Glassdoor (CFOT holders, 2026) · DataX Connect 2025 · BLS SOC 49-2022 baseline',
        note: 'CFOT pays for itself in roughly 6 months. PayScale puts the CFOT-holder median at ~$69K; uncertified splicers average ~$55K. The ~$10K/yr delta covers the $650–$2,000 cert cost in under half a year — and unlocks BEAD-funded contract work and data-center rates ($34.80/hr avg, often $85K+ with shift differentials).',
      }}
      certTrustLine="FOA-aligned prep for CFOT · CFOS/S · CFOS/T · CFOS/O · BFT · FOT"
      demoVideo="/ExampleSplice.mp4"
      longDescription={`The fiber industry is booming — BEAD funding, 5G buildouts, and data center expansion are creating unprecedented demand for qualified splicers. But the learning curve is steep, and there aren't enough senior techs to mentor every apprentice.

SplicePal puts that expertise in your pocket. Photograph your OTDR screen and get a splice-by-splice analysis in seconds — event type, loss values, gainer detection, and a clear pass/fail recommendation. The troubleshooting wizard walks you through high-loss splices from cleave quality to electrode condition.`}
      features={[
        'CFOT, CFOS/S, CFOS/T, CFOS/O, BFT, FOT exam prep — timed mocks, weak-area drills, readiness scoring',
        'OTDR trace analysis — photo your screen, get splice-by-splice diagnosis',
        'Full link analysis — end-to-end loss budget, pass/fail verdict',
        'Splice troubleshooting — ranked causes from cleave to electrodes',
        'Fiber type reference — 50+ fibers with arc settings and MFD data',
        'Color code charts — TIA-598 strand and buffer tube mapping',
        'Loss budget calculator — SMF/MMF at 1310/1550/850/1300 nm',
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
