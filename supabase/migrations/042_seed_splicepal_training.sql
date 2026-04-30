-- 042_seed_splicepal_training.sql
-- Seed training modules and questions for SplicePal (fiber optic certifications).
-- Cert levels: FOT, CFOT, CFOS_S, CFOS_T
-- 4 modules per cert level (16 total), 10 questions per module (160 total).

-- ============================================================
-- PART 1: Training Modules (16 rows)
-- ============================================================

INSERT INTO splicepal.training_modules
  (cert_level, module_number, title, topic_list, estimated_minutes, exam_domain_weight, is_published)
VALUES
-- FOT (Fiber Optic Technician)
('FOT', 1, 'Fiber Optic Fundamentals',
 ARRAY['fiber types','light propagation','cable construction'], 45, 0.30, true),
('FOT', 2, 'Connectors & Termination',
 ARRAY['connector types','polishing','inspection'], 50, 0.25, true),
('FOT', 3, 'Basic Testing',
 ARRAY['power meters','light sources','visual fault locators'], 40, 0.25, true),
('FOT', 4, 'Safety & Standards',
 ARRAY['laser safety','OSHA','TIA standards'], 35, 0.20, true),

-- CFOT (Certified Fiber Optic Technician)
('CFOT', 1, 'Advanced Fiber Theory',
 ARRAY['attenuation','bandwidth','wavelengths','dispersion'], 55, 0.25, true),
('CFOT', 2, 'Splicing Techniques',
 ARRAY['fusion splicing','mechanical splicing','preparation'], 60, 0.30, true),
('CFOT', 3, 'OTDR Fundamentals',
 ARRAY['trace reading','event identification','dead zones'], 55, 0.25, true),
('CFOT', 4, 'Loss Budgets & Design',
 ARRAY['loss calculations','link design','documentation'], 50, 0.20, true),

-- CFOS_S (Splicing Specialist)
('CFOS_S', 1, 'Advanced Fusion Splicing',
 ARRAY['splice parameters','fiber alignment','multi-fiber'], 60, 0.30, true),
('CFOS_S', 2, 'Splice Quality & Troubleshooting',
 ARRAY['loss analysis','gainers','MFD mismatch'], 55, 0.25, true),
('CFOS_S', 3, 'Ribbon & Mass Fusion',
 ARRAY['ribbon fiber','mass fusion splicers','techniques'], 55, 0.25, true),
('CFOS_S', 4, 'Field Splicing Best Practices',
 ARRAY['enclosures','environmental factors','documentation'], 45, 0.20, true),

-- CFOS_T (Testing Specialist)
('CFOS_T', 1, 'Advanced OTDR Analysis',
 ARRAY['bi-directional testing','averaging','dynamic range'], 60, 0.30, true),
('CFOS_T', 2, 'Tier 1 & Tier 2 Testing',
 ARRAY['insertion loss','OTDR traces','test standards'], 55, 0.25, true),
('CFOS_T', 3, 'Troubleshooting with Test Equipment',
 ARRAY['fault location','macro-bends','reflectance'], 50, 0.25, true),
('CFOS_T', 4, 'Test Documentation & Compliance',
 ARRAY['test reports','acceptance criteria','standards'], 45, 0.20, true);

-- ============================================================
-- PART 2: Training Questions (160 rows — 10 per module)
-- ============================================================

WITH m AS (
  SELECT id, cert_level, module_number
  FROM splicepal.training_modules
)
INSERT INTO splicepal.training_questions
  (module_id, cert_level, topic, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, standard_reference, difficulty)
VALUES

-- ────────────────────────────────────────────────────────────
-- FOT Module 1: Fiber Optic Fundamentals (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=1),
 'FOT', 'fiber_types',
 'What is the core diameter of standard single-mode fiber (ITU-T G.652)?',
 '50 micrometers', '62.5 micrometers', '8-10 micrometers', '125 micrometers',
 'C', 'Standard single-mode fiber per ITU-T G.652 has a core diameter of approximately 8-10 µm (typically 9 µm), which allows only a single mode of light to propagate. The 125 µm value is the cladding diameter.',
 'ITU-T G.652', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=1),
 'FOT', 'fiber_types',
 'Which multimode fiber designation is laser-optimized for 10 Gbps Ethernet up to 300 meters?',
 'OM1', 'OM2', 'OM3', 'OS2',
 'C', 'OM3 is a 50/125 µm laser-optimized multimode fiber that supports 10GBASE-SR up to 300 meters. OM1 (62.5 µm) and OM2 (50 µm) are older designs. OS2 is single-mode.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=1),
 'FOT', 'light_propagation',
 'Total internal reflection in optical fiber occurs at the boundary between:',
 'The jacket and the buffer', 'The core and the cladding', 'The buffer and the strength member', 'The fiber and the air',
 'B', 'Total internal reflection (TIR) occurs at the core-cladding interface when the angle of incidence exceeds the critical angle. The core has a slightly higher refractive index than the cladding, enabling TIR.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=1),
 'FOT', 'light_propagation',
 'Modal dispersion is a significant concern primarily in which fiber type?',
 'Single-mode fiber', 'Multimode fiber', 'Photonic crystal fiber', 'Hollow-core fiber',
 'B', 'Modal dispersion occurs when multiple modes of light travel different path lengths through the fiber, causing pulse spreading. It only affects multimode fiber because single-mode supports one propagation mode.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=1),
 'FOT', 'cable_construction',
 'In a loose-tube fiber optic cable, what fills the space around the fibers inside the buffer tube?',
 'Air only', 'Gel or dry-block water-blocking material', 'Epoxy adhesive', 'Copper shielding',
 'B', 'Loose-tube cables use either gel fill or dry water-blocking material (superabsorbent polymers) to prevent moisture migration along the cable. Gel-filled designs were traditional; dry-block is increasingly preferred.',
 'GR-20 CORE', 'medium'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=1),
 'FOT', 'cable_construction',
 'What is the purpose of aramid yarn (Kevlar) in a fiber optic cable?',
 'To conduct electrical ground', 'To provide tensile strength for pulling', 'To increase bandwidth', 'To improve the refractive index',
 'B', 'Aramid yarn (DuPont Kevlar) provides tensile strength so pulling forces are borne by the strength member rather than the glass fibers. The pull rope attaches to the aramid yarns during cable installation.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=1),
 'FOT', 'fiber_types',
 'The designation OM5 wideband multimode fiber is designed to support:',
 'Only 850 nm wavelength', 'Short-wavelength division multiplexing (SWDM) across 850-953 nm', 'Single-mode transmission at 1310 nm', 'Wavelengths above 1550 nm only',
 'B', 'OM5 fiber is designed for SWDM (Short Wavelength Division Multiplexing) applications using multiple wavelengths between 850 nm and 953 nm, enabling higher data rates over multimode fiber for data center use.',
 'TIA-568.3-D', 'medium'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=1),
 'FOT', 'light_propagation',
 'The numerical aperture (NA) of a fiber optic cable determines its:',
 'Color code', 'Maximum tensile strength', 'Light acceptance angle', 'Minimum bend radius',
 'C', 'Numerical aperture defines the cone of light that can enter the fiber core and propagate via total internal reflection. NA = sqrt(n1² - n2²), where n1 and n2 are the refractive indices of core and cladding.',
 'TIA-568.3-D', 'medium'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=1),
 'FOT', 'cable_construction',
 'A tight-buffered fiber has a buffer coating diameter of:',
 '125 micrometers', '250 micrometers', '500 micrometers', '900 micrometers',
 'D', 'Tight-buffered fiber has a 900 µm coating applied directly over the 250 µm primary coating. This makes individual fibers more robust for indoor cabling, patch cords, and direct termination.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=1),
 'FOT', 'fiber_types',
 'Bend-insensitive single-mode fiber conforming to ITU-T G.657.A2 can withstand a minimum bend radius of:',
 '30 mm', '15 mm', '7.5 mm', '5 mm',
 'C', 'ITU-T G.657.A2 specifies a minimum bend radius of 7.5 mm with acceptable added loss. This makes it ideal for FTTH installations, tight indoor routing, and structured cabling in MDUs.',
 'ITU-T G.657', 'medium'),

-- ────────────────────────────────────────────────────────────
-- FOT Module 2: Connectors & Termination (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=2),
 'FOT', 'connector_types',
 'Which connector type uses a 2.5 mm ferrule and a bayonet coupling mechanism?',
 'SC', 'ST', 'LC', 'MPO',
 'B', 'The ST (Straight Tip) connector uses a 2.5 mm ceramic ferrule and a bayonet-style twist-lock coupling. SC connectors also use 2.5 mm ferrules but with a push-pull latching mechanism.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=2),
 'FOT', 'connector_types',
 'The LC connector is characterized by a ferrule diameter of:',
 '2.5 mm', '1.25 mm', '0.5 mm', '3.0 mm',
 'B', 'The LC (Lucent Connector) uses a 1.25 mm ferrule, making it a small form factor (SFF) connector. Its compact size allows higher port density in patch panels and transceivers.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=2),
 'FOT', 'polishing',
 'An APC (Angled Physical Contact) connector has an endface polished at an angle of:',
 '0 degrees', '4 degrees', '8 degrees', '15 degrees',
 'C', 'APC connectors have an 8-degree angled endface. This angle causes reflected light to be directed into the cladding rather than back down the core, achieving return loss greater than 60 dB.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=2),
 'FOT', 'polishing',
 'Why must an APC connector never be mated with a UPC connector?',
 'They use different ferrule sizes', 'The angled endface causes an air gap, resulting in high loss and back-reflection', 'They use incompatible wavelengths', 'The color codes will not match',
 'B', 'An APC-to-UPC mating creates an angular mismatch at the endface. The resulting air gap causes excessive insertion loss (often >3 dB) and high back-reflection that can damage laser sources.',
 'TIA-568.3-D', 'medium'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=2),
 'FOT', 'inspection',
 'Before mating any fiber connector, a technician should always:',
 'Apply index-matching gel', 'Inspect the endface with a fiber microscope', 'Submerge it in isopropyl alcohol', 'Test it with an OTDR',
 'B', 'IEC 61300-3-35 specifies inspection of connector endfaces before mating. Contamination is the number one cause of insertion loss and equipment damage. A 200x or 400x fiber microscope is used.',
 'IEC 61300-3-35', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=2),
 'FOT', 'inspection',
 'According to IEC 61300-3-35, which zone of the connector endface is most critical for cleanliness?',
 'The outer cladding zone', 'The core zone (Zone A)', 'The ferrule edge', 'The connector housing',
 'B', 'Zone A encompasses the fiber core area and is the most critical. Any contamination — scratches, particles, or residue — in this zone directly affects signal transmission and can cause high insertion loss.',
 'IEC 61300-3-35', 'medium'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=2),
 'FOT', 'connector_types',
 'An MPO/MTP connector is primarily used for:',
 'Single-fiber patch cords', 'Multi-fiber ribbon connections with 8, 12, or 24 fibers', 'Coaxial-to-fiber conversion', 'Outdoor splice closures',
 'B', 'MPO (Multi-fiber Push On) / MTP connectors accommodate multiple fibers (commonly 8, 12, or 24) in a single rectangular ferrule. They are standard for data center trunk cabling and high-density applications.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=2),
 'FOT', 'polishing',
 'The three common connector endface polish types, in order of increasing return loss performance, are:',
 'PC, UPC, APC', 'APC, UPC, PC', 'UPC, PC, APC', 'Flat, PC, UPC',
 'A', 'PC (Physical Contact) provides >35 dB return loss, UPC (Ultra Physical Contact) provides >50 dB, and APC (Angled Physical Contact) provides >60 dB. Higher return loss means less back-reflection.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=2),
 'FOT', 'connector_types',
 'The color code for a single-mode UPC connector boot is:',
 'Green', 'Blue', 'Beige', 'Aqua',
 'B', 'Blue indicates single-mode UPC. Green indicates single-mode APC. Beige is used for OM1/OM2 multimode, and aqua is used for OM3/OM4 multimode connectors.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=2),
 'FOT', 'polishing',
 'When field-terminating a connector using the epoxy-and-polish method, the final polishing film grit used is typically:',
 '12 µm (coarse)', '3 µm (medium)', '1 µm or 0.3 µm (fine)', '40 µm (rough)',
 'C', 'Field polishing progresses from coarse to fine grits. The final step uses 1 µm or 0.3 µm film to achieve a smooth, scratch-free endface. A figure-eight polishing motion is standard technique.',
 'FOA Reference Guide', 'medium'),

