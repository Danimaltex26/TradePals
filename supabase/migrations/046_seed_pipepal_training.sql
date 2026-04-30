-- Seed PipePal training modules & questions (plumbing/pipefitting)
-- Cert levels: APPRENTICE, JOURNEYMAN, MASTER
-- 4 modules per level = 12 modules, 10 questions per module = 120 questions

INSERT INTO pipepal.training_modules (cert_level, module_number, title, topic_list, estimated_minutes, exam_domain_weight, is_published) VALUES
-- APPRENTICE
('APPRENTICE', 1, 'Plumbing Fundamentals', ARRAY['Pipe materials','Fitting types','Joint methods','Water pressure basics','Fixture rough-in dimensions'], 45, 0.30, true),
('APPRENTICE', 2, 'DWV Systems', ARRAY['Drain sizing','Vent requirements','Trap design','Grade and slope','Fixture units'], 50, 0.25, true),
('APPRENTICE', 3, 'Water Supply Basics', ARRAY['Supply pipe sizing','Pressure regulation','Hot water systems','Cross-connection control','Pipe support spacing'], 45, 0.25, true),
('APPRENTICE', 4, 'Safety & Tools', ARRAY['PPE requirements','Soldering safety','Trenching hazards','Tool identification','Lockout/tagout'], 40, 0.20, true),
-- JOURNEYMAN
('JOURNEYMAN', 1, 'Code Compliance (IPC/UPC)', ARRAY['IPC structure','UPC requirements','Permit process','Inspection points','Code calculations'], 60, 0.30, true),
('JOURNEYMAN', 2, 'Gas Piping Systems', ARRAY['Gas pipe sizing','BTU load calculations','Appliance venting','Leak testing','CSST installation'], 55, 0.25, true),
('JOURNEYMAN', 3, 'Backflow Prevention', ARRAY['Cross-connection types','Backflow preventer types','Annual testing','Installation requirements','Hazard assessment'], 50, 0.25, true),
('JOURNEYMAN', 4, 'Commercial Plumbing', ARRAY['Fixture count calculations','Grease interceptors','Storm drainage','Multi-story risers','Expansion compensation'], 55, 0.20, true),
-- MASTER
('MASTER', 1, 'System Design & Sizing', ARRAY['WSFU calculations','Pipe sizing methods','Pump selection','Recirculation systems','Pressure loss calculations'], 65, 0.30, true),
('MASTER', 2, 'Medical Gas Systems', ARRAY['NFPA 99 requirements','Oxygen piping','Vacuum systems','Brazing procedures','Alarm systems'], 60, 0.25, true),
('MASTER', 3, 'Project Management', ARRAY['Blueprint reading','Material takeoffs','Scheduling','Labor estimation','Change order management'], 55, 0.20, true),
('MASTER', 4, 'Advanced Troubleshooting', ARRAY['Camera inspection','Pressure testing','Leak detection','System balancing','Root cause analysis'], 50, 0.25, true);

WITH m AS (SELECT id, cert_level, module_number FROM pipepal.training_modules)
INSERT INTO pipepal.training_questions (module_id, cert_level, topic, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, standard_reference, difficulty) VALUES

-- ============================================================
-- APPRENTICE Module 1: Plumbing Fundamentals (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'Pipe materials',
 'Which pipe material is most commonly used for residential water supply lines installed inside the building?',
 'Cast iron', 'Copper Type L', 'ABS', 'Clay',
 'B', 'Copper Type L is the standard choice for interior residential water supply due to its corrosion resistance, reliability, and code acceptance.', 'IPC 605.3', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'Fitting types',
 'What type of fitting is used to change direction by 90 degrees in a drainage system while maintaining proper flow?',
 'Short-radius 90° elbow', 'Long-sweep 90° elbow', 'Street elbow', 'Reducing coupling',
 'B', 'Long-sweep 90° elbows are required in drainage systems to prevent blockages and maintain proper flow characteristics.', 'IPC 706.3', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'Joint methods',
 'When soldering copper pipe joints, what is the minimum overlap (insertion depth) for a 3/4-inch fitting?',
 '1/4 inch', '1/2 inch', '3/4 inch', '1 inch',
 'C', 'The insertion depth for soldered copper fittings should approximately equal the pipe diameter. For 3/4-inch pipe, this is 3/4 inch.', 'ASTM B828', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'Water pressure basics',
 'What is the maximum allowable static water pressure for a residential plumbing system?',
 '60 psi', '80 psi', '100 psi', '120 psi',
 'B', 'The IPC and UPC both limit static water pressure to 80 psi at fixture outlets. A pressure-reducing valve is required when supply pressure exceeds this.', 'IPC 604.8', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'Fixture rough-in dimensions',
 'What is the standard rough-in distance from the finished wall to the center of the closet flange for a toilet?',
 '10 inches', '12 inches', '14 inches', '15 inches',
 'B', 'The standard toilet rough-in dimension is 12 inches from the finished wall to the center of the closet flange.', 'IPC Table 405.3.1', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'Pipe materials',
 'PEX tubing is NOT suitable for which application?',
 'Hot water supply', 'Cold water supply', 'Outdoor UV-exposed runs', 'Radiant floor heating',
 'C', 'PEX degrades under prolonged UV exposure and must not be used in outdoor applications exposed to sunlight unless sleeved or protected.', 'IPC 605.15', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'Fitting types',
 'A wye fitting in a DWV system is primarily used for what purpose?',
 'Connecting a branch line at a 45-degree angle', 'Reducing pipe size', 'Creating a clean-out point', 'Connecting vent to drain at 90 degrees',
 'A', 'A wye fitting connects a branch line to the main drain at a 45-degree angle, promoting smooth flow and reducing turbulence.', 'IPC 706.3', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'Joint methods',
 'What type of joint is required for underground cast iron soil pipe?',
 'Soldered joint', 'Hubless coupling with stainless steel band', 'Threaded joint', 'Compression fitting',
 'B', 'Underground cast iron soil pipe commonly uses hubless couplings with stainless steel shield and clamp bands (no-hub couplings).', 'IPC 705.5', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'Water pressure basics',
 'Which device is installed to reduce incoming water pressure that exceeds 80 psi?',
 'Check valve', 'Pressure-reducing valve (PRV)', 'Expansion tank', 'Backflow preventer',
 'B', 'A pressure-reducing valve (PRV) is required when the supply pressure exceeds 80 psi to protect fixtures and piping.', 'IPC 604.8', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'Fixture rough-in dimensions',
 'What is the minimum clearance required in front of a toilet from the front of the bowl to any obstruction?',
 '15 inches', '18 inches', '21 inches', '24 inches',
 'C', 'Code requires a minimum of 21 inches of clearance in front of a toilet from the front edge of the fixture to any wall or obstruction.', 'IPC 405.3.1', 'medium'),

