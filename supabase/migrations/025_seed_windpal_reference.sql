-- 025_seed_windpal_reference.sql
-- Seed the windpal.wind_reference table with core turbine reference data.

INSERT INTO windpal.wind_reference (category, title, equipment_type, system_type, specification, content_json) VALUES

-- ── Bolt Torque Specs ───────────────────────────────────────────────
('torque_specs', 'Blade Root Bolt Torque — Vestas V90', 'Vestas V90-2.0', 'rotor', 'Blade root bolts M36 10.9',
 '{"bolt_size":"M36","grade":"10.9","torque_nm":1850,"torque_ft_lbs":1364,"method":"hydraulic tensioning","sequence":"star pattern, 3 passes","notes":"Re-torque after 6 months and annually"}'::jsonb),

('torque_specs', 'Blade Root Bolt Torque — Vestas V110', 'Vestas V110-2.0', 'rotor', 'Blade root bolts M42 10.9',
 '{"bolt_size":"M42","grade":"10.9","torque_nm":2800,"torque_ft_lbs":2065,"method":"hydraulic tensioning","sequence":"star pattern, 3 passes","notes":"Re-torque after 6 months and annually"}'::jsonb),

('torque_specs', 'Yaw Gear Bolt Torque — General', 'Generic', 'yaw_system', 'Yaw gear ring bolts M30 10.9',
 '{"bolt_size":"M30","grade":"10.9","torque_nm":1200,"torque_ft_lbs":885,"method":"calibrated torque wrench","sequence":"cross pattern, 2 passes","notes":"Check after commissioning and every 6 months"}'::jsonb),

('torque_specs', 'Tower Section Flange Bolts — Standard', 'Generic', 'tower', 'Tower flange bolts M48 10.9',
 '{"bolt_size":"M48","grade":"10.9","torque_nm":4500,"torque_ft_lbs":3318,"method":"hydraulic tensioning","sequence":"star pattern, 4 passes","notes":"Annual inspection mandatory"}'::jsonb),

-- ── Component Specifications ────────────────────────────────────────
('component_specs', 'Main Bearing — Vestas V90', 'Vestas V90-2.0', 'drivetrain', 'Double-row spherical roller bearing',
 '{"bearing_type":"double-row spherical roller","manufacturer":"SKF / FAG","grease_type":"Mobilith SHC 460","grease_interval_months":6,"grease_volume_kg":2.5,"operating_temp_max_c":80,"replacement_interval":"condition-based, typically 10-15 years"}'::jsonb),

('component_specs', 'Gearbox Oil Specifications', 'Generic', 'drivetrain', 'Gearbox lubrication requirements',
 '{"oil_type":"synthetic PAO","viscosity_grade":"ISO VG 320","typical_products":["Mobil SHC 632","Castrol Optigear Synthetic X 320","Shell Omala S4 GXV 320"],"change_interval_months":36,"oil_volume_liters":"varies by model, typically 200-400L","sampling_interval_months":6,"notes":"Oil particle count and water content monitored via CMS"}'::jsonb),

('component_specs', 'Hydraulic System — Pitch Cylinders', 'Generic', 'pitch_system', 'Hydraulic pitch system specs',
 '{"fluid_type":"HLP 46 hydraulic oil","operating_pressure_bar":200,"accumulator_precharge_bar":100,"filter_change_interval_months":12,"fluid_change_interval_months":24,"notes":"Check accumulator precharge pressure at every service visit"}'::jsonb),

-- ── Safety Standards ────────────────────────────────────────────────
('safety', 'GWO Basic Safety Training (BST) Modules', 'N/A', 'training', 'GWO BST requirements',
 '{"modules":["First Aid","Manual Handling","Fire Awareness","Working at Heights","Sea Survival (offshore only)"],"validity_years":2,"provider":"GWO-certified training center","notes":"All modules must be current before turbine access is permitted"}'::jsonb),

('safety', 'Rescue Plan Requirements — Up-Tower', 'Generic', 'safety_procedure', 'OSHA / GWO rescue requirements',
 '{"requirement":"Written rescue plan required before any up-tower work","max_rescue_time_minutes":20,"equipment":["Rescue descent device","Stretcher rated for vertical lift","Two-way radio per climber","First aid kit in nacelle"],"training":"GWO Working at Heights with rescue module","notes":"Practice rescue drill at least quarterly"}'::jsonb),