-- ────────────────────────────────────────────────────────────
-- FOT Module 3: Basic Testing (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=3),
 'FOT', 'power_meters',
 'An optical power meter measures received light power and typically displays results in:',
 'Volts (V)', 'Decibels relative to one milliwatt (dBm)', 'Ohms (Ω)', 'Megahertz (MHz)',
 'B', 'Optical power meters display absolute power in dBm (decibels referenced to 1 milliwatt). 0 dBm equals 1 mW. Some meters can also display in microwatts (µW) or milliwatts (mW).',
 'TIA-526-14-B', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=3),
 'FOT', 'power_meters',
 'When setting a reference for a Tier 1 insertion loss test using Method A (1-cord reference), what does the reference nullify?',
 'The fiber under test and both connectors', 'Only the test cord on the source side', 'Only the test cord on the meter side', 'Both test cords but not the fiber under test',
 'B', 'Method A (1-jumper reference) sets the reference with one cord on the source side only. The result includes the loss of the fiber, all connectors, splices, plus the meter-side test cord connector.',
 'TIA-526-14-B', 'medium'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=3),
 'FOT', 'light_sources',
 'A stabilized light source for single-mode fiber testing should operate at which wavelength(s)?',
 '850 nm and 1300 nm', '1310 nm and 1550 nm', '650 nm only', '1625 nm only',
 'B', 'Single-mode testing per TIA-568.3-D requires measurement at 1310 nm and 1550 nm. These are the second and third telecom windows with lowest attenuation. 850/1300 nm are for multimode.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=3),
 'FOT', 'visual_fault_locators',
 'A visual fault locator (VFL) typically emits light at what wavelength?',
 '850 nm (infrared)', '1310 nm (infrared)', '650 nm (visible red)', '1550 nm (infrared)',
 'C', 'VFLs emit visible red light at approximately 650 nm. This allows technicians to visually identify fiber breaks, tight bends, and faulty connectors by observing red light escaping from the cable.',
 'General practice', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=3),
 'FOT', 'visual_fault_locators',
 'A VFL can typically identify faults in single-mode fiber up to a distance of:',
 '100 meters', '2-5 kilometers', '50 kilometers', '500 meters only in multimode',
 'B', 'Most VFLs have an effective range of 2-5 km in single-mode fiber. The visible red light attenuates more rapidly than infrared, limiting range. They are best for short-distance fault identification.',
 'General practice', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=3),
 'FOT', 'power_meters',
 'If a light source emits +3 dBm and the power meter reads -22 dBm, what is the insertion loss of the link?',
 '19 dB', '22 dB', '25 dB', '3 dB',
 'C', 'Insertion loss = Source power - Received power = (+3 dBm) - (-22 dBm) = 25 dB. Note: in a properly referenced test, the meter reads loss directly because the reference sets the baseline to 0 dB.',
 'TIA-526-14-B', 'medium'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=3),
 'FOT', 'power_meters',
 'During a Tier 1 test, the fiber link under test has a measured insertion loss of 4.5 dB. The calculated loss budget allows 5.2 dB maximum. This link:',
 'Fails — loss exceeds the budget', 'Passes — measured loss is within the budget', 'Requires an OTDR test to determine pass/fail', 'Cannot be determined without ORL data',
 'B', '4.5 dB is less than the 5.2 dB budgeted maximum, so the link passes the Tier 1 test. The margin is 0.7 dB. TIA-568.3-D specifies that measured loss must not exceed the calculated loss budget.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=3),
 'FOT', 'light_sources',
 'Why should a light source be turned on and allowed to stabilize before testing?',
 'To allow the battery to charge', 'To ensure consistent output power — thermal drift affects accuracy', 'To calibrate the OTDR module', 'To deactivate the APC mode',
 'B', 'LED and laser sources experience thermal drift during warm-up. Stabilized sources require 5-10 minutes to reach thermal equilibrium. Testing before stabilization produces inconsistent and unreliable results.',
 'TIA-526-14-B', 'medium'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=3),
 'FOT', 'visual_fault_locators',
 'When a VFL is set to blinking (pulsing) mode, the purpose is to:',
 'Increase the output power', 'Make it easier to distinguish VFL light from ambient light at the fault', 'Reduce battery consumption only', 'Enable OTDR trace capture',
 'B', 'Blinking mode alternates the laser on and off, making it much easier to distinguish the VFL red glow from ambient light at a fault location, especially in bright environments.',
 'General practice', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=3),
 'FOT', 'power_meters',
 'The 2-cord reference method (Method B) measures the loss of:',
 'Only the fiber under test, excluding its end connectors', 'The fiber under test including its end connectors', 'Both test cords plus the fiber', 'Only the connectors, not the fiber',
 'B', 'Method B nulls out both test reference cords. The subsequent measurement captures the loss of the fiber under test plus its two end connectors, but excludes the test cord losses.',
 'TIA-526-14-B', 'medium'),

-- ────────────────────────────────────────────────────────────
-- FOT Module 4: Safety & Standards (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=4),
 'FOT', 'laser_safety',
 'What is the primary hazard associated with invisible infrared laser light used in fiber optic systems?',
 'Skin burns', 'Eye damage, since the beam is invisible and the blink reflex does not activate', 'Hearing loss', 'Electric shock',
 'B', 'Infrared laser light (1310 nm, 1550 nm) is invisible to the human eye. Because there is no blink reflex, retinal damage can occur before the person realizes exposure. Never look into a fiber or connector endface.',
 'IEC 60825-1', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=4),
 'FOT', 'laser_safety',
 'A fiber optic transceiver labeled "Class 1" means:',
 'It is the most dangerous class', 'It is considered eye-safe under normal operating conditions', 'It requires laser safety goggles at all times', 'It can only be used outdoors',
 'B', 'IEC 60825-1 Class 1 lasers are eye-safe under all reasonably foreseeable conditions, including viewing with optical instruments. Most fiber optic transceivers are Class 1.',
 'IEC 60825-1', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=4),
 'FOT', 'OSHA',
 'Fiber scraps from cleaving operations must be disposed of by:',
 'Placing them in regular office trash', 'Collecting in a designated fiber scrap container', 'Sweeping onto the floor', 'Flushing down a drain',
 'B', 'Cleaved fiber shards are invisible glass slivers that can penetrate skin, eyes, or be ingested. They must be collected in a dedicated scrap container (usually with a sticky liner) per OSHA general duty requirements.',
 'OSHA General Duty Clause', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=4),
 'FOT', 'OSHA',
 'Before entering a manhole or underground vault to perform fiber splicing, the technician must:',
 'Turn off the OTDR', 'Test the atmosphere for oxygen deficiency, combustible gases, and toxic gases', 'Begin splicing immediately to minimize exposure time', 'Check email for updated work orders',
 'B', 'Manholes are OSHA-defined permit-required confined spaces (29 CFR 1910.146). Atmospheric monitoring for O₂, LEL, H₂S, and CO must be performed before and during entry.',
 'OSHA 29 CFR 1910.146', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=4),
 'FOT', 'TIA_standards',
 'TIA-568.3-D is the standard that specifies:',
 'Grounding and bonding for telecom', 'Optical fiber cabling and components', 'Fire alarm circuits', 'Wireless access point placement',
 'B', 'TIA-568.3-D covers optical fiber cabling components, transmission performance, and system design. It defines fiber types, connector performance, cable plant testing, and link loss budgets.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=4),
 'FOT', 'TIA_standards',
 'The maximum allowable insertion loss for a mated pair of connectors per TIA-568.3-D is:',
 '0.25 dB', '0.50 dB', '0.75 dB', '1.50 dB',
 'C', 'TIA-568.3-D specifies a maximum of 0.75 dB per mated connector pair for field testing. Factory-terminated connectors should typically achieve ≤0.50 dB.',
 'TIA-568.3-D', 'medium'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=4),
 'FOT', 'TIA_standards',
 'TIA-598-D defines:',
 'Cable pulling tensions', 'Fiber optic color coding for identification', 'Splice loss thresholds', 'OTDR calibration procedures',
 'B', 'TIA-598-D establishes the color coding scheme for optical fibers, buffer tubes, and cables. The 12-color code (blue, orange, green, brown, slate, white, red, black, yellow, violet, rose, aqua) is industry standard.',
 'TIA-598-D', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=4),
 'FOT', 'laser_safety',
 'When inspecting connector endfaces, a technician should always check for active light before using a microscope because:',
 'Active light can damage the microscope lens', 'Optical instruments can focus laser light onto the retina, causing eye injury', 'The light will interfere with contamination analysis', 'Active light causes the ferrule to heat up',
 'B', 'Even Class 1M lasers can become hazardous when viewed through optical instruments like microscopes that concentrate the beam. Always verify fibers are dark before inspection.',
 'IEC 60825-1', 'medium'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=4),
 'FOT', 'OSHA',
 'Personal protective equipment (PPE) required when working with fiber optic cables includes:',
 'Steel-toed boots only', 'Safety glasses and proper disposal containers for fiber scraps', 'Full face respirator', 'Arc flash suit',
 'B', 'Safety glasses protect eyes from fiber shards. Scrap containers prevent slivers from embedding in skin or being left on surfaces. Additional PPE depends on the work environment (confined space, aerial, etc.).',
 'OSHA General Duty Clause', 'easy'),