-- ============================================================
-- APPRENTICE Module 2: DWV Systems (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'Drain sizing',
 'What is the minimum drain size for a residential toilet (water closet)?',
 '2 inches', '3 inches', '4 inches', '1-1/2 inches',
 'B', 'A water closet requires a minimum 3-inch drain line. The building drain/sewer after the toilet connection is typically 3 or 4 inches.', 'IPC Table 709.1', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'Vent requirements',
 'What is the primary purpose of a plumbing vent system?',
 'To provide hot air for faster drainage', 'To equalize pressure and prevent trap siphonage', 'To supply oxygen for aerobic decomposition', 'To increase water flow velocity',
 'B', 'Vents equalize air pressure in the drainage system, preventing trap siphonage and back-pressure that would allow sewer gases to enter the building.', 'IPC 901.2', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'Trap design',
 'What is the required trap seal depth for a standard plumbing fixture trap?',
 '1 inch minimum', '2 to 4 inches', '4 to 6 inches', '6 inches minimum',
 'B', 'Fixture traps must maintain a water seal of not less than 2 inches and not more than 4 inches.', 'IPC 1002.1', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'Grade and slope',
 'What is the minimum slope for a 3-inch horizontal drain pipe?',
 '1/16 inch per foot', '1/8 inch per foot', '1/4 inch per foot', '1/2 inch per foot',
 'B', 'Drain pipes 3 inches and larger require a minimum slope of 1/8 inch per foot. Pipes 2-1/2 inches and smaller require 1/4 inch per foot.', 'IPC 704.1', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'Fixture units',
 'How many drainage fixture units (DFU) does a standard residential bathtub represent?',
 '1 DFU', '2 DFU', '3 DFU', '4 DFU',
 'B', 'A bathtub or combination bath/shower is rated at 2 DFU for drainage calculations.', 'IPC Table 709.1', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'Drain sizing',
 'What is the minimum size of a building sewer for a residential dwelling?',
 '2 inches', '3 inches', '4 inches', '6 inches',
 'B', 'The minimum building sewer size is 3 inches for residential, though 4 inches is common practice and required when serving more than 2 water closets.', 'IPC 703.1', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'Vent requirements',
 'What is the minimum vent pipe size for a toilet (water closet)?',
 '1-1/4 inches', '1-1/2 inches', '2 inches', '3 inches',
 'B', 'The minimum vent size for a water closet is 1-1/2 inches per IPC vent sizing tables, though 2 inches is commonly used.', 'IPC Table 916.1', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'Trap design',
 'An S-trap is prohibited in modern plumbing codes because it:',
 'Is too expensive to install', 'Creates excessive noise', 'Is prone to self-siphonage', 'Exceeds maximum trap seal depth',
 'C', 'S-traps are prohibited because the downward leg can create a siphon effect that pulls water out of the trap seal, allowing sewer gases to enter.', 'IPC 1002.2', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'Grade and slope',
 'If a 4-inch drain runs 40 feet at minimum slope, what is the total drop?',
 '2-1/2 inches', '5 inches', '10 inches', '20 inches',
 'B', 'At 1/8 inch per foot minimum slope for a 4-inch pipe: 40 feet × 1/8 inch = 5 inches total drop.', 'IPC 704.1', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'Fixture units',
 'When sizing a horizontal branch drain, the total DFU load determines the:',
 'Pipe material required', 'Minimum pipe diameter', 'Type of fittings allowed', 'Maximum vent height',
 'B', 'The total drainage fixture unit (DFU) load on a horizontal branch determines the minimum pipe diameter required per the code sizing tables.', 'IPC Table 710.1', 'easy'),

-- ============================================================
-- APPRENTICE Module 3: Water Supply Basics (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'Supply pipe sizing',
 'What is the minimum supply pipe size to a standard residential kitchen sink?',
 '3/8 inch', '1/2 inch', '3/4 inch', '1 inch',
 'B', 'A kitchen sink requires a minimum 1/2-inch supply pipe for both hot and cold water lines.', 'IPC Table 604.5', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'Pressure regulation',
 'An expansion tank on a water heater is required when:',
 'The water heater exceeds 50 gallons', 'A check valve or PRV creates a closed system', 'The building is over two stories', 'The water temperature exceeds 140°F',
 'B', 'When a check valve, backflow preventer, or PRV creates a closed system, thermal expansion has nowhere to go, requiring an expansion tank.', 'IPC 607.3.2', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'Hot water systems',
 'What is the maximum hot water temperature at a public lavatory per code?',
 '100°F', '110°F', '120°F', '140°F',
 'B', 'Public lavatories are limited to a maximum of 110°F to prevent scalding, typically controlled by a thermostatic mixing valve.', 'IPC 607.1', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'Cross-connection control',
 'An air gap for an indirect waste connection must be at least:',
 'Equal to the pipe diameter', 'Twice the effective pipe diameter', '1 inch regardless of pipe size', '4 inches regardless of pipe size',
 'B', 'An air gap for indirect waste must be at least twice the effective diameter of the drain served, with a minimum of 1 inch.', 'IPC 801.2', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'Pipe support spacing',
 'What is the maximum support spacing for 3/4-inch copper tubing installed horizontally?',
 '4 feet', '6 feet', '8 feet', '10 feet',
 'B', 'Horizontal copper tubing up to 1 inch requires support at intervals not exceeding 6 feet.', 'IPC Table 308.5', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'Supply pipe sizing',
 'The main water service line to a single-family residence is typically a minimum of:',
 '1/2 inch', '3/4 inch', '1 inch', '1-1/4 inches',
 'B', 'A 3/4-inch water service line is the standard minimum for a single-family residence, though 1 inch is increasingly common.', 'IPC 603.1', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'Pressure regulation',
 'What is the minimum water pressure required at any fixture in a building?',
 '5 psi', '8 psi', '15 psi', '20 psi',
 'B', 'The minimum residual pressure at any fixture must be 8 psi, or 15 psi for some flush valve fixtures.', 'IPC 604.6', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'Hot water systems',
 'What is the standard thermostat setting recommended for residential water heaters?',
 '100°F', '110°F', '120°F', '140°F',
 'C', 'The recommended residential water heater setting is 120°F, balancing scalding prevention with Legionella bacteria control.', 'IPC 607.1', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'Cross-connection control',
 'A hose bibb without a vacuum breaker represents what type of hazard?',
 'Structural hazard', 'Cross-connection hazard', 'Fire hazard', 'Electrical hazard',
 'B', 'An unprotected hose bibb can allow contaminated water to backflow into the potable supply through backsiphonage, creating a cross-connection hazard.', 'IPC 608.15.4.2', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'Pipe support spacing',
 'PEX tubing must be supported at intervals not exceeding:',
 '32 inches', '4 feet', '6 feet', '8 feet',
 'A', 'PEX tubing requires more frequent support than copper, with maximum horizontal support spacing of 32 inches (2.67 feet).', 'IPC Table 308.5', 'medium'),