('safety', 'Lockout/Tagout — Wind Turbine Procedure', 'Generic', 'safety_procedure', 'LOTO for wind turbine maintenance',
 '{"energy_sources":["Electrical (grid connection)","Mechanical (rotor rotation)","Hydraulic (pitch/yaw)","Pneumatic (accumulators)","Gravitational (nacelle height)"],"isolation_points":["Main breaker","Rotor lock pin","Yaw brake","Pitch lock pins","Hydraulic dump valve"],"verification":"Attempt restart after lockout to confirm zero energy","notes":"Each technician applies their own lock — no shared locks"}'::jsonb),

-- ── Maintenance Procedures ──────────────────────────────────────────
('maintenance', '6-Month Preventive Maintenance Checklist', 'Generic', 'all_systems', 'Semi-annual PM overview',
 '{"tasks":["Visual blade inspection (ground-level + drone)","Bolt torque checks (blade root, tower flange, yaw gear)","Gearbox oil sample and filter check","Main bearing grease replenishment","Hydraulic system pressure and fluid level check","Pitch system function test","Yaw system alignment and brake pad inspection","Electrical termination torque checks","Safety equipment inspection (PPF, harness, descent devices)","CMS data review (vibration, temperature trends)"],"estimated_hours":8,"crew_size":2,"notes":"Schedule around low-wind windows when possible"}'::jsonb),

('maintenance', 'Blade Leading Edge Repair — Field Procedure', 'Generic', 'rotor', 'LEP repair steps',
 '{"steps":["Rope access or platform setup to damage location","Clean and dry affected area","Remove loose material and feather edges","Apply filler compound in layers (max 5mm per layer)","Shape to original aerodynamic profile","Apply LEP coating (polyurethane or tape system)","Cure per manufacturer specs","Document repair with photos and measurements"],"materials":["Epoxy filler","LEP coating or tape","Sandpaper 80-400 grit","Solvent cleaner","Mixing cups and applicators"],"notes":"Repairs above Category 3 damage require engineering assessment before field repair"}'::jsonb),

-- ── Fault Codes ─────────────────────────────────────────────────────
('fault_codes', 'Common SCADA Alarm Categories', 'Generic', 'control_system', 'Typical turbine alarm groupings',
 '{"categories":[{"name":"Grid","examples":["Grid frequency out of range","Voltage asymmetry","Power factor fault"],"action":"Check grid conditions, reset if transient"},{"name":"Pitch","examples":["Pitch motor overtemp","Pitch battery low","Blade angle deviation"],"action":"Check pitch battery voltage, motor connections, encoder calibration"},{"name":"Yaw","examples":["Yaw error exceeded","Cable twist limit","Yaw brake wear"],"action":"Check wind vane alignment, yaw motor current, cable twist counter"},{"name":"Drivetrain","examples":["Gearbox oil temp high","Bearing vibration alarm","Generator overtemp"],"action":"Check oil level/cooler, review CMS trends, inspect windings"},{"name":"Safety","examples":["Vibration trip","Overspeed","Emergency stop activated"],"action":"Inspect before reset — these indicate potential structural or control failure"}]}'::jsonb),

('fault_codes', 'Pitch System Fault Diagnosis', 'Generic', 'pitch_system', 'Common pitch faults and resolution',
 '{"faults":[{"fault":"Pitch battery voltage low","cause":"Battery aging or charger failure","diagnosis":"Measure battery voltage at rest and under load, check charger output","resolution":"Replace battery pack if below threshold, verify charger operation"},{"fault":"Pitch motor overcurrent","cause":"Mechanical binding, bearing failure, or wiring issue","diagnosis":"Check motor current draw, inspect pitch bearing grease condition, check wiring","resolution":"Grease bearing, replace motor if winding resistance abnormal"},{"fault":"Blade angle sensor deviation","cause":"Encoder slip or calibration drift","diagnosis":"Compare SCADA blade angle with manual protractor measurement","resolution":"Recalibrate encoder, check mounting bolts, replace if faulty"}]}'::jsonb);