((SELECT id FROM m WHERE cert_level='FOT' AND module_number=4),
 'FOT', 'TIA_standards',
 'According to TIA-568.1-D, the maximum horizontal cable distance from the telecom room to the work area outlet is:',
 '50 meters', '90 meters', '100 meters', '300 meters',
 'B', 'The permanent link (horizontal cable) is limited to 90 meters. The total channel, including patch cords at each end, must not exceed 100 meters.',
 'TIA-568.1-D', 'easy'),

-- ────────────────────────────────────────────────────────────
-- CFOT Module 1: Advanced Fiber Theory (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=1),
 'CFOT', 'attenuation',
 'The typical attenuation of standard single-mode fiber at 1310 nm is approximately:',
 '0.35 dB/km', '0.22 dB/km', '3.5 dB/km', '1.0 dB/km',
 'A', 'Standard single-mode fiber (G.652) has attenuation of approximately 0.35 dB/km at 1310 nm and 0.22 dB/km at 1550 nm. The lower loss at 1550 nm makes it preferred for long-haul applications.',
 'ITU-T G.652', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=1),
 'CFOT', 'attenuation',
 'The "water peak" in legacy single-mode fiber occurs near which wavelength?',
 '850 nm', '1310 nm', '1383 nm', '1550 nm',
 'C', 'Hydroxyl (OH-) ion contamination in legacy fiber causes increased attenuation near 1383 nm (the E-band water peak). Modern low-water-peak fibers (G.652.D) eliminate this, opening the full spectrum for CWDM.',
 'ITU-T G.652', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=1),
 'CFOT', 'bandwidth',
 'Effective modal bandwidth (EMB) for laser-optimized multimode fiber (OM3) at 850 nm is:',
 '200 MHz·km', '500 MHz·km', '2000 MHz·km', '4700 MHz·km',
 'C', 'OM3 fiber specifies an effective modal bandwidth of 2000 MHz·km at 850 nm for laser sources. This supports 10 Gbps Ethernet (10GBASE-SR) up to 300 meters.',
 'TIA-568.3-D', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=1),
 'CFOT', 'wavelengths',
 'The C-band in optical telecommunications spans the wavelength range of approximately:',
 '1260-1360 nm', '1360-1460 nm', '1530-1565 nm', '1565-1625 nm',
 'C', 'The C-band (Conventional band) covers approximately 1530-1565 nm and is the primary band for DWDM systems and erbium-doped fiber amplifiers (EDFAs). It offers the lowest attenuation in single-mode fiber.',
 'ITU-T G.694.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=1),
 'CFOT', 'dispersion',
 'Chromatic dispersion in single-mode fiber causes pulse broadening because:',
 'Different fiber modes travel at different speeds', 'Different wavelengths of light travel at different velocities in the glass', 'The core diameter varies along the fiber', 'Polarization states rotate unpredictably',
 'B', 'Chromatic dispersion (CD) occurs because the refractive index of glass varies with wavelength (material dispersion) and because the mode field interacts differently with the waveguide at different wavelengths (waveguide dispersion).',
 'ITU-T G.652', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=1),
 'CFOT', 'dispersion',
 'The zero-dispersion wavelength of standard single-mode fiber (G.652) is approximately:',
 '850 nm', '1310 nm', '1550 nm', '1625 nm',
 'B', 'Standard G.652 fiber has zero chromatic dispersion near 1310 nm. Dispersion-shifted fiber (G.653) moves the zero-dispersion point to 1550 nm for long-haul applications.',
 'ITU-T G.652', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=1),
 'CFOT', 'attenuation',
 'Rayleigh scattering in optical fiber is caused by:',
 'Bending of the fiber', 'Microscopic variations in the glass density', 'Connector contamination', 'Moisture absorption',
 'B', 'Rayleigh scattering results from microscopic density fluctuations frozen into the glass during manufacturing. It is the dominant loss mechanism at shorter wavelengths and decreases with the fourth power of wavelength.',
 'General fiber optics theory', 'hard'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=1),
 'CFOT', 'wavelengths',
 'The O-band (Original band) in fiber telecommunications covers the wavelength range:',
 '1260-1360 nm', '1360-1460 nm', '1460-1530 nm', '1530-1565 nm',
 'A', 'The O-band spans 1260-1360 nm and includes the traditional 1310 nm window. It was the first wavelength region widely used for single-mode fiber transmission.',
 'ITU-T G.694.1', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=1),
 'CFOT', 'bandwidth',
 'In a DWDM system, channels are spaced at intervals as narrow as:',
 '20 nm', '0.8 nm (100 GHz)', '50 nm', '200 nm',
 'B', 'Dense wavelength division multiplexing (DWDM) per ITU-T G.694.1 uses channel spacings of 100 GHz (~0.8 nm), 50 GHz (~0.4 nm), or even 25 GHz in modern systems, allowing 40-96+ channels on a single fiber.',
 'ITU-T G.694.1', 'hard'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=1),
 'CFOT', 'dispersion',
 'Polarization mode dispersion (PMD) in single-mode fiber is caused by:',
 'Different wavelengths traveling at different speeds', 'Slight asymmetry in the fiber core causing two polarization states to travel at different velocities', 'Multiple modes interfering with each other', 'Temperature changes in the cladding',
 'B', 'PMD occurs because real single-mode fiber has slight birefringence from core asymmetry, stress, or bending. The two orthogonal polarization states of the fundamental mode propagate at slightly different velocities.',
 'ITU-T G.652', 'hard'),

-- ────────────────────────────────────────────────────────────
-- CFOT Module 2: Splicing Techniques (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=2),
 'CFOT', 'fusion_splicing',
 'A properly executed fusion splice on single-mode fiber should have a typical loss of:',
 '0.3-0.5 dB', '0.02-0.05 dB', '0.5-1.0 dB', '1.0-2.0 dB',
 'B', 'Modern fusion splicers routinely achieve splice losses of 0.02-0.05 dB on single-mode fiber. The splicer aligns fibers precisely and fuses them with an electric arc. Losses above 0.1 dB generally indicate a problem.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=2),
 'CFOT', 'fusion_splicing',
 'The recommended cleave angle for fusion splicing is:',
 'Less than 1 degree', 'Exactly 8 degrees', '3-5 degrees', '10-15 degrees',
 'A', 'A cleave angle of less than 1 degree (ideally <0.5°) is required for low-loss fusion splices. Poor cleave angles prevent proper fiber alignment and result in high splice loss. Most quality cleavers achieve <0.5°.',
 'Equipment manufacturer specs', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=2),
 'CFOT', 'mechanical_splicing',
 'A mechanical splice achieves fiber alignment using:',
 'An electric arc', 'A precision V-groove or alignment sleeve with index-matching gel', 'UV-curable epoxy only', 'Thermal fusion of the glass',
 'B', 'Mechanical splices use a V-groove, alignment channel, or precision sleeve to hold fibers in alignment. Index-matching gel fills the gap between fiber ends to reduce Fresnel reflection losses.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=2),
 'CFOT', 'mechanical_splicing',
 'Typical insertion loss for a mechanical splice is:',
 '0.01-0.02 dB', '0.1-0.5 dB', '1.0-2.0 dB', '3.0-5.0 dB',
 'B', 'Mechanical splices typically achieve 0.1-0.5 dB insertion loss. They are higher loss than fusion splices but require no electricity and are suitable for emergency restoration or low-fiber-count applications.',
 'TIA-568.3-D', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=2),
 'CFOT', 'preparation',
 'When stripping fiber for splicing, the correct order of steps is:',
 'Cleave, strip, clean, splice', 'Strip buffer coating, clean with alcohol, cleave, splice', 'Clean, splice, strip, cleave', 'Cleave, clean, splice, strip',
 'B', 'Proper preparation: (1) strip the buffer/coating with a precision stripper, (2) clean bare fiber with lint-free wipes and isopropyl alcohol, (3) cleave to the specified length, then (4) load into the splicer.',
 'FOA Reference Guide', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=2),
 'CFOT', 'preparation',
 'The standard strip length for fusion splicing is typically:',
 '5-10 mm', '20-40 mm depending on the splicer', '100 mm', '2-3 mm',
 'B', 'Strip length varies by splicer model — typically 20-40 mm. The splicer manual specifies the required length to match its fiber holder spacing. Using the wrong strip length causes fiber position errors.',
 'Equipment manufacturer specs', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=2),
 'CFOT', 'fusion_splicing',
 'A splice protector (heat-shrink sleeve) serves what primary purpose?',
 'Improving optical performance', 'Protecting the bare fiber splice point from mechanical stress and moisture', 'Reducing splice loss', 'Adding bend-insensitive properties',
 'B', 'The splice protector (typically a heat-shrink sleeve with a steel rod) provides mechanical strength and environmental protection for the bare glass splice point, which has no protective coating.',
 'General practice', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=2),
 'CFOT', 'fusion_splicing',
 'Core alignment fusion splicers achieve lower splice losses than V-groove (cladding alignment) splicers because:',
 'They use a hotter arc', 'They actively observe and align the fiber cores using a camera system', 'They strip more coating', 'They use index-matching gel',
 'B', 'Core alignment splicers use a microscope/camera system to directly view and align the fiber cores via a Profile Alignment System (PAS). V-groove splicers align the cladding, assuming core concentricity.',
 'Equipment manufacturer specs', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=2),
 'CFOT', 'fusion_splicing',
 'If a fusion splicer consistently produces high-loss splices, the first troubleshooting step should be:',
 'Replace the splicer', 'Clean the V-grooves, electrodes, and mirrors, and verify cleave quality', 'Increase the arc duration to maximum', 'Switch to mechanical splicing',
 'B', 'Contaminated V-grooves, worn electrodes, and dirty optics are the most common causes of poor splice quality. Cleaning and electrode maintenance should be performed before adjusting splice parameters.',
 'Equipment manufacturer specs', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=2),
 'CFOT', 'mechanical_splicing',
 'Index-matching gel in a mechanical splice reduces loss by:',
 'Increasing the numerical aperture', 'Eliminating the air gap and Fresnel reflection between fiber endfaces', 'Fusing the fibers together', 'Cooling the fiber ends',
 'B', 'The air gap between fiber ends causes approximately 0.3 dB of Fresnel reflection loss. Index-matching gel (with refractive index close to glass, ~1.46) fills this gap and virtually eliminates Fresnel reflection.',
 'General fiber optics theory', 'medium'),