-- ============================================================
-- APPRENTICE Module 4: Safety & Tools (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'PPE requirements',
 'When soldering copper pipe, which PPE is required to protect against lead and flux fumes?',
 'Hard hat', 'Proper ventilation or respiratory protection', 'Steel-toed boots', 'High-visibility vest',
 'B', 'Soldering produces flux fumes that are harmful if inhaled. Adequate ventilation or respiratory protection is required, especially in confined spaces.', 'OSHA 1926.353', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'Soldering safety',
 'What is the maximum allowable lead content in solder used for potable water systems?',
 '0% (lead-free only)', '0.2%', '5%', '50%',
 'B', 'The Safe Drinking Water Act defines lead-free solder as containing no more than 0.2% lead for potable water system applications.', 'Safe Drinking Water Act Section 1417', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'Trenching hazards',
 'OSHA requires trench protection (shoring, sloping, or shielding) at what minimum depth?',
 '3 feet', '4 feet', '5 feet', '6 feet',
 'C', 'Trenches 5 feet or deeper require protective systems unless the excavation is made entirely in stable rock.', 'OSHA 1926.652', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'Tool identification',
 'A tubing cutter is preferred over a hacksaw for cutting copper because it:',
 'Is faster', 'Produces a square cut with no burrs inside the pipe', 'Works on all pipe sizes', 'Requires no maintenance',
 'B', 'A tubing cutter produces a clean, square cut and does not create internal burrs that restrict flow, though the inside edge should still be reamed.', 'CDA Copper Tube Handbook', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'Lockout/tagout',
 'Before working on a water heater, lockout/tagout procedures require:',
 'Only turning off the water supply', 'Disconnecting all energy sources and verifying zero energy', 'Posting a warning sign on the door', 'Notifying the building owner only',
 'B', 'LOTO requires disconnecting all energy sources (gas/electric and water), applying locks and tags, and verifying zero energy state before work begins.', 'OSHA 1910.147', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'PPE requirements',
 'When using a reciprocating saw to cut cast iron pipe, which PPE is essential?',
 'Leather gloves only', 'Safety glasses and hearing protection', 'Face shield only', 'Knee pads',
 'B', 'Cutting cast iron generates flying debris and excessive noise, requiring both safety glasses (or face shield) and hearing protection.', 'OSHA 1926.102', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'Soldering safety',
 'The proper flux for soldering potable water copper joints is:',
 'Acid-core flux', 'Water-soluble paste flux (lead-free)', 'Petroleum-based flux', 'Rosin-core flux',
 'B', 'Water-soluble paste flux that meets ASTM B813 is required for potable water copper joints; acid-core flux is corrosive and prohibited.', 'ASTM B813', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'Trenching hazards',
 'Spoil from a trench must be placed at least how far from the edge of the excavation?',
 '1 foot', '2 feet', '3 feet', '5 feet',
 'B', 'Excavated materials (spoil) must be kept at least 2 feet from the edge of the trench to prevent cave-ins.', 'OSHA 1926.651(j)(2)', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'Tool identification',
 'A soil pipe cutter (snap cutter) is designed specifically for cutting which material?',
 'Copper tubing', 'PVC pipe', 'Cast iron pipe', 'PEX tubing',
 'C', 'A snap cutter (soil pipe cutter) uses a chain with cutting wheels designed specifically for cutting cast iron soil pipe cleanly.', 'Tool Manufacturer Guidelines', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'Lockout/tagout',
 'A plumber discovers that someone has removed their lockout tag. The correct action is to:',
 'Continue working as planned', 'Re-apply the lock and tag and report the incident', 'Finish quickly and leave', 'Ask a coworker to stand guard',
 'B', 'If a lock or tag is removed, work must stop, the lock and tag must be reapplied, and the incident must be reported to supervision.', 'OSHA 1910.147(e)', 'easy'),

