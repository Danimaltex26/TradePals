import ProductPage from '../../components/ProductPage'

export default function WindPalProduct() {
  return (
    <ProductPage
      app="windpal"
      description="Inspect blade damage from photos, troubleshoot turbine faults and SCADA alarms, look up torque specs and component data, and prep for GWO and wind tech certifications — all from the nacelle or at the base of the tower."
      longDescription={`Wind turbine technicians work at height in harsh conditions with complex electromechanical systems — and the margin for error is razor thin. A blade tech rappelling down a leading edge needs to know whether that crack is cosmetic or structural. A mechanical tech hearing abnormal vibration from the gearbox needs to decide between scheduling an oil sample and calling for an immediate shutdown. The safety stakes are as high as the turbines themselves.

WindPal covers the full scope of wind turbine service. Photograph blade erosion, lightning strikes, gearbox oil samples, generator windings, or tower bolt patterns and get an instant assessment with severity classification, root cause analysis, and recommended corrective action. The troubleshooting engine handles pitch system faults, yaw drive issues, converter errors, and over 50 SCADA alarm codes across GE, Vestas, Siemens Gamesa, Nordex, and Enercon platforms.

The reference library includes bolt torque specifications for every major tower section, hydraulic fluid compatibility charts, bearing clearance tolerances, and safety system parameters. The power curve calculator helps verify whether a turbine is producing at its rated capacity for a given wind speed.

From a GWO-certified technician performing their first up-tower inspection to a senior tech diagnosing a recurring pitch fault across a fleet, WindPal is the O&M manual, the safety briefing, and the senior engineer all in one app.`}
      features={[
        'Blade & component photo analysis — erosion, cracks, lightning damage, oil analysis',
        'Fault diagnosis — pitch, yaw, converter, gearbox, generator, SCADA alarms',
        'Turbine reference — GE, Vestas, Siemens Gamesa, Nordex, Enercon specs',
        'Bolt torque charts — tower sections, blade bolts, flange connections',
        'Power curve calculator — expected vs actual output at given wind speed',
        'Safety reference — GWO procedures, rescue plans, PPE requirements',
        'Offline photo queue — capture up-tower, process when back at base',
        'Certification training — GWO BST, BTT, ACP Wind Tech prep',
      ]}
      screenshots={[
        { label: 'Blade Inspection', beforeTitle: 'Photo the blade damage', afterTitle: 'Severity + repair recommendation' },
        { label: 'Fault Diagnosis', beforeTitle: 'Enter alarm code & symptoms', afterTitle: 'Root cause + corrective action' },
      ]}
    />
  )
}