-- ────────────────────────────────────────────────────────────
-- CFOT Module 3: OTDR Fundamentals (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=3),
 'CFOT', 'trace_reading',
 'On an OTDR trace, a fusion splice appears as:',
 'A tall reflective spike', 'A small downward step (loss) with no reflection', 'An upward step (gain)', 'A flat horizontal line',
 'B', 'Fusion splices produce a non-reflective event — a small step down in the backscatter level. Since fused glass has no air gap, there is no Fresnel reflection, only insertion loss visible as a level change.',
 'General OTDR theory', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=3),
 'CFOT', 'trace_reading',
 'A mechanical splice or connector appears on an OTDR trace as:',
 'No visible event', 'A reflective peak (spike) with an associated loss step', 'A continuous upward slope', 'A flat line with no events',
 'B', 'Mechanical splices and connectors contain an air gap or interface that produces Fresnel reflection (a spike) and insertion loss (a step down). The reflection height indicates return loss quality.',
 'General OTDR theory', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=3),
 'CFOT', 'event_identification',
 'A "gainer" on an OTDR trace — where the backscatter level appears to increase at a splice — is caused by:',
 'An actual gain in optical power', 'Different backscatter coefficients between dissimilar fibers', 'A faulty OTDR', 'Moisture in the fiber',
 'B', 'Apparent gainers occur when splicing fibers with different mode field diameters (MFD) or backscatter coefficients. Testing from the opposite direction shows higher loss. Bi-directional averaging reveals the true splice loss.',
 'General OTDR theory', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=3),
 'CFOT', 'dead_zones',
 'The event dead zone of an OTDR is defined as:',
 'The maximum distance the OTDR can measure', 'The minimum distance after a reflective event before the OTDR can detect another event', 'The fiber region with zero loss', 'The area outside the OTDR dynamic range',
 'B', 'The event dead zone is the distance after a reflective event during which the OTDR receiver is saturated and cannot identify another event. Shorter pulse widths reduce dead zones but also reduce dynamic range.',
 'General OTDR theory', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=3),
 'CFOT', 'dead_zones',
 'To minimize dead zones for testing short fiber links, an OTDR operator should:',
 'Use the longest available pulse width', 'Use the shortest available pulse width', 'Increase the averaging time', 'Switch to multimode',
 'B', 'Shorter pulse widths produce shorter dead zones, improving spatial resolution for closely spaced events. The trade-off is reduced dynamic range and more noise. Short links require narrow pulses.',
 'General OTDR theory', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=3),
 'CFOT', 'trace_reading',
 'The slope of the fiber trace on an OTDR display represents:',
 'Connector loss', 'The fiber attenuation rate (dB/km)', 'Splice loss', 'Chromatic dispersion',
 'B', 'The gradual downward slope of the backscatter level between events represents the fiber''s distributed attenuation in dB/km. A steeper slope indicates higher attenuation.',
 'General OTDR theory', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=3),
 'CFOT', 'event_identification',
 'A sharp reflective spike at the end of the fiber on an OTDR trace indicates:',
 'A fusion splice', 'The fiber end (Fresnel reflection from the air-glass interface)', 'A macrobend', 'A water absorption peak',
 'B', 'The fiber end produces a large Fresnel reflection (~4% or about -14 dB) from the glass-to-air interface. This reflective peak, followed by noise floor, marks the physical end of the fiber.',
 'General OTDR theory', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=3),
 'CFOT', 'dead_zones',
 'A launch fiber (pulse suppression fiber) is used with an OTDR to:',
 'Increase the OTDR dynamic range', 'Move the initial dead zone away from the first connector under test', 'Calibrate the wavelength', 'Eliminate all reflections',
 'B', 'The OTDR front-panel connector creates a dead zone that obscures the first connection of the fiber under test. A launch fiber (typically 100-500m) moves this dead zone ahead of the link, allowing accurate testing of the first connector.',
 'General OTDR theory', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=3),
 'CFOT', 'trace_reading',
 'The dynamic range of an OTDR determines:',
 'Its physical size', 'The maximum measurable fiber loss (distance) above the noise floor', 'The color of the display', 'The number of connectors it can identify',
 'B', 'Dynamic range is the difference between the initial backscatter level and the noise floor, measured in dB. Higher dynamic range allows testing of longer fibers or links with more loss events.',
 'General OTDR theory', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=3),
 'CFOT', 'event_identification',
 'Increasing OTDR averaging time improves trace quality by:',
 'Increasing the pulse width', 'Reducing noise through statistical sampling, improving SNR', 'Shortening the dead zone', 'Eliminating ghosts',
 'B', 'Averaging sends multiple pulses and statistically averages the results. This reduces random noise and improves the signal-to-noise ratio (SNR), making small events like splices more visible.',
 'General OTDR theory', 'medium'),

-- ────────────────────────────────────────────────────────────
-- CFOT Module 4: Loss Budgets & Design (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=4),
 'CFOT', 'loss_calculations',
 'A fiber link has 2 km of single-mode fiber (0.35 dB/km at 1310 nm), 4 mated connector pairs (0.75 dB each), and 1 fusion splice (0.3 dB). What is the total loss budget?',
 '3.00 dB', '4.00 dB', '2.50 dB', '5.00 dB',
 'B', 'Loss = Fiber (2 × 0.35 = 0.70 dB) + Connectors (4 × 0.75 = 3.00 dB) + Splice (1 × 0.30 = 0.30 dB) = 4.00 dB total. A design margin of 3 dB is typically added.',
 'TIA-568.3-D', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=4),
 'CFOT', 'loss_calculations',
 'The maximum allowable splice loss per TIA-568.3-D for loss budget calculations is:',
 '0.1 dB', '0.3 dB', '0.75 dB', '1.0 dB',
 'B', 'TIA-568.3-D specifies a maximum of 0.3 dB per splice for loss budget planning. Actual fusion splice losses are typically much lower (0.02-0.05 dB), providing margin.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=4),
 'CFOT', 'link_design',
 'The purpose of including a design margin in a loss budget is to:',
 'Account for future cable degradation, additional splices, and measurement uncertainty', 'Reduce the number of connectors needed', 'Increase the fiber bandwidth', 'Eliminate the need for testing',
 'A', 'Design margin (typically 3 dB) accounts for aging, temperature variations, future repairs (additional splices), connector reterminations, and measurement uncertainties over the link lifetime.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=4),
 'CFOT', 'link_design',
 'For a 10GBASE-LR single-mode link, the maximum channel insertion loss allowed is approximately:',
 '2.0 dB', '6.2 dB', '11.0 dB', '28.0 dB',
 'B', 'IEEE 802.3 specifies a maximum channel insertion loss of approximately 6.2 dB for 10GBASE-LR at 1310 nm over single-mode fiber up to 10 km. The transmitter power and receiver sensitivity define this budget.',
 'IEEE 802.3', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=4),
 'CFOT', 'documentation',
 'A complete fiber link test record should include:',
 'Only the pass/fail result', 'Operator name, date, test method, wavelength, reference values, measured loss, and cable ID', 'Just the OTDR trace image', 'Only the fiber length',
 'B', 'Proper documentation per TIA-526-14-B includes test equipment serial numbers, reference method used, calibration date, wavelengths tested, measured values, pass/fail status, and unique cable/link identification.',
 'TIA-526-14-B', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=4),
 'CFOT', 'loss_calculations',
 'If a transceiver has a minimum launch power of -8 dBm and the receiver sensitivity is -23 dBm, the total power budget is:',
 '15 dB', '23 dB', '8 dB', '31 dB',
 'A', 'Power budget = Minimum transmitter power - Receiver sensitivity = -8 dBm - (-23 dBm) = 15 dB. The link loss budget must be less than this power budget minus any design margin.',
 'IEEE 802.3', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=4),
 'CFOT', 'link_design',
 'When designing a fiber link, testing at both 1310 nm and 1550 nm is important because:',
 'Both wavelengths have identical attenuation', 'Macrobend losses are more apparent at 1550 nm, and attenuation coefficients differ at each wavelength', '1310 nm is used for multimode only', 'Testing at two wavelengths doubles the bandwidth',
 'B', 'Fiber attenuation and bend sensitivity differ at each wavelength. 1550 nm is more sensitive to macrobends, so testing at both wavelengths reveals bends that might not appear at 1310 nm alone.',
 'TIA-568.3-D', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=4),
 'CFOT', 'loss_calculations',
 'Fresnel reflection loss at a glass-to-air interface is approximately:',
 '0.1 dB', '0.15 dB (about 3.5-4%)', '1.0 dB', '3.0 dB',
 'B', 'Fresnel reflection at a glass-air boundary is about 3.5-4% (approximately -14.7 dB return loss, or ~0.15 dB insertion loss). This is why index-matching gel is used in mechanical splices and UPC connectors use physical contact.',
 'General fiber optics theory', 'hard'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=4),
 'CFOT', 'documentation',
 'As-built documentation for a fiber installation should include:',
 'Only the loss test results', 'Cable route maps, splice locations, test results, cable types, fiber assignments, and equipment details', 'Just the purchase orders', 'Only the OTDR traces',
 'B', 'Comprehensive as-built documentation is essential for future maintenance and troubleshooting. TIA-606-C provides guidelines for administration of telecommunications infrastructure.',
 'TIA-606-C', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOT' AND module_number=4),
 'CFOT', 'link_design',
 'The maximum number of connectors allowed in a horizontal fiber link per TIA-568.1-D is:',
 '2 (one at each end)', '4', '6', 'Unlimited',
 'A', 'A horizontal fiber link per TIA-568.1-D consists of one connector at the telecommunications room and one at the work area outlet. No intermediate splices or connectors are permitted in the permanent link.',
 'TIA-568.1-D', 'medium'),