-- ============================================================
-- JOURNEYMAN Module 1: Code Compliance (IPC/UPC) (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'IPC structure',
 'The International Plumbing Code (IPC) is divided into how many chapters?',
 '8', '10', '13', '15',
 'C', 'The IPC contains 13 chapters covering administration, definitions, general regulations, fixtures, water supply, drainage, vents, indirect waste, and special systems.', 'IPC 2021 Edition', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'UPC requirements',
 'Which code body publishes the Uniform Plumbing Code (UPC)?',
 'ICC', 'IAPMO', 'ASME', 'NFPA',
 'B', 'The International Association of Plumbing and Mechanical Officials (IAPMO) publishes and maintains the Uniform Plumbing Code.', 'UPC 2021 Edition', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'Permit process',
 'A plumbing permit is typically required for all of the following EXCEPT:',
 'New water heater installation', 'Replacing a faucet with the same type', 'Adding a new bathroom', 'Re-routing a sewer line',
 'B', 'Like-for-like replacement of fixtures such as faucets typically does not require a permit. Adding fixtures, relocating piping, or installing water heaters usually does.', 'IPC 106.2', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'Inspection points',
 'A rough-in inspection must be performed:',
 'After drywall is installed', 'Before piping is concealed', 'Only on commercial projects', 'After final fixture installation',
 'B', 'Rough-in inspections must occur before piping is concealed by wall, ceiling, or floor coverings so the inspector can verify code compliance.', 'IPC 107.2', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'Code calculations',
 'Per the IPC, a clothes washer standpipe must be a minimum of what height above the trap weir?',
 '12 inches', '18 inches', '24 inches', '30 inches',
 'B', 'A clothes washer standpipe must extend a minimum of 18 inches above the trap weir but not exceed 30 inches.', 'IPC 802.4', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'IPC structure',
 'Chapter 6 of the IPC covers which subject?',
 'Fixtures and faucets', 'Water supply and distribution', 'Sanitary drainage', 'Vents',
 'B', 'IPC Chapter 6 addresses water supply and distribution, including pipe sizing, materials, and installation requirements.', 'IPC Chapter 6', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'UPC requirements',
 'The UPC requires a cleanout fitting at changes in direction greater than:',
 '22.5 degrees', '45 degrees', '90 degrees', '135 degrees',
 'D', 'The UPC requires cleanouts at each aggregate change of direction exceeding 135 degrees in the building drain or horizontal branch.', 'UPC 707.4', 'hard'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'Permit process',
 'Working without a required plumbing permit can result in:',
 'A verbal warning only', 'Fines and required removal of non-inspected work', 'Automatic license suspension', 'No consequences if work meets code',
 'B', 'Unpermitted work can result in fines, stop-work orders, and the requirement to expose or remove work for inspection.', 'IPC 108.4', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'Inspection points',
 'A water supply system pressure test typically requires maintaining what pressure for a minimum duration?',
 '40 psi for 10 minutes', '50 psi for 30 minutes', 'Working pressure for 15 minutes', 'At least 40 psi above working pressure for 15 minutes',
 'D', 'The IPC requires testing the water distribution system at a pressure not less than the working pressure of the system or 40 psi above working pressure, for a minimum of 15 minutes.', 'IPC 312.5', 'hard'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'Code calculations',
 'The minimum number of water closets required for a restaurant with an occupant load of 150 is determined by:',
 'The building owner preference', 'IPC Table 403.1 based on occupancy type', 'Local health department only', 'The architect specification',
 'B', 'Minimum plumbing fixture counts are determined by IPC Table 403.1, which specifies requirements based on building occupancy type and occupant load.', 'IPC Table 403.1', 'medium'),

-- ============================================================
-- JOURNEYMAN Module 2: Gas Piping Systems (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'Gas pipe sizing',
 'When sizing natural gas piping, the sizing tables are based on a maximum pressure drop of:',
 '0.3 inch water column', '0.5 inch water column', '1.0 inch water column', '2.0 inches water column',
 'B', 'Standard gas pipe sizing tables for low-pressure residential systems are based on a 0.5-inch water column pressure drop from the meter to the appliance.', 'IFGC Table 402.4', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'BTU load calculations',
 'A residential gas furnace rated at 100,000 BTU input and a gas water heater rated at 40,000 BTU input have a combined demand of:',
 '100,000 BTU', '120,000 BTU', '140,000 BTU', '160,000 BTU',
 'C', 'Combined BTU demand is the sum of all appliance input ratings: 100,000 + 40,000 = 140,000 BTU/hr.', 'IFGC 402.2', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'Appliance venting',
 'A Category I gas appliance uses which type of vent?',
 'Direct vent (sealed combustion)', 'Natural draft (Type B vent)', 'Power vent with PVC', 'No vent required',
 'B', 'Category I appliances operate with non-positive vent pressure and flue gas temperatures high enough to avoid condensation, using natural draft Type B vents.', 'IFGC 501.8', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'Leak testing',
 'The standard test pressure for a residential gas piping system is:',
 '3 psi for 10 minutes', '5 psi for 15 minutes', 'Not less than 3 psi for not less than 10 minutes', '15 psi for 30 minutes',
 'C', 'The IFGC requires testing gas piping at not less than 3 psi (approximately 6.9 inches of mercury) for a minimum of 10 minutes.', 'IFGC 406.4', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'CSST installation',
 'Corrugated stainless steel tubing (CSST) for gas piping requires what additional safety measure?',
 'Double wall pipe protection', 'Bonding to the grounding electrode system', 'Wrapping with insulation', 'Encasement in concrete',
 'B', 'CSST must be bonded to the building grounding electrode system to reduce the risk of damage from lightning-induced electrical surges.', 'IFGC 310.1.1', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'Gas pipe sizing',
 'One cubic foot of natural gas contains approximately how many BTUs?',
 '500 BTU', '1,000 BTU', '1,500 BTU', '2,500 BTU',
 'B', 'Natural gas contains approximately 1,000 BTU per cubic foot, which is used as the basis for pipe sizing calculations.', 'IFGC 402.2', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'BTU load calculations',
 'When sizing gas piping, what is the proper method if appliance BTU input ratings are unknown?',
 'Estimate based on building size', 'Use the nameplate output rating', 'Use the maximum BTU rating for that appliance type from code tables', 'Size for 50,000 BTU per appliance',
 'C', 'When exact input ratings are unknown, the code provides maximum demand tables by appliance type to ensure proper pipe sizing.', 'IFGC Table 402.2', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'Appliance venting',
 'The minimum chimney height above the roof penetration for a gas appliance vent is:',
 '1 foot', '2 feet', '3 feet', '5 feet',
 'C', 'A gas vent or chimney must extend at least 3 feet above the roof penetration and at least 2 feet above any portion of the building within 10 feet.', 'IFGC 503.6.5', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'Leak testing',
 'What substance should NEVER be used to check for gas leaks?',
 'Approved leak detection solution', 'Electronic gas detector', 'Open flame', 'Soap and water solution',
 'C', 'Never use an open flame to check for gas leaks. Use approved leak detection fluid, electronic detectors, or pressure testing equipment.', 'IFGC 406.1', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'CSST installation',
 'CSST must not be installed in which location?',
 'Above a drop ceiling', 'In a wall cavity', 'Buried underground without approved protection', 'In a mechanical room',
 'C', 'CSST is not approved for direct burial underground unless specifically listed for that purpose and installed with approved protection methods.', 'IFGC 404.7', 'medium'),

