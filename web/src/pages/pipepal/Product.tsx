import ProductPage from '../../components/ProductPage'

export default function PipePalProduct() {
  return (
    <ProductPage
      app="pipepal"
      description="Diagnose leaks and code violations from photos, troubleshoot water heaters, drains, and fixtures, calculate pipe sizing and gas pipe loads, and prep for journeyman and master plumber exams — all from your phone on the jobsite."
      longDescription={`Plumbing is one of the oldest trades — and one of the most code-heavy. The IPC and UPC differ on trap arm lengths, wet venting rules, and AAV allowances. Gas pipe sizing depends on BTU load, pipe length, and material. Water heater installations touch plumbing, mechanical, and fuel gas codes simultaneously. A journeyman plumber needs to carry all of this in their head — or have a fast way to look it up.

PipePal puts the code book, the sizing tables, and a master plumber's diagnostic instinct on your phone. Photograph a leaking fitting, a suspected code violation, or a corroded pipe and get an instant analysis with IPC/UPC references. The troubleshooting wizard covers 21 equipment types — from residential toilets and garbage disposals to commercial grease traps and boiler systems — with brand-specific guidance for Kohler, Moen, Rheem, Rinnai, Zoeller, Watts, and more.

The pipe sizing calculator handles both supply (WSFU) and drain (DFU) sizing with toggle between water supply and DWV modes. The gas pipe sizing calculator takes your appliance load and pipe run length and tells you the minimum pipe size — critical for tankless water heater installs where undersized gas lines are the #1 callback. The fixture unit reference table covers residential and commercial with trap sizes, minimum drain sizes, and vent sizes for every common fixture.

Whether you're a service plumber diagnosing a tankless error code, an apprentice learning trap and vent rules, or a master plumber sizing a commercial rough-in, PipePal is the reference library and diagnostic tool that fits in your pocket.`}
      features={[
        'Leak & code violation photo diagnosis — IPC/UPC referenced',
        'Troubleshooting — 21 equipment types, toilets to boilers',
        'Pipe sizing calculator — supply (WSFU) and drain (DFU) modes',
        'Gas pipe sizing — BTU load by appliance + pipe run length',
        'Fixture unit reference — residential & commercial with trap/drain/vent sizes',
        'Backflow device selection guide — AG, RPZ, DCVA, PVB, AVB',
        'Water heater installation reference — T&P, expansion tanks, venting',
        'Offline photo queue — capture under the slab, process in the truck',
      ]}
      screenshots={[
        { label: 'Leak / Code Violation Analysis', beforeTitle: 'Photo the pipe or fitting', afterTitle: 'IPC violation + repair method' },
        { label: 'Water Heater Troubleshoot', beforeTitle: 'Select unit type & symptom', afterTitle: 'Diagnosis + T&P / venting checks' },
      ]}
    />
  )
}