-- ────────────────────────────────────────────────────────────
-- CFOS_S Module 1: Advanced Fusion Splicing (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=1),
 'CFOS_S', 'splice_parameters',
 'The primary splice parameters that affect fusion splice quality are:',
 'Fiber color and jacket type', 'Arc power, arc duration, and pre-fusion gap distance', 'Cable pulling tension and bend radius', 'Wavelength and bandwidth',
 'B', 'Arc power controls the heat applied, arc duration controls the fusion time, and pre-fusion gap determines how close fibers are before the arc fires. These parameters must be optimized for the fiber type being spliced.',
 'Equipment manufacturer specs', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=1),
 'CFOS_S', 'splice_parameters',
 'An "arc check" or "arc calibration" on a fusion splicer should be performed:',
 'Never — factory settings are permanent', 'Before each splicing session, when moving to different altitudes, or after electrode replacement', 'Only once per year', 'Only when splicing ribbon fiber',
 'B', 'Arc intensity is affected by electrode wear, altitude (air density), temperature, and humidity. Arc calibration ensures consistent arc power for reliable splice quality across changing conditions.',
 'Equipment manufacturer specs', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=1),
 'CFOS_S', 'fiber_alignment',
 'Profile alignment system (PAS) in a core-alignment splicer works by:',
 'Physically touching the fiber cores', 'Illuminating fibers from the side and analyzing the transmitted light profile to locate the core', 'Using an OTDR during splicing', 'Measuring electrical resistance',
 'B', 'PAS uses side-illumination and image processing to observe the fiber cross-section. By analyzing the refracted light profile, it identifies the core position and aligns fibers for optimal core-to-core coupling.',
 'Equipment manufacturer specs', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=1),
 'CFOS_S', 'fiber_alignment',
 'When splicing fibers with different mode field diameters (MFD), the expected result is:',
 'Zero loss in both directions', 'Different loss values depending on direction of light propagation', 'Identical loss regardless of direction', 'The splice will always fail',
 'B', 'MFD mismatch causes directional loss variation. Light traveling from smaller to larger MFD sees less loss than the reverse. Bi-directional OTDR testing and averaging is required to determine true splice loss.',
 'General fiber optics theory', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=1),
 'CFOS_S', 'multi-fiber',
 'When splicing multi-fiber cables, fibers must be spliced in a consistent order to:',
 'Save time only', 'Maintain fiber assignment continuity and enable proper network management', 'Reduce the arc power required', 'Improve the fusion temperature',
 'B', 'Consistent fiber identification and splice order ensures that fiber assignments in the network management system match physical connections. Misordered splices create confusion during troubleshooting and rerouting.',
 'TIA-598-D', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=1),
 'CFOS_S', 'splice_parameters',
 'If fusion splice losses are consistently high, and the cleave angle and fiber cleanliness are acceptable, the next step is:',
 'Replace the fiber cable', 'Check electrode condition and perform arc calibration', 'Switch to mechanical splicing', 'Increase the cleave length',
 'B', 'Worn or contaminated electrodes produce inconsistent arcs. Electrode replacement and arc calibration should be performed per the manufacturer''s maintenance schedule (typically every 2000-4000 splices).',
 'Equipment manufacturer specs', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=1),
 'CFOS_S', 'fiber_alignment',
 'Cladding alignment (V-groove) splicers are acceptable for which fiber type?',
 'Only single-mode fiber with high core concentricity requirements', 'Multimode fiber where core-cladding concentricity is less critical', 'Only specialty fiber', 'No fiber types — they are obsolete',
 'B', 'V-groove splicers align the cladding, relying on good core-cladding concentricity. For multimode fiber (larger core, less demanding alignment), this is often acceptable. Single-mode benefits from core alignment.',
 'Equipment manufacturer specs', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=1),
 'CFOS_S', 'splice_parameters',
 'The estimated splice loss displayed by a fusion splicer after completing a splice is:',
 'Always 100% accurate', 'An estimate based on image analysis — OTDR verification provides the definitive loss measurement', 'Meaningless and should be ignored', 'Only valid for multimode fiber',
 'B', 'The splicer estimates loss by analyzing the core alignment images before and after the splice. This is a good indicator but not a substitute for OTDR measurement, which shows actual optical loss under real transmission conditions.',
 'Equipment manufacturer specs', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=1),
 'CFOS_S', 'multi-fiber',
 'When splicing fibers from different cable types (e.g., loose-tube to tight-buffer), the critical consideration is:',
 'Jacket color matching', 'Ensuring fiber types are compatible (matching core size, MFD, and NA)', 'Using different splicer models', 'Splicing in reverse order',
 'B', 'Fibers must be type-compatible. Splicing mismatched fiber types (e.g., 50 µm to 62.5 µm) causes high loss. Verify fiber specifications from cable datasheets before beginning any splice job.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=1),
 'CFOS_S', 'splice_parameters',
 'Hot image or bubble formation during fusion splicing is typically caused by:',
 'Insufficient arc power', 'Excessive arc power or contamination on the fiber endface', 'Using the wrong heat-shrink sleeve', 'Low ambient temperature',
 'B', 'Bubbles or bright spots in the splice region indicate excessive heat or contaminants (dust, coating residue) being burned into the splice. Reduce arc power and ensure thorough fiber cleaning.',
 'Equipment manufacturer specs', 'hard'),

-- ────────────────────────────────────────────────────────────
-- CFOS_S Module 2: Splice Quality & Troubleshooting (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=2),
 'CFOS_S', 'loss_analysis',
 'The most reliable method for determining true splice loss is:',
 'Using the splicer estimated loss display', 'Bi-directional OTDR testing and averaging the results from both directions', 'Visual inspection of the splice point', 'Measuring with a power meter at one end only',
 'B', 'Bi-directional OTDR testing eliminates the effects of different backscatter coefficients between fibers. The average of losses measured from each direction gives the true splice loss per IEC 61746.',
 'IEC 61746', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=2),
 'CFOS_S', 'gainers',
 'An apparent "gainer" of +0.05 dB measured at a splice on an OTDR trace means:',
 'The splice is actually amplifying the light', 'The fiber beyond the splice has a higher backscatter coefficient, making the splice appear as a gain', 'The OTDR is malfunctioning', 'The splice has negative loss',
 'B', 'Apparent gainers occur when the downstream fiber has a higher backscatter coefficient (e.g., slightly larger MFD). Testing from the opposite direction will show a correspondingly higher loss. The true loss is the average of both directions.',
 'General OTDR theory', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=2),
 'CFOS_S', 'gainers',
 'To properly characterize a splice showing a gainer, a technician must:',
 'Accept it as zero loss', 'Test from both directions and calculate the bi-directional average', 'Resplice until the gainer disappears', 'Ignore it — gainers are always acceptable',
 'B', 'IEC 61746 requires bi-directional OTDR measurement for accurate splice loss characterization. The bi-directional average = (Loss_dir1 + Loss_dir2) / 2 always gives a non-negative true loss.',
 'IEC 61746', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=2),
 'CFOS_S', 'MFD_mismatch',
 'Mode field diameter (MFD) mismatch between two single-mode fibers at a splice can be caused by:',
 'Using the same fiber type from the same manufacturer', 'Splicing fibers from different manufacturers or production batches with slightly different MFD values', 'Using the correct cleave angle', 'Proper electrode maintenance',
 'B', 'Even fibers of the same specification from different manufacturers or production runs can have slightly different MFD values (e.g., 9.2 µm vs 9.5 µm), causing measurable directional loss variation at the splice.',
 'ITU-T G.652', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=2),
 'CFOS_S', 'loss_analysis',
 'A splice loss of 0.25 dB measured by OTDR in one direction is borderline. Before resplicing, the technician should:',
 'Accept it immediately', 'Test from the other direction and calculate the bi-directional average', 'Replace the entire cable', 'Increase the OTDR pulse width',
 'B', 'The 0.25 dB measured from one direction may include MFD mismatch effects. The bi-directional average may show the splice is actually well within spec. Always perform bi-directional testing before making resplice decisions.',
 'IEC 61746', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=2),
 'CFOS_S', 'loss_analysis',
 'Excessive splice loss can be caused by all of the following EXCEPT:',
 'Poor cleave quality', 'Contaminated fiber endfaces', 'Correct arc calibration and clean electrodes', 'Core-cladding concentricity errors in the fiber',
 'C', 'Correct arc calibration and clean electrodes are desired conditions that promote good splices. Poor cleaves, dirty fiber, and fiber geometry errors all contribute to excess splice loss.',
 'Equipment manufacturer specs', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=2),
 'CFOS_S', 'MFD_mismatch',
 'The theoretical loss due to MFD mismatch can be calculated using the formula: Loss(dB) = -10 × log₁₀(2×w₁×w₂/(w₁²+w₂²))². If w₁=9.2 µm and w₂=9.8 µm, the MFD mismatch loss is approximately:',
 '0.0 dB', '0.02 dB', '0.10 dB', '0.50 dB',
 'C', 'Using the Gaussian approximation formula with w₁=9.2 and w₂=9.8 µm: the coupling coefficient is about 0.98, giving approximately 0.10 dB loss. This demonstrates that even small MFD differences cause measurable loss.',
 'General fiber optics theory', 'hard'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=2),
 'CFOS_S', 'loss_analysis',
 'When performing a proof test (tension test) on a completed splice, the splice is subjected to:',
 'High optical power to verify transmission', 'A controlled tensile load to verify mechanical integrity', 'Extreme temperature cycling', 'Immersion in water',
 'B', 'Splice proof testing applies a controlled tension (typically 0.5-1.0 lbf for single fiber) to verify the heat-shrink sleeve and fiber can withstand expected installation and environmental stresses.',
 'IEC 62137', 'hard'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=2),
 'CFOS_S', 'loss_analysis',
 'The maximum splice loss typically specified for outside plant (OSP) single-mode fiber links is:',
 '0.01 dB', '0.1 dB', '0.3 dB', '1.0 dB',
 'C', 'TIA-568.3-D specifies 0.3 dB maximum per splice for loss budget calculations. In practice, modern fusion splicers routinely achieve <0.05 dB, but 0.3 dB is the standard used for link design.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=2),
 'CFOS_S', 'MFD_mismatch',
 'When splicing G.652 fiber to G.657 bend-insensitive fiber, the typical additional splice loss due to MFD mismatch is:',
 '0 dB — they are fully compatible', '0.01-0.05 dB due to slight MFD differences', '0.5-1.0 dB always', '3.0 dB or more',
 'B', 'G.657.A fibers are designed for backward compatibility with G.652 and have similar MFD (~9 µm). Splices between them typically show only 0.01-0.05 dB additional loss, well within normal splice variation.',
 'ITU-T G.657', 'medium'),