-- ============================================================
-- JOURNEYMAN Module 3: Backflow Prevention (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'Cross-connection types',
 'What is the difference between backpressure and backsiphonage?',
 'They are the same thing', 'Backpressure is caused by downstream pressure exceeding supply; backsiphonage is caused by negative pressure in the supply', 'Backsiphonage only occurs in hot water systems', 'Backpressure only occurs in fire suppression systems',
 'B', 'Backpressure occurs when downstream pressure exceeds supply pressure (e.g., boiler). Backsiphonage occurs when negative pressure develops in the supply line (e.g., water main break).', 'IPC 608.1', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'Backflow preventer types',
 'Which backflow preventer provides the highest degree of protection?',
 'Atmospheric vacuum breaker (AVB)', 'Double check valve assembly (DCVA)', 'Reduced pressure zone (RPZ) assembly', 'Hose bibb vacuum breaker',
 'C', 'The RPZ assembly provides the highest protection because it includes a relief valve that discharges water rather than allowing backflow if both check valves fail.', 'IPC 608.13.2', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'Annual testing',
 'How often must an RPZ backflow assembly be tested?',
 'Monthly', 'Annually', 'Every 3 years', 'Only at initial installation',
 'B', 'RPZ assemblies must be tested annually by a certified backflow tester to verify proper operation of check valves and the relief valve.', 'IPC 312.10', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'Installation requirements',
 'An RPZ assembly must be installed:',
 'Below grade in a vault', 'At least 12 inches above grade or floor', 'Only indoors', 'In the attic space',
 'B', 'RPZ assemblies must be installed at least 12 inches above grade or the flood level rim to allow the relief valve to discharge visibly and freely.', 'IPC 608.13.2', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'Hazard assessment',
 'A lawn irrigation system connected to a potable water supply represents what level of hazard?',
 'No hazard', 'Low hazard (requires DCVA)', 'High hazard (requires RPZ or air gap)', 'Moderate hazard (requires AVB only)',
 'C', 'Irrigation systems are classified as high-hazard cross-connections due to potential contact with pesticides, fertilizers, and animal waste, requiring RPZ or air gap protection.', 'IPC 608.16.5', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'Cross-connection types',
 'Which of the following is a direct cross-connection?',
 'A garden hose submerged in a pool', 'A boiler feed line connected directly to the water main', 'An air gap at a sink', 'A backflow preventer on an irrigation line',
 'B', 'A direct cross-connection is a physical piping connection between potable and non-potable systems, such as a boiler feed directly connected to the water main.', 'IPC 608.1', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'Backflow preventer types',
 'An atmospheric vacuum breaker (AVB) can only protect against:',
 'Backpressure', 'Backsiphonage', 'Both backpressure and backsiphonage', 'Neither type of backflow',
 'B', 'An AVB only protects against backsiphonage. It must not be installed where backpressure can occur or where it is under continuous pressure.', 'IPC 608.13.6', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'Annual testing',
 'During an RPZ test, the relief valve should open when:',
 'Supply pressure drops below 5 psi', 'The pressure differential across the first check valve is less than the relief valve opening point', 'The second check valve fails', 'Both check valves are fully seated',
 'B', 'The relief valve opens when the zone between the two checks (the reduced pressure zone) drops to within approximately 2 psi of the downstream pressure, indicating a check valve issue.', 'ASSE 1013', 'hard'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'Installation requirements',
 'A double check valve assembly (DCVA) may be installed:',
 'Only above grade', 'Below grade in an approved vault', 'Only on hot water lines', 'Only on residential systems',
 'B', 'Unlike RPZ assemblies, DCVAs may be installed below grade in approved vaults since they do not have a relief valve that must discharge visibly.', 'IPC 608.13.1', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'Hazard assessment',
 'Which scenario requires an air gap rather than a mechanical backflow preventer?',
 'Residential irrigation', 'Commercial kitchen sink', 'Sewage ejector discharge into the sanitary sewer', 'Boiler make-up water',
 'C', 'Connections to sewer or waste systems require an air gap because they represent the highest contamination risk and mechanical devices alone are insufficient.', 'IPC 608.13.7', 'hard'),

-- ============================================================
-- JOURNEYMAN Module 4: Commercial Plumbing (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'Fixture count calculations',
 'IPC Table 403.1 uses what factor to determine required fixture counts?',
 'Building square footage', 'Occupancy type and occupant load', 'Number of floors', 'Building age',
 'B', 'Minimum fixture requirements are based on the occupancy classification and the total occupant load, per IPC Table 403.1.', 'IPC Table 403.1', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'Grease interceptors',
 'A grease interceptor is required for which type of establishment?',
 'Residential kitchens', 'Commercial food preparation facilities', 'Office buildings without kitchens', 'Retail stores',
 'B', 'Commercial food service establishments producing grease-laden waste must install grease interceptors to prevent grease from entering the sanitary sewer.', 'IPC 1003.3', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'Storm drainage',
 'Roof drain sizing is determined by:',
 'Building height only', 'Rainfall rate and roof area', 'Number of stories', 'Type of roofing material',
 'B', 'Roof drains and storm drainage piping are sized based on the maximum rainfall intensity (inches per hour) and the projected roof area served.', 'IPC Table 1106.2', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'Multi-story risers',
 'In a multi-story building, what fitting is required at the base of a drainage stack?',
 'Standard tee', 'Long-turn fitting or two 45-degree elbows', 'Short-radius 90', 'Reducer',
 'B', 'At the base of a drainage stack, a long-turn fitting or combination of two 45-degree elbows is required to manage the hydraulic jump and prevent blockages.', 'IPC 706.3', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'Expansion compensation',
 'A 100-foot run of CPVC hot water pipe at 180°F will expand approximately how much?',
 '0.5 inches', '1 inch', '2 inches', '4 inches',
 'D', 'CPVC has a high expansion rate of approximately 3.4 inches per 100 feet per 100°F rise. At 110°F rise (70°F to 180°F) this equals about 3.7 inches, closest to 4 inches.', 'ASTM D2846', 'hard'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'Fixture count calculations',
 'For an office building with 300 occupants, the minimum number of male water closets required (per IPC) is:',
 '1', '2', '3', '4',
 'C', 'For business occupancy (150 males assumed), IPC Table 403.1 requires 1 water closet per 25 males for the first 50, then 1 per 50 thereafter, totaling approximately 3.', 'IPC Table 403.1', 'hard'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'Grease interceptors',
 'A grease interceptor must be accessible for:',
 'Visual inspection only', 'Regular cleaning and maintenance', 'Annual inspection only', 'Emergency access only',
 'B', 'Grease interceptors must be readily accessible for cleaning, maintenance, and inspection. They typically require cleaning every 1-3 months.', 'IPC 1003.3.2', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'Storm drainage',
 'Combined storm and sanitary sewer systems are:',
 'Required in all jurisdictions', 'Prohibited in most modern codes', 'Only allowed in residential buildings', 'Preferred for commercial buildings',
 'B', 'Modern plumbing codes prohibit combining storm and sanitary drainage systems. Separate systems are required to prevent sewer overflows during storms.', 'IPC 1101.2', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'Multi-story risers',
 'Stack venting is permitted when a drainage stack serves fixtures on how many floors maximum?',
 '2 stories', '3 stories', 'No limit with proper sizing', 'Stack venting is never permitted',
 'C', 'Stack venting can be used for any number of stories provided the stack is properly sized for both drainage and venting loads per the code requirements.', 'IPC 913.1', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'Expansion compensation',
 'Which method is commonly used to accommodate thermal expansion in long runs of copper pipe?',
 'Expansion loops or offsets', 'Rigid bracing at every joint', 'Reducing pipe size', 'Using shorter pipe lengths',
 'A', 'Expansion loops, offsets, or expansion compensators allow thermal movement in long pipe runs without stressing joints or supports.', 'CDA Copper Tube Handbook', 'easy'),

-- ============================================================
-- MASTER Module 1: System Design & Sizing (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'WSFU calculations',
 'A bathtub with a 1/2-inch supply has a water supply fixture unit (WSFU) value of:',
 '1.0', '1.4', '2.0', '4.0',
 'B', 'Per IPC Table 604.5, a bathtub with a 1/2-inch supply is rated at 1.4 WSFU for combined hot and cold demand.', 'IPC Table 604.5', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'Pipe sizing methods',
 'The primary factors in the velocity method of water pipe sizing are:',
 'Pipe material and color', 'Flow rate, pipe diameter, and maximum allowable velocity', 'Building height only', 'Number of fixtures only',
 'B', 'The velocity method sizes pipe based on flow rate demand, the resulting velocity in the proposed pipe size, and maintaining velocity below 8 fps (typically 5 fps for occupied spaces).', 'IPC 604.4', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'Pump selection',
 'A booster pump system is required when:',
 'The building has more than 2 floors', 'Street pressure is insufficient to serve the highest fixtures at minimum required pressure', 'The water heater is in the basement', 'The building uses PEX piping',
 'B', 'Booster pumps are required when the available street main pressure minus friction and elevation losses cannot deliver the minimum required pressure to the highest and most remote fixtures.', 'IPC 606.5', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'Recirculation systems',
 'A hot water recirculation system reduces wait time by:',
 'Increasing water heater temperature', 'Continuously circulating hot water through the supply piping back to the heater', 'Using larger diameter pipes', 'Adding a second water heater',
 'B', 'Recirculation systems use a pump to maintain hot water circulation through the supply piping, keeping hot water immediately available at fixtures.', 'IPC 607.2.1', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'Pressure loss calculations',
 'Friction loss in water piping increases significantly when velocity exceeds:',
 '2 fps', '4 fps', '8 fps', '12 fps',
 'C', 'Friction loss increases exponentially with velocity. Most codes and design standards limit velocity to 8 fps maximum, with 5 fps preferred to reduce noise and erosion.', 'ASPE Data Book Ch. 6', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'WSFU calculations',
 'When calculating total WSFU for a building, how are hot and cold water fixture units handled?',
 'Only cold water units are counted', 'Hot and cold are calculated separately, then the larger value is used for the main', 'Both are added together for the building main using the total demand method', 'Hot water demand is ignored',
 'C', 'For the building main, total WSFU demand includes both hot and cold. For branch sizing, hot and cold are calculated separately. The total demand determines main pipe size.', 'IPC 604.5', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'Pipe sizing methods',
 'The equivalent length of a 3/4-inch 90-degree elbow for friction loss calculations is approximately:',
 '1 foot', '2 feet', '5 feet', '10 feet',
 'B', 'A standard 3/4-inch 90-degree elbow has an equivalent length of approximately 2 feet, which must be added to the actual pipe length for friction loss calculations.', 'IPC Table E103.3', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'Pump selection',
 'When sizing a domestic water booster pump, the pump must overcome:',
 'Only elevation head', 'Elevation head plus friction losses plus minimum fixture pressure', 'Only friction losses', 'Street main pressure only',
 'B', 'Total dynamic head (TDH) for pump sizing includes elevation head, friction losses through piping and fittings, and the minimum required pressure at the highest fixture.', 'ASPE Data Book Ch. 14', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'Recirculation systems',
 'The return line in a hot water recirculation system should be insulated to:',
 'Prevent condensation only', 'Minimize heat loss and maintain water temperature', 'Meet fire code requirements', 'Reduce water hammer',
 'B', 'Both supply and return recirculation lines must be insulated to minimize heat loss, maintain delivery temperature, and improve energy efficiency.', 'IPC 607.2', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'Pressure loss calculations',
 'Static pressure increases at approximately what rate per foot of elevation (water column)?',
 '0.216 psi per foot', '0.433 psi per foot', '1.0 psi per foot', '2.31 psi per foot',
 'B', 'Water exerts 0.433 psi per vertical foot (or 1 psi per 2.31 feet). This is used to calculate elevation-related pressure gains and losses.', 'Fluid Mechanics', 'medium'),