-- ────────────────────────────────────────────────────────────
-- CFOS_S Module 3: Ribbon & Mass Fusion (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=3),
 'CFOS_S', 'ribbon_fiber',
 'Standard ribbon fiber contains how many fibers per ribbon?',
 '2 fibers', '6 fibers', '12 fibers', '48 fibers',
 'C', 'Standard ribbon fiber contains 12 fibers arranged in a flat array and bonded together. Some newer designs use 4, 8, or 16-fiber ribbons, but 12-fiber is the traditional industry standard.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=3),
 'CFOS_S', 'ribbon_fiber',
 'Rollable ribbon fiber differs from traditional flat ribbon in that:',
 'It uses multimode fiber only', 'Individual fibers are intermittently bonded, allowing the ribbon to roll into a cylindrical shape for higher density', 'It cannot be mass fusion spliced', 'It uses smaller 80 µm cladding fibers only',
 'B', 'Rollable (or SpiderWeb) ribbon uses intermittent bonding between fibers, allowing the ribbon to collapse into a round shape. This enables much higher fiber counts (e.g., 6912 fibers) in standard duct sizes while maintaining mass-splice capability.',
 'GR-20 CORE', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=3),
 'CFOS_S', 'mass_fusion_splicers',
 'A mass fusion splicer can splice an entire 12-fiber ribbon in a single operation, reducing splice time to approximately:',
 '1 minute per fiber', '15-30 seconds for all 12 fibers', '5 minutes for all 12 fibers', '1 hour for all 12 fibers',
 'B', 'Mass fusion splicers align and fuse all 12 fibers simultaneously. The actual fusion takes about 15-30 seconds (after preparation), making them dramatically faster than single-fiber splicing for ribbon cable.',
 'Equipment manufacturer specs', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=3),
 'CFOS_S', 'techniques',
 'When preparing ribbon fiber for mass fusion splicing, the ribbon coating is removed using:',
 'A standard single-fiber stripper', 'A thermal ribbon stripper that heats and removes the matrix coating', 'A razor blade', 'Chemical solvents only',
 'B', 'Thermal ribbon strippers use controlled heat to soften the UV-curable matrix coating, allowing clean removal of the ribbon coating from all 12 fibers simultaneously without damaging the glass fibers.',
 'Equipment manufacturer specs', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=3),
 'CFOS_S', 'techniques',
 'Ribbon fiber is cleaved using:',
 'A standard single-fiber cleaver', 'A ribbon cleaver designed to cleave all fibers in the ribbon simultaneously', 'Scissors', 'A diamond scribe only',
 'B', 'Ribbon cleavers score and break all fibers in the ribbon at once, ensuring uniform cleave angles and consistent fiber end positions. Single-fiber cleavers cannot properly cleave an intact ribbon.',
 'Equipment manufacturer specs', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=3),
 'CFOS_S', 'mass_fusion_splicers',
 'If one fiber in a 12-fiber ribbon mass splice shows unacceptable loss, the recommended action is:',
 'Resplice the entire ribbon', 'Resplice only the bad fiber as a single-fiber splice alongside the ribbon splice', 'Replace the entire cable', 'Accept the loss',
 'B', 'Individual high-loss fibers from a ribbon splice can be re-stripped, cleaved, and single-fiber spliced individually. This avoids redoing the other 11 good splices. The single-fiber splice is stored alongside the ribbon splice in the tray.',
 'General practice', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=3),
 'CFOS_S', 'ribbon_fiber',
 'The splice protector used for ribbon splices is:',
 'The same as single-fiber heat-shrink sleeves', 'A wider heat-shrink sleeve designed to cover the full ribbon width', 'Electrical tape', 'No protection is needed',
 'B', 'Ribbon splice protectors are wider heat-shrink sleeves (typically 40-60 mm) designed to accommodate the full ribbon width. They contain a strength member to prevent bending at the splice point.',
 'Equipment manufacturer specs', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=3),
 'CFOS_S', 'techniques',
 'When organizing ribbon splices in a splice tray, fibers must be routed with a minimum bend radius of:',
 '5 mm', '15 mm', '30 mm or as specified by the tray manufacturer', '100 mm',
 'C', 'Splice trays are designed with routing channels that maintain the minimum bend radius (typically 30 mm for standard fiber). Tighter bends cause macrobend loss that may not be immediately apparent but degrades link performance.',
 'Equipment manufacturer specs', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=3),
 'CFOS_S', 'mass_fusion_splicers',
 'Typical average splice loss for a 12-fiber mass fusion splice on single-mode ribbon fiber is:',
 '0.5-1.0 dB per fiber', '0.02-0.10 dB per fiber', '0.3-0.5 dB per fiber', '1.0-2.0 dB per fiber',
 'B', 'Modern mass fusion splicers achieve average losses of 0.02-0.10 dB per fiber in a ribbon splice. This is comparable to single-fiber core-alignment splicers. Individual fiber losses may vary slightly.',
 'Equipment manufacturer specs', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=3),
 'CFOS_S', 'techniques',
 'High fiber count cables (>432 fibers) increasingly use ribbon fiber because:',
 'It is cheaper per meter', 'Mass fusion splicing dramatically reduces installation time and labor cost', 'Ribbon fiber has lower attenuation', 'Ribbon cables are more flexible',
 'B', 'With 12 fibers spliced simultaneously, ribbon reduces splice time by roughly 10x compared to single-fiber splicing. For a 3456-fiber cable, this means days saved in labor, making ribbon essential for high-count installations.',
 'General practice', 'easy'),

-- ────────────────────────────────────────────────────────────
-- CFOS_S Module 4: Field Splicing Best Practices (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=4),
 'CFOS_S', 'enclosures',
 'A fiber splice enclosure must provide:',
 'Optical amplification', 'Environmental protection, fiber organization, and re-entry capability for future maintenance', 'Power conversion', 'Wavelength filtering',
 'B', 'Splice enclosures protect splice trays from moisture, dust, UV exposure, and physical damage. They must be re-enterable for future maintenance, and organize fiber routing to maintain minimum bend radii.',
 'Telcordia GR-771', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=4),
 'CFOS_S', 'enclosures',
 'The two main categories of splice enclosures are:',
 'Active and passive', 'Dome (or butt) style and horizontal (or in-line) style', 'Single-mode and multimode', 'Indoor and portable',
 'B', 'Dome/butt enclosures are cylindrical and used for aerial/buried applications. Horizontal/in-line enclosures are rectangular and often used where cable enters from both sides. Both must meet GR-771 requirements.',
 'Telcordia GR-771', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=4),
 'CFOS_S', 'environmental_factors',
 'When splicing in cold weather (below 10°C / 50°F), a splicer technician should:',
 'Work faster to avoid fiber cooling', 'Allow the splicer to warm up, perform arc calibration, and protect the work area from wind and moisture', 'Use mechanical splices only', 'Increase the cleave length',
 'B', 'Cold temperatures affect arc consistency and heat-shrink sleeve performance. The splicer should be warmed up, arc calibrated for ambient conditions, and the work area should be protected from wind, moisture, and temperature extremes.',
 'Equipment manufacturer specs', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=4),
 'CFOS_S', 'environmental_factors',
 'Wind is a concern during field splicing because:',
 'It cools the arc too quickly', 'Airborne particles contaminate bare fiber, and air currents can move bare fiber strands', 'It increases fiber attenuation', 'It affects the OTDR readings',
 'B', 'Wind carries dust and debris that can contaminate stripped fiber. Even small particles burned into a fusion splice cause high loss. A splice tent or vehicle provides a controlled, clean environment.',
 'General practice', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=4),
 'CFOS_S', 'documentation',
 'A splice record should document all of the following EXCEPT:',
 'Splice loss per fiber (estimated and/or OTDR-verified)', 'Cable and fiber identification per TIA-598-D color code', 'The technician''s lunch break times', 'Date, location, enclosure type, and tray layout',
 'C', 'Splice records must include fiber identification, measured losses, enclosure location, tray assignments, cable information, date, and technician name. Personal break times are not part of splice documentation.',
 'TIA-606-C', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=4),
 'CFOS_S', 'documentation',
 'Proper fiber slack storage at a splice point requires:',
 'Cutting fiber to exact length with no slack', 'Maintaining a service loop of sufficient length to re-enter the enclosure and resplice if needed', 'Wrapping excess fiber around the cable', 'No slack is ever needed',
 'B', 'A service loop (typically 3-10 meters depending on the application) allows future re-entry for resplicing or rerouting. Without adequate slack, a single bad splice could require pulling new cable.',
 'General practice', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=4),
 'CFOS_S', 'enclosures',
 'When re-entering a splice enclosure for maintenance, the technician should first:',
 'Cut all existing splices to start fresh', 'Photograph the existing tray layout and document the current configuration', 'Remove all splice trays immediately', 'Pull additional cable',
 'B', 'Documenting the existing configuration before disturbing anything prevents errors during reassembly. Photos of tray routing, fiber assignments, and slack storage provide a reference for restoration.',
 'General practice', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=4),
 'CFOS_S', 'environmental_factors',
 'Splice enclosures used in underground (direct-buried or duct) applications must meet:',
 'No special requirements', 'Environmental sealing requirements for water immersion, temperature cycling, and mechanical load', 'Only aesthetics requirements', 'Indoor fire rating only',
 'B', 'Underground enclosures must withstand water submersion, soil pressure, temperature extremes (-40°C to +70°C), and potential flooding. GR-771 specifies rigorous environmental testing requirements.',
 'Telcordia GR-771', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=4),
 'CFOS_S', 'enclosures',
 'The maximum number of splice trays in an enclosure is determined by:',
 'The number of splicers available', 'The enclosure capacity and the fiber count of the cables being spliced', 'Government regulation', 'The color of the cable jacket',
 'B', 'Enclosure capacity varies by model. The total tray count must accommodate all fiber splices while maintaining proper bend radius. Exceeding capacity causes fiber damage and makes re-entry difficult.',
 'Equipment manufacturer specs', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_S' AND module_number=4),
 'CFOS_S', 'documentation',
 'After completing a splice job, the OTDR test should be performed:',
 'Only if the customer requests it', 'On every fiber in both directions to create a complete splice loss record', 'Only from one direction', 'Only on the first and last fiber',
 'B', 'Bi-directional OTDR testing of every fiber provides a complete baseline record. This data is essential for acceptance testing, future troubleshooting, and verifying that all splices meet specification.',
 'TIA-526-14-B', 'easy'),