-- ============================================================
-- MASTER Module 2: Medical Gas Systems (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'NFPA 99 requirements',
 'Medical gas piping systems are governed by which NFPA standard?',
 'NFPA 13', 'NFPA 54', 'NFPA 99', 'NFPA 101',
 'C', 'NFPA 99, Health Care Facilities Code, governs the installation, testing, and maintenance of medical gas and vacuum piping systems.', 'NFPA 99', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'Oxygen piping',
 'What pipe material is required for medical oxygen piping?',
 'PVC', 'Type K or L copper cleaned for oxygen service', 'Galvanized steel', 'CPVC',
 'B', 'Medical oxygen piping must be Type K or L hard-drawn copper, cleaned, capped, and labeled for oxygen service. Contamination with oils or grease can cause ignition.', 'NFPA 99 5.1.10', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'Vacuum systems',
 'Medical vacuum systems must be capable of maintaining what minimum vacuum level?',
 '6 inches Hg', '12 inches Hg', '15 inches Hg at the farthest outlet', '29 inches Hg',
 'C', 'NFPA 99 requires medical vacuum systems to maintain a minimum of 15 inches Hg (380 mmHg) at the farthest station outlet.', 'NFPA 99 5.1.3.7', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'Brazing procedures',
 'Medical gas piping joints must be brazed with what filler metal?',
 'Tin-lead solder', 'Silver-based brazing alloy (BCuP or BAg)', 'Epoxy', 'Compression fittings only',
 'B', 'Medical gas piping joints require brazing (not soldering) with silver-based alloys such as BCuP-5 or BAg-1, achieving melting points above 1,000°F for joint integrity.', 'NFPA 99 5.1.10.3', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'Alarm systems',
 'Medical gas master alarms must be located in:',
 'Each patient room', 'The location of the source equipment and at two additional locations', 'Only at the nurse station', 'The hospital lobby',
 'B', 'NFPA 99 requires master alarms at the source equipment location plus at least two additional locations, typically including the security office and a constantly attended area.', 'NFPA 99 5.1.9', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'NFPA 99 requirements',
 'Medical gas installers must be certified to what standard?',
 'Any plumbing license', 'ASSE 6010 or 6020', 'OSHA 30-hour', 'No special certification',
 'B', 'ASSE 6010 (Medical Gas Systems Installer) and 6020 (Inspector) certifications are required for personnel working on medical gas piping systems.', 'NFPA 99 5.1.10.1', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'Oxygen piping',
 'During brazing of medical oxygen piping, what gas must be purged through the system?',
 'Compressed air', 'Oil-free dry nitrogen', 'Carbon dioxide', 'Argon',
 'B', 'Oil-free dry nitrogen must be purged through medical gas piping during brazing to prevent oxidation and contamination inside the pipe.', 'NFPA 99 5.1.10.3.4', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'Vacuum systems',
 'What is the minimum number of vacuum pumps required for a Level 1 medical vacuum system?',
 '1', '2', '3', '4',
 'C', 'Level 1 medical vacuum systems require a minimum of 3 pumps (or 2 pumps plus a receiver), with the system able to handle peak demand with any single pump out of service.', 'NFPA 99 5.1.3.5', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'Brazing procedures',
 'After installation, medical gas piping must undergo what initial test?',
 'Visual inspection only', 'Standing pressure test with oil-free dry nitrogen at 150 psi for 24 hours', 'Water pressure test', 'Air test at 50 psi for 1 hour',
 'B', 'Initial testing requires standing the system at 150 psi with oil-free dry nitrogen for a minimum of 24 hours, followed by cross-connection and purge testing.', 'NFPA 99 5.1.12.2', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'Alarm systems',
 'A medical gas area alarm (zone valve alarm) indicates:',
 'Total system failure', 'That a zone valve has been closed or pressure in that zone is abnormal', 'Low oxygen in the room', 'Fire in the zone',
 'B', 'Area alarms monitor individual zones and alert when a zone valve is closed or when the line pressure in that zone falls outside normal parameters.', 'NFPA 99 5.1.9.2', 'medium'),