-- ────────────────────────────────────────────────────────────
-- CFOS_T Module 1: Advanced OTDR Analysis (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=1),
 'CFOS_T', 'bi-directional_testing',
 'Bi-directional OTDR testing is required because:',
 'Single-direction testing is always inaccurate', 'Different backscatter coefficients in spliced fibers cause directional loss variations that must be averaged', 'The OTDR can only detect events in one direction', 'It doubles the test speed',
 'B', 'Single-direction OTDR measurements at splices between dissimilar fibers may show apparent gains or inflated losses due to backscatter coefficient differences. Bi-directional averaging per IEC 61746 eliminates this error.',
 'IEC 61746', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=1),
 'CFOS_T', 'bi-directional_testing',
 'The formula for calculating true splice loss from bi-directional OTDR measurements is:',
 'Maximum of the two values', 'Average: (Loss_A→B + Loss_B→A) / 2', 'Minimum of the two values', 'Sum of both values',
 'B', 'The bi-directional average eliminates the effect of backscatter coefficient differences. If one direction shows +0.15 dB and the other shows -0.05 dB (gainer), the true loss is (0.15 + (-0.05))/2 = 0.05 dB.',
 'IEC 61746', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=1),
 'CFOS_T', 'averaging',
 'Increasing the averaging count on an OTDR from 10 seconds to 3 minutes will:',
 'Increase the pulse width', 'Improve the signal-to-noise ratio by approximately 5 dB, making weak events more visible', 'Shorten the dead zone', 'Change the wavelength',
 'B', 'SNR improvement follows the relationship: improvement(dB) = 5 × log₁₀(T₂/T₁). Going from 10s to 180s: 5 × log₁₀(18) ≈ 6.3 dB improvement. Longer averaging reveals events that are closer to the noise floor.',
 'General OTDR theory', 'hard'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=1),
 'CFOS_T', 'dynamic_range',
 'An OTDR with a dynamic range of 35 dB can test a fiber link with a total loss (including all events) of up to:',
 '35 dB before events disappear below the noise floor', '70 dB', '17.5 dB', '3.5 dB',
 'A', 'Dynamic range represents the maximum measurable loss between the initial backscatter level and the noise floor. A 35 dB OTDR can characterize events until the cumulative fiber and event loss reaches 35 dB.',
 'General OTDR theory', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=1),
 'CFOS_T', 'dynamic_range',
 'To increase OTDR dynamic range, a technician can:',
 'Shorten the pulse width', 'Use a longer pulse width and increase averaging time', 'Reduce the wavelength to 650 nm', 'Remove the launch fiber',
 'B', 'Longer pulse widths inject more energy, increasing the backscatter signal level. Combined with longer averaging to reduce noise, dynamic range is maximized. The trade-off is reduced spatial resolution (longer dead zones).',
 'General OTDR theory', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=1),
 'CFOS_T', 'bi-directional_testing',
 'When performing bi-directional OTDR testing, the same test parameters (pulse width, range, wavelength) should be used in both directions to:',
 'Save battery power', 'Ensure consistent and comparable measurements for accurate averaging', 'Reduce testing time', 'Comply with color-coding standards',
 'B', 'Using identical parameters ensures that differences in measured values are due to actual fiber and event characteristics, not measurement setup variations. This is essential for valid bi-directional averaging.',
 'IEC 61746', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=1),
 'CFOS_T', 'averaging',
 'Real-time (live) mode on an OTDR is best used for:',
 'Final acceptance testing', 'Quick fault finding and verifying fiber continuity', 'Detailed splice loss analysis', 'Generating official test reports',
 'B', 'Real-time mode displays a continuously updating trace without averaging. It is useful for quickly checking fiber continuity, finding approximate fault locations, and verifying connections before performing a full averaged test.',
 'General OTDR theory', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=1),
 'CFOS_T', 'dynamic_range',
 'Ghost reflections on an OTDR trace are caused by:',
 'Actual events in the fiber', 'Highly reflective events causing the pulse to bounce back and forth, creating false events at multiples of the real event distance', 'Fiber breaks', 'Incorrect wavelength selection',
 'B', 'Ghosts appear when a strong reflection (e.g., from an open connector) bounces between the OTDR front panel and the reflective event. They appear at exact multiples of the reflective event distance and disappear when the reflection is eliminated.',
 'General OTDR theory', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=1),
 'CFOS_T', 'bi-directional_testing',
 'A receive fiber (tail fiber) at the far end of the link under test serves a similar purpose to the launch fiber by:',
 'Boosting the signal', 'Allowing the OTDR to characterize the last connector of the link, which would otherwise be hidden in the far-end dead zone', 'Adding gain to the system', 'Filtering out noise',
 'B', 'The receive (tail) fiber extends beyond the last connector, allowing the OTDR to see the loss and reflection of that final connection. Without it, the last event merges with the end-of-fiber reflection.',
 'General OTDR theory', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=1),
 'CFOS_T', 'averaging',
 'The OTDR sampling resolution (data point spacing) is determined by:',
 'The pulse width only', 'The selected distance range — shorter ranges provide closer data point spacing', 'The fiber type', 'The connector type',
 'B', 'Sampling resolution is tied to the distance range setting. A shorter range means more samples per unit distance, providing finer spatial detail. For short links, selecting a short range improves event characterization.',
 'General OTDR theory', 'medium'),

-- ────────────────────────────────────────────────────────────
-- CFOS_T Module 2: Tier 1 & Tier 2 Testing (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=2),
 'CFOS_T', 'insertion_loss',
 'Tier 1 (basic) fiber testing per TIA-568.3-D measures:',
 'OTDR trace and event analysis', 'Insertion loss and length using a light source and power meter (LSPM)', 'Chromatic dispersion and PMD', 'Bandwidth and bit error rate',
 'B', 'Tier 1 testing uses a calibrated light source and power meter to measure end-to-end insertion loss. Length is measured or calculated. This is the minimum required test for link certification.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=2),
 'CFOS_T', 'OTDR_traces',
 'Tier 2 testing adds which additional test beyond Tier 1?',
 'Chromatic dispersion', 'OTDR testing for individual event characterization', 'Bandwidth measurement', 'PMD measurement',
 'B', 'Tier 2 adds OTDR testing to Tier 1 results. The OTDR trace identifies and measures individual events (connectors, splices, bends) along the link, providing diagnostic information that LSPM cannot.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=2),
 'CFOS_T', 'test_standards',
 'TIA-526-14-B defines test methods for:',
 'Copper cable testing', 'Optical fiber field testing of installed cable plant', 'Wireless network testing', 'Coaxial cable testing',
 'B', 'TIA-526-14-B (OFSTP-14) specifies the standard methods for field testing installed multimode and single-mode optical fiber cable plant, including reference procedures, test methods, and measurement techniques.',
 'TIA-526-14-B', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=2),
 'CFOS_T', 'insertion_loss',
 'The 1-cord reference method (Method A) includes in its measurement:',
 'Only the fiber under test', 'The fiber under test plus the adapter at the far end', 'Both test cords', 'Neither test cord',
 'B', 'Method A references with one cord on the source side. The measurement includes the fiber under test, all its connectors/splices, plus the adapter coupling at the meter end. It excludes the source-side test cord.',
 'TIA-526-14-B', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=2),
 'CFOS_T', 'test_standards',
 'When a Tier 1 test shows a PASS result but the margin is very small (measured loss within 0.5 dB of the budget), it is recommended to:',
 'Accept the result without further action', 'Perform Tier 2 (OTDR) testing to identify if any individual event contributes excessive loss', 'Fail the link', 'Repeat the Tier 1 test ten times',
 'B', 'Small margins suggest potential issues. Tier 2 OTDR testing can reveal if a single event (bad connector, poor splice) is consuming most of the budget, which may warrant corrective action for long-term reliability.',
 'TIA-568.3-D', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=2),
 'CFOS_T', 'insertion_loss',
 'The maximum link loss for a single-mode horizontal channel (90m permanent link + 10m patch cords) at 1310 nm with 2 connector pairs is approximately:',
 '0.5 dB', '2.0 dB', '5.0 dB', '10.0 dB',
 'B', 'Fiber loss: 0.1 km × 0.5 dB/km = 0.05 dB (using worst-case indoor fiber). Connectors: 2 × 0.75 dB = 1.50 dB. Total ≈ 1.55 dB. With margin, a 2.0 dB budget is typical for short horizontal links.',
 'TIA-568.3-D', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=2),
 'CFOS_T', 'OTDR_traces',
 'An OTDR trace showing a significantly steeper slope in one fiber segment compared to adjacent segments suggests:',
 'Normal fiber behavior', 'The segment has higher attenuation, possibly due to stress, macrobends, or different fiber type', 'The OTDR needs calibration', 'The fiber is single-mode in that section only',
 'B', 'A steeper slope indicates higher attenuation in that segment. Causes include macrobends (tight cable routing), fiber stress, water penetration (OH- absorption), or a different fiber type being spliced in.',
 'General OTDR theory', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=2),
 'CFOS_T', 'test_standards',
 'When reporting Tier 1 test results, the report must include:',
 'Only pass or fail', 'Test date, tester ID, instrument model/serial, wavelength(s), reference method, measured loss, pass/fail status, and link ID', 'Only the OTDR trace file', 'Only the measured dB value',
 'B', 'Complete test documentation per TIA-526-14-B provides traceability and accountability. This data is essential for warranty claims, acceptance testing, and future baseline comparisons.',
 'TIA-526-14-B', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=2),
 'CFOS_T', 'OTDR_traces',
 'When the OTDR trace shows a reflective event followed by continued fiber trace, this indicates:',
 'A fiber break', 'A connector, mechanical splice, or other reflective (non-catastrophic) event', 'The end of the fiber', 'An open circuit',
 'B', 'Reflective events with continued backscatter beyond them indicate in-line connections (connectors, mechanical splices). A fiber break or end would show reflection followed by noise floor with no continued trace.',
 'General OTDR theory', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=2),
 'CFOS_T', 'insertion_loss',
 'Optical return loss (ORL) for a fiber link is measured in dB and represents:',
 'The total insertion loss', 'The ratio of reflected light to incident light — higher values indicate less reflection', 'The bandwidth of the link', 'The length of the fiber',
 'B', 'ORL is the ratio of launched power to total reflected power returning to the source, expressed as a positive dB value. A higher ORL value (e.g., 55 dB) means less reflection and is better. APC connectors achieve ORL >60 dB.',
 'TIA-568.3-D', 'medium'),