-- ============================================================
-- MASTER Module 3: Project Management (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'Blueprint reading',
 'On a plumbing blueprint, a dashed line typically represents:',
 'A hot water line', 'A pipe or duct above the cutting plane (overhead)', 'A gas line', 'An electrical conduit',
 'B', 'Dashed (hidden) lines on floor plans represent elements above the cutting plane, such as overhead piping, soffits, or ductwork.', 'Architectural Drawing Standards', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'Material takeoffs',
 'When performing a plumbing material takeoff, fittings are typically estimated at what percentage of pipe cost?',
 '5-10%', '15-25%', '25-50%', '50-75%',
 'C', 'Fittings typically represent 25-50% of total pipe material cost depending on system complexity and number of connections.', 'MCAA Estimating Guide', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'Scheduling',
 'In a construction schedule, plumbing rough-in typically occurs:',
 'Before framing', 'After framing but before insulation and drywall', 'After drywall', 'After painting',
 'B', 'Plumbing rough-in is scheduled after framing is complete and inspected, but before insulation and drywall are installed, to allow access to wall and floor cavities.', 'CSI MasterFormat Division 22', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'Labor estimation',
 'The labor unit for installing one residential toilet (water closet) is approximately:',
 '0.5 hours', '1-2 hours', '3-4 hours', '6-8 hours',
 'C', 'Installing a residential toilet including setting the flange, wax ring, bowl, tank, supply, and testing typically takes 3-4 labor hours for a journeyman plumber.', 'MCAA Labor Estimating Manual', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'Change order management',
 'A change order should be processed BEFORE work begins because:',
 'It is the law', 'It establishes agreed-upon scope, cost, and schedule impact before additional work is performed', 'The inspector requires it', 'Insurance requires it',
 'B', 'Processing change orders before work begins protects all parties by documenting the scope change, associated costs, and schedule impacts with agreed-upon terms.', 'AIA A201 Section 7', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'Blueprint reading',
 'A plumbing isometric drawing shows the piping system in:',
 'Plan view (top down)', 'Three-dimensional representation at 30/60 degree angles', 'Cross-section only', 'Elevation view only',
 'B', 'Plumbing isometrics use a 30/60-degree projection to show three-dimensional pipe routing, making it easier to understand vertical and horizontal relationships.', 'Plumbing Drafting Standards', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'Material takeoffs',
 'A master plumber reviewing a takeoff should add what percentage for waste and unforeseen conditions?',
 '1-3%', '5-10%', '10-15%', '25-30%',
 'C', 'A standard waste factor of 10-15% is applied to material quantities to account for cutting waste, damage, and unforeseen field conditions.', 'MCAA Estimating Guide', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'Scheduling',
 'The critical path in a plumbing project schedule is:',
 'The shortest possible path', 'The longest sequence of dependent activities that determines the minimum project duration', 'The path with the most workers', 'The most expensive sequence of tasks',
 'B', 'The critical path is the longest sequence of dependent activities. Any delay on the critical path directly delays the project completion date.', 'PMI PMBOK Guide', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'Labor estimation',
 'Productivity factors that reduce plumbing labor efficiency include:',
 'Good weather and clear access', 'Overtime fatigue, stacking of trades, and restricted access', 'Experienced crew availability', 'Prefabrication of assemblies',
 'B', 'Extended overtime causes fatigue, trade stacking creates congestion, and restricted access slows installation. These factors can reduce productivity by 20-40%.', 'MCAA Factors Affecting Labor', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'Change order management',
 'Overhead and profit markup on a change order is typically:',
 '5%', '10% overhead + 10% profit', '25% flat', '50% of labor cost',
 'B', 'Industry standard change order markup is typically 10% overhead plus 10% profit on direct costs, though this varies by contract terms.', 'AIA A201 Section 7.3', 'medium'),

-- ============================================================
-- MASTER Module 4: Advanced Troubleshooting (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'Camera inspection',
 'A CCTV sewer camera inspection is most useful for identifying:',
 'Water temperature issues', 'Pipe condition, blockages, root intrusion, and bellies', 'Gas leaks', 'Water pressure problems',
 'B', 'CCTV inspection reveals pipe condition including cracks, root intrusion, offset joints, grease buildup, bellies (sags), and structural deterioration.', 'NASSCO PACP Standards', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'Pressure testing',
 'During a DWV system pressure test, the piping must hold how much pressure?',
 '5 psi air pressure for 15 minutes', '10 feet of head pressure (water) for 15 minutes', 'A 10-foot head of water or 5 psi air test for 15 minutes', '50 psi water test for 1 hour',
 'C', 'The IPC allows either a water test (10-foot head minimum) or an air test (5 psi) for DWV systems, maintained for a minimum of 15 minutes with no drop.', 'IPC 312.2, 312.3', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'Leak detection',
 'An electronic leak detection device locates concealed water leaks by:',
 'Measuring water flow only', 'Detecting sound or moisture changes through walls and floors', 'Using X-ray technology', 'Measuring pipe temperature',
 'B', 'Electronic leak detectors use acoustic sensors to amplify the sound of pressurized water escaping through a leak, or moisture sensors to detect hidden water.', 'AWWA Manual M36', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'System balancing',
 'In a multi-story recirculation system, balancing valves are used to:',
 'Increase water pressure', 'Ensure equal hot water temperature at all floors by regulating flow', 'Filter the water', 'Prevent backflow',
 'B', 'Balancing valves regulate flow through recirculation return branches so that hot water reaches distant fixtures at proper temperature without short-circuiting through near branches.', 'ASPE Data Book Ch. 6', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'Root cause analysis',
 'Recurring drain stoppages at the same location most likely indicate:',
 'User behavior only', 'A structural defect such as a belly, offset joint, or root intrusion', 'Insufficient water pressure', 'Oversized piping',
 'B', 'Recurring stoppages at the same location indicate a physical pipe defect that traps debris, such as a belly (sag), offset joint, root intrusion, or scale buildup.', 'NASSCO PACP Standards', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'Camera inspection',
 'What does a "belly" in a sewer line refer to?',
 'A pipe that is oversized', 'A low spot or sag where the pipe has settled below grade', 'A type of fitting', 'An obstruction from grease',
 'B', 'A belly is a section of pipe that has settled below grade, creating a low point where water pools and debris accumulates, causing recurring blockages.', 'NASSCO PACP Standards', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'Pressure testing',
 'A sudden pressure drop during a water supply test indicates:',
 'Normal system operation', 'A leak in the piping system', 'Thermal expansion', 'Air in the lines',
 'B', 'A pressure drop during a static pressure test indicates a leak. The test must be at constant temperature to rule out thermal contraction as a cause.', 'IPC 312.5', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'Leak detection',
 'Tracer gas leak detection uses what gas to locate concealed leaks in water piping?',
 'Natural gas', 'Hydrogen-nitrogen mixture (forming gas)', 'Oxygen', 'Carbon monoxide',
 'B', 'A hydrogen-nitrogen mixture (typically 5% H2 / 95% N2) is pressurized into the pipe. The hydrogen escapes through leaks and is detected at the surface with a sensitive detector.', 'ASTM Standard Practice', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'System balancing',
 'A thermostatic balancing valve operates by:',
 'Measuring flow volume', 'Sensing water temperature and adjusting flow to maintain a set temperature', 'Detecting pressure changes', 'Timer-based operation',
 'B', 'Thermostatic balancing valves contain a thermal element that opens or closes based on water temperature, automatically adjusting flow to maintain the temperature setpoint.', 'ASPE Data Book Ch. 6', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'Root cause analysis',
 'Water hammer in a plumbing system is caused by:',
 'Low water pressure', 'Sudden closure of a valve creating a pressure shock wave', 'Oversized piping', 'Air in the water supply',
 'B', 'Water hammer is a pressure surge caused by the sudden stoppage of water flow (e.g., quick-closing valve), creating a shock wave that travels through the piping.', 'ASPE Data Book Ch. 6', 'medium');