-- ────────────────────────────────────────────────────────────
-- CFOS_T Module 3: Troubleshooting with Test Equipment (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=3),
 'CFOS_T', 'fault_location',
 'An OTDR shows a large reflective event at 2,345 meters with no backscatter beyond it. This most likely indicates:',
 'A connector', 'A fiber break or cut at that location', 'A fusion splice', 'Normal fiber attenuation',
 'B', 'A large reflection followed by noise floor (no continuing fiber trace) indicates a fiber break, cut, or open connector at that distance. The distance reading helps locate the fault in the field.',
 'General OTDR theory', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=3),
 'CFOS_T', 'macro-bends',
 'A macrobend in a fiber link appears on an OTDR trace as:',
 'A reflective spike', 'A localized non-reflective loss (step down) without reflection', 'An upward gain', 'No visible event',
 'B', 'Macrobends cause light to escape the core without reflection, appearing as a non-reflective loss event on the OTDR trace. Testing at 1550 nm shows macrobend losses more clearly than at 1310 nm.',
 'General OTDR theory', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=3),
 'CFOS_T', 'macro-bends',
 'To confirm that a non-reflective loss event is a macrobend and not a splice, a technician can:',
 'Test at 850 nm only', 'Compare OTDR traces at 1310 nm and 1550 nm — macrobend loss increases significantly at 1550 nm', 'Use a VFL only', 'Measure the fiber temperature',
 'B', 'Macrobend loss is wavelength-dependent: loss at 1550 nm is significantly higher than at 1310 nm for the same bend. If a non-reflective event shows much more loss at 1550 nm, it is likely a bend, not a splice.',
 'General OTDR theory', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=3),
 'CFOS_T', 'reflectance',
 'High reflectance at a connector (>-35 dB return loss) typically indicates:',
 'A perfect connection', 'A contaminated, damaged, or improperly mated connector endface', 'Normal APC performance', 'The connector is new',
 'B', 'High reflectance (low return loss value) at a connector suggests contamination, endface damage (scratches, cracks), air gaps, or APC-to-UPC mismating. Good UPC connectors achieve <-50 dB reflectance.',
 'TIA-568.3-D', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=3),
 'CFOS_T', 'fault_location',
 'When using a VFL to locate a fault in a short fiber run, the technician looks for:',
 'OTDR trace anomalies', 'Visible red light escaping from the cable at the fault point', 'Changes in fiber color', 'Temperature changes in the cable',
 'B', 'The VFL emits visible red light (650 nm) that escapes at breaks, tight bends, and cracked connectors. In a dark environment, the red glow is visible through the cable jacket at the fault location.',
 'General practice', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=3),
 'CFOS_T', 'fault_location',
 'The OTDR distance reading to a fault may differ from the actual physical cable length because:',
 'OTDRs are always inaccurate', 'The OTDR calculates distance using the group index of refraction (IOR), which may not exactly match the installed fiber, plus cable routing adds slack', 'The speed of light is variable', 'The fault moves over time',
 'B', 'OTDR distance = (time × c) / (2 × IOR). If the programmed IOR does not match the fiber, or if cable slack, coils, and indirect routing add length, the OTDR distance will differ from the as-built route length.',
 'General OTDR theory', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=3),
 'CFOS_T', 'macro-bends',
 'A technician discovers that a fiber link has 2 dB more loss at 1550 nm than at 1310 nm, beyond what attenuation differences would explain. The most likely cause is:',
 'A bad splice', 'One or more macrobends in the fiber route', 'Chromatic dispersion', 'A faulty transceiver',
 'B', 'Excessive wavelength-dependent loss (beyond normal attenuation coefficient differences) strongly indicates macrobend loss. Locating and correcting the bend (minimum bend radius violation) will restore normal performance.',
 'General OTDR theory', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=3),
 'CFOS_T', 'reflectance',
 'Cleaning a contaminated connector endface and re-testing should:',
 'Have no effect on test results', 'Reduce insertion loss and reduce reflectance (improve return loss)', 'Increase reflectance', 'Only affect the ORL, not insertion loss',
 'B', 'Contamination causes both excess insertion loss (light absorbed/scattered by particles) and excess reflectance (light reflected off contamination back toward the source). Cleaning addresses both issues.',
 'IEC 61300-3-35', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=3),
 'CFOS_T', 'fault_location',
 'When troubleshooting an intermittent fiber fault, the most effective approach is:',
 'Replace the entire cable immediately', 'Monitor with OTDR while physically manipulating suspected cable segments and connectors', 'Wait for the fault to become permanent', 'Switch to copper cabling',
 'B', 'Intermittent faults are often caused by loose connectors, marginal bends, or environmental sensitivity. Real-time OTDR monitoring while gently manipulating suspected areas can identify the fault location when the intermittent condition occurs.',
 'General practice', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=3),
 'CFOS_T', 'reflectance',
 'An OTDR trace showing a reflective event where none should exist (e.g., mid-span in a continuous cable) could indicate:',
 'A properly installed cable', 'A cracked fiber, mechanical damage, or an unauthorized/undocumented splice', 'Normal fiber backscatter', 'An OTDR software error',
 'B', 'Unexpected reflective events in a continuous fiber span indicate physical damage (cracks, crushing) or unauthorized mechanical splices. The reflection comes from an air gap or glass fracture at the damage point.',
 'General OTDR theory', 'hard'),

-- ────────────────────────────────────────────────────────────
-- CFOS_T Module 4: Test Documentation & Compliance (10 questions)
-- ────────────────────────────────────────────────────────────

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=4),
 'CFOS_T', 'test_reports',
 'A fiber optic test report should be generated and stored for:',
 'Only failed links', 'Every tested link, regardless of pass/fail status, as part of the permanent installation record', 'Only links longer than 1 km', 'Only customer-facing links',
 'B', 'Complete test records for all links form the installation baseline. Pass records prove compliance, while fail records document issues and resolutions. These records are essential for warranty, acceptance, and future maintenance.',
 'TIA-526-14-B', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=4),
 'CFOS_T', 'test_reports',
 'Test equipment used for certification testing should have calibration traceability to:',
 'The manufacturer only', 'A national metrology institute (NIST in the US)', 'The contractor who installed the cable', 'No specific standard',
 'B', 'Test equipment calibration must be traceable to national standards (e.g., NIST) to ensure measurement accuracy and legal defensibility. Calibration certificates should accompany test reports.',
 'ISO 17025', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=4),
 'CFOS_T', 'acceptance_criteria',
 'The acceptance criterion for a fiber link test is determined by:',
 'The OTDR manufacturer', 'The loss budget calculated from the design specifications and applicable TIA/IEEE standards', 'The technician''s judgment', 'The cable color',
 'B', 'Pass/fail criteria come from the link loss budget, which is calculated based on fiber length, number of connectors and splices, and the applicable standard (TIA-568.3-D maximum values). IEEE equipment standards may also apply.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=4),
 'CFOS_T', 'acceptance_criteria',
 'If a tested link fails the loss budget, the technician should:',
 'Modify the loss budget to make the link pass', 'Identify the highest-loss events (via OTDR), remediate them, and retest', 'Ignore the failure', 'Switch the test wavelength until it passes',
 'B', 'OTDR Tier 2 testing identifies which events contribute the most loss. The technician should clean or replace the worst connectors, re-splice high-loss splices, or correct macrobends, then retest to verify compliance.',
 'TIA-568.3-D', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=4),
 'CFOS_T', 'standards',
 'TIA-606-C covers:',
 'Fiber testing methods', 'Administration standard for telecommunications infrastructure — labeling, records, and documentation', 'Grounding and bonding', 'Fire stopping',
 'B', 'TIA-606-C provides guidelines for labeling, documentation, and record-keeping of telecommunications infrastructure including fiber cables, patch panels, splice points, and pathways.',
 'TIA-606-C', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=4),
 'CFOS_T', 'test_reports',
 'An OTDR trace file (.sor format) should be included in test documentation because:',
 'It proves the tester was on site', 'It provides a complete baseline showing every event, which can be compared to future tests for troubleshooting', 'It is required by OSHA', 'It replaces the need for a written report',
 'B', 'SOR (Standard OTDR Record) files contain the complete trace data for every event along the fiber. Baseline SOR files enable comparison testing: future traces can be overlaid to identify degradation or new faults.',
 'Bellcore GR-196', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=4),
 'CFOS_T', 'acceptance_criteria',
 'When test results are marginal (close to the pass/fail threshold), which factor should be considered?',
 'Cable jacket color', 'Measurement uncertainty of the test equipment', 'Time of day', 'The technician''s seniority',
 'B', 'All measurements have uncertainty. If measured loss plus measurement uncertainty exceeds the limit, the link may actually fail. Test reports should note marginal results and recommend monitoring or remediation.',
 'ISO/IEC 14763-3', 'hard'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=4),
 'CFOS_T', 'standards',
 'ISO/IEC 14763-3 covers:',
 'Copper cable testing', 'Optical fiber testing of installed cabling per international standards', 'Wireless testing', 'Power cable testing',
 'B', 'ISO/IEC 14763-3 is the international standard for testing optical fiber cabling installations. It specifies reference procedures, measurement methods, and reporting requirements, paralleling TIA-526-14-B.',
 'ISO/IEC 14763-3', 'medium'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=4),
 'CFOS_T', 'test_reports',
 'When delivering final test documentation to a customer, the package should include:',
 'Only a verbal summary', 'Written test reports, OTDR trace files, splice records, as-built drawings, and equipment calibration certificates', 'Only the invoice', 'Only photographs of the installation',
 'B', 'A comprehensive documentation package provides the customer with everything needed for future maintenance, troubleshooting, and system upgrades. This is a contractual deliverable on most fiber installation projects.',
 'General practice', 'easy'),

((SELECT id FROM m WHERE cert_level='CFOS_T' AND module_number=4),
 'CFOS_T', 'acceptance_criteria',
 'A fiber link tested at both 1310 nm and 1550 nm passes at 1310 nm but fails at 1550 nm. The most likely explanation is:',
 'The power meter is faulty at 1550 nm', 'The link contains macrobend(s) that cause wavelength-dependent loss exceeding the budget at 1550 nm', 'Single-mode fiber does not work at 1550 nm', 'The connectors are only rated for 1310 nm',
 'B', 'Macrobend loss is significantly higher at 1550 nm than at 1310 nm. A link with marginal bends may pass at 1310 nm but fail at 1550 nm. Locating and correcting the bend(s) using OTDR comparison should resolve the failure.',
 'TIA-568.3-D', 'medium');
