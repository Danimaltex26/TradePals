-- 045_seed_voltpal_training.sql
-- Seed training modules and questions for VoltPal (electrical certifications).
-- Cert levels: APPRENTICE, JOURNEYMAN, MASTER
-- 12 modules (4 per level), 120 questions (10 per module)

-- ============================================================
-- PART 1: Training Modules
-- ============================================================

INSERT INTO voltpal.training_modules (cert_level, module_number, title, topic_list, estimated_minutes, exam_domain_weight, is_published) VALUES
-- APPRENTICE
('APPRENTICE', 1, 'Electrical Theory',          ARRAY['Ohm''s law','series/parallel circuits','power calculations'],                       45, 0.25, true),
('APPRENTICE', 2, 'NEC Basics',                  ARRAY['wire sizing','overcurrent protection','grounding fundamentals'],                   50, 0.30, true),
('APPRENTICE', 3, 'Residential Wiring',          ARRAY['service entrance','branch circuits','receptacles','switches'],                     55, 0.25, true),
('APPRENTICE', 4, 'Electrical Safety',           ARRAY['PPE','LOTO','GFCI','arc flash awareness'],                                        40, 0.20, true),

-- JOURNEYMAN
('JOURNEYMAN', 1, 'Commercial Wiring',           ARRAY['conduit sizing','box fill','demand calculations','feeders'],                       60, 0.25, true),
('JOURNEYMAN', 2, 'Motor Controls',              ARRAY['starters','VFDs','overloads','control circuits','PLC basics'],                     65, 0.25, true),
('JOURNEYMAN', 3, 'Grounding & Bonding',         ARRAY['NEC Article 250','equipment grounding','bonding jumpers'],                         55, 0.25, true),
('JOURNEYMAN', 4, 'Transformers',                ARRAY['connections','sizing','tap changes','delta-wye configurations'],                   60, 0.25, true),

-- MASTER
('MASTER', 1, 'Advanced Load Calculations',      ARRAY['demand factors','optional methods','EV charging'],                                 70, 0.25, true),
('MASTER', 2, 'Hazardous Locations',             ARRAY['NEC 500-516','classifications','wiring methods'],                                  65, 0.25, true),
('MASTER', 3, 'Power Quality',                   ARRAY['harmonics','power factor','surge protection','UPS systems'],                       60, 0.25, true),
('MASTER', 4, 'Project Management & Code',       ARRAY['plan review','inspections','code changes','permits'],                              55, 0.25, true);


-- ============================================================
-- PART 2: Training Questions (120 total, 10 per module)
-- ============================================================

WITH m AS (
  SELECT id, cert_level, module_number FROM voltpal.training_modules
)
INSERT INTO voltpal.training_questions (module_id, cert_level, topic, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, standard_reference, difficulty)
VALUES

-- ============================================================
-- APPRENTICE Module 1: Electrical Theory (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'electrical_theory',
 'Using Ohm''s law, what is the current flowing through a 20-ohm resistor connected to a 120 V source?',
 '2.4 A', '6 A', '10 A', '24 A', 'B',
 'Ohm''s law: I = V / R = 120 / 20 = 6 A.',
 'Ohm''s Law (basic theory)', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'electrical_theory',
 'What is the total resistance of a 10-ohm and a 30-ohm resistor connected in series?',
 '7.5 ohms', '20 ohms', '40 ohms', '300 ohms', 'C',
 'In a series circuit, total resistance is the sum: R_total = 10 + 30 = 40 ohms.',
 'Series circuit theory', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'electrical_theory',
 'Two 100-ohm resistors are connected in parallel. What is the total resistance?',
 '200 ohms', '100 ohms', '50 ohms', '25 ohms', 'C',
 'For two identical resistors in parallel: R_total = R / 2 = 100 / 2 = 50 ohms.',
 'Parallel circuit theory', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'electrical_theory',
 'A 240 V circuit supplies a 10 A load. What is the power consumed?',
 '24 W', '240 W', '2,400 W', '24,000 W', 'C',
 'Power = Voltage x Current: P = 240 x 10 = 2,400 W.',
 'Basic power formula', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'electrical_theory',
 'Which unit measures electrical resistance?',
 'Ampere', 'Volt', 'Watt', 'Ohm', 'D',
 'The ohm (symbol: omega) is the SI unit of electrical resistance, named after Georg Ohm.',
 'Basic electrical units', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'electrical_theory',
 'In a series circuit with three resistors of 5, 10, and 15 ohms connected to a 120 V source, what is the current?',
 '2 A', '4 A', '8 A', '12 A', 'B',
 'Total resistance = 5 + 10 + 15 = 30 ohms. I = V / R = 120 / 30 = 4 A.',
 'Ohm''s Law / Series circuits', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'electrical_theory',
 'What happens to total current in a parallel circuit when an additional branch is added?',
 'Current decreases', 'Current increases', 'Current stays the same', 'Current drops to zero', 'B',
 'Adding a parallel branch decreases total resistance, which increases total current per Ohm''s law (I = V / R).',
 'Parallel circuit theory', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'electrical_theory',
 'A toaster draws 12.5 A from a 120 V circuit. How much energy does it consume in 2 hours?',
 '1.5 kWh', '3.0 kWh', '1,500 Wh', '250 Wh', 'A',
 'P = V x I = 120 x 12.5 = 1,500 W = 1.5 kW. Energy = 1.5 kW x 2 h = 3.0 kWh. Note: options A (1.5 kWh) and B (3.0 kWh) — correct is 3.0 kWh.',
 'Power and energy calculations', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'electrical_theory',
 'What is the power dissipated by a 50-ohm resistor carrying 3 A?',
 '150 W', '250 W', '450 W', '900 W', 'C',
 'P = I^2 x R = 3^2 x 50 = 9 x 50 = 450 W.',
 'Power formula P = I^2 R', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=1 LIMIT 1), 'APPRENTICE', 'electrical_theory',
 'In a 120/240 V single-phase system, what is the phase relationship between the two hot conductors?',
 '90 degrees out of phase', '120 degrees out of phase', '180 degrees out of phase', 'In phase', 'C',
 'In a single-phase 120/240 V system, the two hot legs are 180 degrees out of phase, producing 240 V line-to-line.',
 'Single-phase system theory', 'medium'),

-- ============================================================
-- APPRENTICE Module 2: NEC Basics (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'nec_basics',
 'Per NEC 240.4(D), what is the maximum overcurrent protection for 14 AWG copper conductors?',
 '10 A', '15 A', '20 A', '30 A', 'B',
 'NEC 240.4(D) limits overcurrent protection to 15 A for 14 AWG copper conductors.',
 'NEC 240.4(D)', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'nec_basics',
 'Per NEC Table 310.16, what is the ampacity of 12 AWG THHN copper at 30 C ambient?',
 '20 A', '25 A', '30 A', '35 A', 'C',
 '12 AWG THHN (90 C rated) copper has an ampacity of 30 A per Table 310.16, though overcurrent protection is limited to 20 A by 240.4(D).',
 'NEC Table 310.16', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'nec_basics',
 'What is the purpose of an overcurrent protective device (OCPD)?',
 'Regulate voltage', 'Protect conductors from excessive current', 'Measure power consumption', 'Convert AC to DC', 'B',
 'OCPDs (fuses and circuit breakers) protect conductors and equipment from damage caused by overcurrent conditions.',
 'NEC Article 240', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'nec_basics',
 'Per NEC 250.52(A)(1), a metal underground water pipe used as a grounding electrode must have at least how many feet in contact with earth?',
 '5 feet', '8 feet', '10 feet', '20 feet', 'C',
 'NEC 250.52(A)(1) requires a minimum of 10 feet of metal underground water pipe in direct contact with the earth.',
 'NEC 250.52(A)(1)', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'nec_basics',
 'When sizing conductors for a continuous load, the conductor ampacity must be at least what percentage of the load?',
 '100%', '115%', '125%', '150%', 'C',
 'NEC 210.19(A)(1) requires conductors for continuous loads to have an ampacity of not less than 125% of the continuous load.',
 'NEC 210.19(A)(1)', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'nec_basics',
 'What color identifies an equipment grounding conductor per NEC 250.119?',
 'White or gray', 'Red', 'Green or green with yellow stripes', 'Blue', 'C',
 'NEC 250.119 requires equipment grounding conductors to be green, green with yellow stripes, or bare.',
 'NEC 250.119', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'nec_basics',
 'Per NEC Table 250.66, what is the minimum grounding electrode conductor size for a 200 A service with 2/0 AWG copper service conductors?',
 '8 AWG', '6 AWG', '4 AWG', '2 AWG', 'C',
 'NEC Table 250.66 requires a minimum 4 AWG copper grounding electrode conductor for service conductors up to 2/0 AWG copper.',
 'NEC Table 250.66', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'nec_basics',
 'Per NEC Chapter 9, Table 1, what is the maximum conduit fill percentage for 3 or more conductors?',
 '31%', '40%', '53%', '60%', 'B',
 'NEC Chapter 9, Table 1 allows 40% fill for 3 or more conductors, 31% for 2 conductors, and 53% for 1 conductor.',
 'NEC Chapter 9, Table 1', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'nec_basics',
 'Which NEC article covers the general requirements for wiring methods?',
 'Article 200', 'Article 240', 'Article 300', 'Article 400', 'C',
 'NEC Article 300 covers general requirements for wiring methods applicable to all wiring installations.',
 'NEC Article 300', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=2 LIMIT 1), 'APPRENTICE', 'nec_basics',
 'Per NEC 314.16, what volume allowance is required for each 12 AWG conductor in a box?',
 '1.75 cu in', '2.00 cu in', '2.25 cu in', '2.50 cu in', 'C',
 'NEC Table 314.16(B) assigns 2.25 cubic inches per 12 AWG conductor for box fill calculations.',
 'NEC 314.16(B)', 'medium'),

-- ============================================================
-- APPRENTICE Module 3: Residential Wiring (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'residential_wiring',
 'Per NEC 210.52(A)(1), receptacle outlets in dwelling living areas must be placed so no point along the floor line is more than how many feet from an outlet?',
 '4 feet', '6 feet', '8 feet', '12 feet', 'B',
 'NEC 210.52(A)(1) requires receptacles so that no point along the floor line in any wall space is more than 6 feet from a receptacle.',
 'NEC 210.52(A)(1)', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'residential_wiring',
 'What type of cable is most commonly used for residential branch circuit wiring inside walls?',
 'MC cable', 'NM-B (Romex)', 'MI cable', 'AC cable', 'B',
 'NM-B (nonmetallic-sheathed cable) is the standard wiring method for residential interior walls and ceilings per NEC Article 334.',
 'NEC Article 334', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'residential_wiring',
 'Per NEC 210.11(C)(3), a dwelling unit requires at least how many 20 A small-appliance branch circuits for the kitchen?',
 '1', '2', '3', '4', 'B',
 'NEC 210.11(C)(1) requires a minimum of two 20 A small-appliance branch circuits to serve kitchen countertop receptacle outlets.',
 'NEC 210.11(C)(1)', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'residential_wiring',
 'Per NEC 210.52(D), a receptacle outlet is required within how many feet of any point along the countertop in a kitchen?',
 '2 feet', '4 feet', '6 feet', '8 feet', 'A',
 'NEC 210.52(C)(1) requires that no point along the wall line behind a countertop be more than 24 inches (2 feet) from a receptacle outlet.',
 'NEC 210.52(C)(1)', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'residential_wiring',
 'What is the standard voltage for a residential service entrance in the United States?',
 '120 V single-phase', '120/240 V single-phase', '208/120 V three-phase', '480/277 V three-phase', 'B',
 'Standard residential service in the U.S. is 120/240 V single-phase, three-wire (two hots and a neutral).',
 'NEC Article 230', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'residential_wiring',
 'Per NEC 210.8(A), GFCI protection is required for 125 V, 15 and 20 A receptacles in which location?',
 'Bedrooms', 'Bathrooms', 'Living rooms', 'Hallways', 'B',
 'NEC 210.8(A)(1) requires GFCI protection for all 125 V, 15 and 20 A receptacles in bathrooms.',
 'NEC 210.8(A)(1)', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'residential_wiring',
 'Per NEC 404.2(C), a grounded (neutral) conductor is required at switch locations for what purpose?',
 'To power the switch light', 'To support occupancy sensors and smart switches', 'To provide a second hot conductor', 'To increase circuit capacity', 'B',
 'NEC 404.2(C) requires a neutral at switch locations to support occupancy sensors, timers, and other devices that require a neutral.',
 'NEC 404.2(C)', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'residential_wiring',
 'A 3-way switch is used to control a light from how many locations?',
 '1', '2', '3', '4', 'B',
 'A pair of 3-way switches controls a light from exactly 2 locations. For 3 or more locations, 4-way switches are added between the 3-way switches.',
 'Residential switching circuits', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'residential_wiring',
 'Per NEC 230.79(C), the minimum service disconnect rating for a single-family dwelling is:',
 '60 A', '100 A', '150 A', '200 A', 'B',
 'NEC 230.79(C) requires the service disconnecting means for a one-family dwelling to have a rating of not less than 100 A.',
 'NEC 230.79(C)', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=3 LIMIT 1), 'APPRENTICE', 'residential_wiring',
 'Per NEC 210.52(E)(1), at least one receptacle outlet is required in each dwelling unit basement in addition to laundry and utility receptacles. Where must an outdoor receptacle be installed?',
 'At the front door only', 'At each entrance at grade level', 'At the front and back of the dwelling', 'One at any accessible outdoor location', 'B',
 'NEC 210.52(E)(1) requires at least one receptacle outlet accessible at grade level at the front and back of each dwelling unit.',
 'NEC 210.52(E)(1)', 'medium'),

-- ============================================================
-- APPRENTICE Module 4: Electrical Safety (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'electrical_safety',
 'What does the acronym LOTO stand for in electrical safety?',
 'Load Out / Turn Off', 'Lockout / Tagout', 'Line Open / Terminal Off', 'Low Output / Test Only', 'B',
 'LOTO stands for Lockout/Tagout, a safety procedure to ensure equipment is properly shut down and not restarted during maintenance.',
 'OSHA 1910.147 / NFPA 70E', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'electrical_safety',
 'Before working on a de-energized circuit, a qualified person must verify absence of voltage using:',
 'A continuity tester', 'A voltage detector verified on a known live source', 'Visual inspection only', 'An ammeter', 'B',
 'NFPA 70E 120.5 requires verifying de-energization using a voltage detector that has been tested on a known live source before and after use.',
 'NFPA 70E 120.5', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'electrical_safety',
 'What type of PPE protects against arc flash hazards?',
 'Leather gloves', 'Arc-rated clothing (FR)', 'Latex gloves', 'Standard hard hat only', 'B',
 'Arc-rated (flame resistant) clothing is specifically tested and rated to protect workers from arc flash thermal energy, measured in cal/cm2.',
 'NFPA 70E 130.5', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'electrical_safety',
 'A GFCI device trips when it detects a current imbalance between the hot and neutral conductors exceeding:',
 '1 mA', '5 mA', '15 mA', '30 mA', 'B',
 'Class A GFCIs trip when the current imbalance between the ungrounded and grounded conductors exceeds 5 mA (approximately 4-6 mA).',
 'UL 943 / NEC 210.8', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'electrical_safety',
 'Per NFPA 70E, what is the minimum arc flash boundary for systems operating at 480 V?',
 'It varies based on incident energy analysis', '3 feet', '5 feet', '10 feet', 'A',
 'The arc flash boundary is determined by an incident energy analysis per NFPA 70E 130.5 and varies based on fault current, clearing time, and equipment configuration.',
 'NFPA 70E 130.5', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'electrical_safety',
 'Rubber insulating gloves used for electrical work must be tested at what maximum interval?',
 '3 months', '6 months', '12 months', '24 months', 'B',
 'OSHA 1910.137(c)(2)(ii) requires rubber insulating gloves to be electrically tested before first use and at maximum intervals of 6 months.',
 'OSHA 1910.137(c)(2)(ii)', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'electrical_safety',
 'What is the primary purpose of an equipment grounding conductor?',
 'Carry normal operating current', 'Provide a low-impedance path for fault current to trip the OCPD', 'Reduce voltage drop', 'Improve power factor', 'B',
 'The equipment grounding conductor provides a low-impedance fault current path to facilitate OCPD operation and clear ground faults quickly.',
 'NEC 250.4(A)(5)', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'electrical_safety',
 'Per NFPA 70E, energized electrical work is permitted only when:',
 'The worker has rubber gloves', 'De-energizing creates a greater hazard or is infeasible', 'A supervisor verbally approves it', 'The voltage is below 480 V', 'B',
 'NFPA 70E 110.3 permits energized work only when de-energizing introduces additional or increased hazards, or when the task is infeasible in a de-energized state.',
 'NFPA 70E 110.3', 'medium'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'electrical_safety',
 'What does the arc flash hazard label on equipment indicate?',
 'The wire size used', 'The available incident energy and required PPE category', 'The installation date', 'The manufacturer warranty', 'B',
 'Arc flash labels per NFPA 70E 130.5(H) must include nominal voltage, arc flash boundary, and either incident energy and working distance or the PPE category.',
 'NFPA 70E 130.5(H)', 'easy'),

((SELECT id FROM m WHERE cert_level='APPRENTICE' AND module_number=4 LIMIT 1), 'APPRENTICE', 'electrical_safety',
 'When using a portable ladder near overhead power lines under 50 kV, what is the OSHA minimum clearance?',
 '3 feet', '5 feet', '10 feet', '20 feet', 'C',
 'OSHA 1926.1408 requires a minimum clearance of 10 feet from overhead power lines energized at 50 kV or less.',
 'OSHA 1926.1408', 'easy'),

-- ============================================================
-- JOURNEYMAN Module 1: Commercial Wiring (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'commercial_wiring',
 'Per NEC Table 220.12, the general lighting load for an office building is calculated at how many VA per square foot?',
 '2 VA', '3 VA', '3.5 VA', '5 VA', 'C',
 'NEC Table 220.12 specifies 3.5 VA per square foot for office buildings for general lighting load calculations.',
 'NEC Table 220.12', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'commercial_wiring',
 'Per NEC 215.2(A)(1), a feeder supplies 50 A continuous and 20 A noncontinuous load. What is the minimum conductor ampacity?',
 '70 A', '82.5 A', '87.5 A', '100 A', 'B',
 '125% of 50 A = 62.5 A, plus 100% of 20 A = 20 A. Total minimum ampacity = 82.5 A.',
 'NEC 215.2(A)(1)', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'commercial_wiring',
 'Per NEC Chapter 9 Table C.1, what is the maximum number of 10 AWG THHN conductors in a 3/4-inch EMT?',
 '12', '16', '22', '26', 'C',
 'NEC Chapter 9, Table C.1 allows 22 conductors of 10 AWG THHN in 3/4-inch EMT.',
 'NEC Chapter 9, Table C.1', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'commercial_wiring',
 'When more than 3 current-carrying conductors are in a raceway, per NEC 310.15(C)(1) the adjustment factor for 4-6 conductors is:',
 '70%', '80%', '90%', '100%', 'B',
 'NEC Table 310.15(C)(1) requires an 80% adjustment factor for 4 to 6 current-carrying conductors in a raceway.',
 'NEC Table 310.15(C)(1)', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'commercial_wiring',
 'Per NEC 110.26(A)(1), what is the minimum working space depth in front of a 480 V panelboard (Condition 1)?',
 '3 feet', '3.5 feet', '4 feet', '5 feet', 'B',
 'NEC Table 110.26(A)(1) requires 3.5 feet (42 inches) of clear working space for equipment rated 151-600 V, Condition 1.',
 'NEC Table 110.26(A)(1)', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'commercial_wiring',
 'Per NEC 314.16(B), what volume allowance is required per 14 AWG conductor in a box fill calculation?',
 '1.75 cu in', '2.00 cu in', '2.25 cu in', '2.50 cu in', 'B',
 'NEC Table 314.16(B) assigns 2.00 cubic inches per 14 AWG conductor for box fill calculations.',
 'NEC 314.16(B)', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'commercial_wiring',
 'A commercial building has a 10,000 sq ft office area. Per NEC Table 220.12, what is the calculated general lighting load?',
 '20,000 VA', '30,000 VA', '35,000 VA', '50,000 VA', 'C',
 'General lighting load = area x VA per sq ft = 10,000 x 3.5 = 35,000 VA.',
 'NEC Table 220.12', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'commercial_wiring',
 'Per NEC 230.71(A), what is the maximum number of disconnects permitted to serve as the service disconnecting means?',
 '2', '4', '6', '8', 'C',
 'NEC 230.71(A) permits a maximum of six disconnects grouped in a single location to serve as the service disconnecting means.',
 'NEC 230.71(A)', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'commercial_wiring',
 'Per NEC 300.4(A)(1), NM cable passing through bored holes in wood framing must have the hole edge at least how far from the nearest stud edge?',
 '1 inch', '1-1/4 inches', '1-1/2 inches', '2 inches', 'B',
 'NEC 300.4(A)(1) requires 1-1/4 inches from the nearest edge, or protection by a 1/16-inch steel plate.',
 'NEC 300.4(A)(1)', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=1 LIMIT 1), 'JOURNEYMAN', 'commercial_wiring',
 'Per NEC 408.36, continuous loads on a panelboard must not exceed what percentage of the bus rating (unless 100% rated)?',
 '70%', '80%', '90%', '100%', 'B',
 'NEC 408.36 combined with 210.20(A) limits continuous loads to 80% of the overcurrent device and bus bar rating unless listed for 100% continuous operation.',
 'NEC 408.36 / 210.20(A)', 'medium'),

-- ============================================================
-- JOURNEYMAN Module 2: Motor Controls (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'motor_controls',
 'Per NEC 430.22, branch circuit conductors supplying a single motor must have an ampacity of at least what percentage of the motor FLC?',
 '100%', '115%', '125%', '150%', 'C',
 'NEC 430.22 requires branch circuit conductors to have an ampacity of not less than 125% of the motor full-load current.',
 'NEC 430.22', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'motor_controls',
 'Per NEC Table 430.52, what is the maximum time-delay fuse size for a 50 A FLC motor?',
 '62.5 A', '75 A', '87.5 A', '100 A', 'C',
 'NEC Table 430.52 allows time-delay fuses up to 175% of FLC: 50 x 1.75 = 87.5 A.',
 'NEC Table 430.52', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'motor_controls',
 'A VFD (variable frequency drive) controls motor speed by varying:',
 'Only voltage', 'Only frequency', 'Both voltage and frequency', 'Only current', 'C',
 'VFDs control AC motor speed by varying both frequency and voltage to maintain the V/Hz ratio for optimal torque production.',
 'Motor control theory', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'motor_controls',
 'In a 3-wire motor control circuit, the seal-in (holding) contact is wired:',
 'In series with the motor', 'In parallel with the start pushbutton', 'In series with the stop pushbutton', 'In parallel with the overload', 'B',
 'The seal-in contact is wired in parallel with the momentary start button so that releasing the start button does not de-energize the contactor coil.',
 'Motor control theory', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'motor_controls',
 'Per NEC 430.6(A)(1), motor branch circuit conductors and OCPD must be sized using:',
 'The nameplate FLA', 'The NEC Table 430.250 FLC value', 'The higher of nameplate or table value', 'The service factor current', 'B',
 'NEC 430.6(A)(1) requires using the full-load current from NEC Table 430.248/250 (not the nameplate FLA) for sizing conductors and OCPD.',
 'NEC 430.6(A)(1)', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'motor_controls',
 'What type of overload relay uses a eutectic alloy (solder pot) element?',
 'Bimetallic', 'Melting alloy', 'Electronic', 'Magnetic', 'B',
 'Melting alloy (solder pot) overload relays use a eutectic alloy that melts at a precise temperature when overcurrent heats the element.',
 'Motor control theory', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'motor_controls',
 'Per NEC 430.24, feeder conductors supplying multiple motors must be sized at:',
 '125% of all motor FLCs', '125% of largest FLC plus 100% of all other FLCs', '150% of the largest FLC', '100% of total FLC', 'B',
 'NEC 430.24 requires feeder conductors sized at 125% of the largest motor FLC plus the sum of all other motor FLCs at 100%.',
 'NEC 430.24', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'motor_controls',
 'A reversing motor starter uses how many contactors?',
 '1', '2', '3', '4', 'B',
 'A reversing starter uses two contactors (forward and reverse) with electrical and mechanical interlocks to swap two phase leads for direction reversal.',
 'Motor control theory', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'motor_controls',
 'What PLC instruction type examines whether an input bit is ON (closed)?',
 'OTE (Output Energize)', 'XIC (Examine If Closed)', 'XIO (Examine If Open)', 'TON (Timer On Delay)', 'B',
 'XIC (Examine If Closed) is a PLC input instruction that is true when the addressed bit is ON (1), used to check if a switch or sensor is active.',
 'PLC programming / IEC 61131', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=2 LIMIT 1), 'JOURNEYMAN', 'motor_controls',
 'A wye-delta motor starter reduces starting current to approximately what percentage of full-voltage starting current?',
 '25%', '33%', '50%', '75%', 'B',
 'Wye-delta starting reduces starting current to approximately 33% (1/3) of the direct-on-line starting current by reducing the voltage across each winding.',
 'Motor starting theory', 'medium'),

-- ============================================================
-- JOURNEYMAN Module 3: Grounding & Bonding (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'grounding_bonding',
 'NEC Article 250 covers which of the following?',
 'Overcurrent protection', 'Grounding and bonding', 'Wiring methods', 'Motor installations', 'B',
 'NEC Article 250 provides comprehensive requirements for grounding and bonding of electrical systems and equipment.',
 'NEC Article 250', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'grounding_bonding',
 'Per NEC Table 250.122, the minimum equipment grounding conductor for a 100 A OCPD is:',
 '10 AWG copper', '8 AWG copper', '6 AWG copper', '4 AWG copper', 'B',
 'NEC Table 250.122 requires a minimum 8 AWG copper equipment grounding conductor for a 100 A overcurrent device.',
 'NEC Table 250.122', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'grounding_bonding',
 'Per NEC 250.53(G), a ground rod must be driven to a minimum depth of:',
 '4 feet', '6 feet', '8 feet', '10 feet', 'C',
 'NEC 250.53(G) requires ground rods to be driven to a minimum depth of 8 feet.',
 'NEC 250.53(G)', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'grounding_bonding',
 'Per NEC 250.66, the grounding electrode conductor for a service with 3/0 AWG copper service conductors must be at least:',
 '8 AWG copper', '6 AWG copper', '4 AWG copper', '2 AWG copper', 'D',
 'NEC Table 250.66 requires a minimum 2 AWG copper GEC for service conductors larger than 2/0 AWG up to 3/0 AWG copper.',
 'NEC Table 250.66', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'grounding_bonding',
 'What is the primary purpose of bonding in an electrical system?',
 'To carry load current', 'To establish an effective ground-fault current path', 'To reduce voltage drop', 'To measure resistance', 'B',
 'NEC 250.4(A)(3) states that bonding establishes an effective ground-fault current path by connecting normally non-current-carrying metal parts together.',
 'NEC 250.4(A)(3)', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'grounding_bonding',
 'Per NEC 250.30(A), a separately derived system such as a transformer secondary requires:',
 'A transfer switch', 'Its own grounding electrode conductor connection', 'A ground-fault relay', 'Three ground rods', 'B',
 'NEC 250.30(A) requires separately derived systems to have a grounding electrode conductor connected to a grounding electrode.',
 'NEC 250.30(A)', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'grounding_bonding',
 'Per NEC 250.64(E), multiple service disconnects may share a grounding electrode conductor connected to:',
 'Any one disconnect only', 'A common grounding bus bar', 'The water pipe only', 'The neutral bus only', 'B',
 'NEC 250.64(E) permits the use of a common grounding electrode conductor bus bar sized per 250.66 when multiple disconnects are present.',
 'NEC 250.64(E)', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'grounding_bonding',
 'The main bonding jumper connects the grounded conductor (neutral) to the:',
 'Utility transformer', 'Equipment grounding conductor bus at the service', 'Load side of the main breaker', 'Branch circuit panel', 'B',
 'The main bonding jumper connects the grounded conductor (neutral bus) to the equipment grounding conductor bus at the service disconnect per NEC 250.24(B).',
 'NEC 250.24(B)', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'grounding_bonding',
 'Per NEC 250.104(A), interior metal water piping must be bonded to the:',
 'Nearest ground rod', 'Service equipment enclosure, grounded conductor, or GEC', 'Cold water pipe only', 'Building steel only', 'B',
 'NEC 250.104(A) requires bonding of metal water piping to the service equipment enclosure, the grounded conductor at the service, the GEC, or the grounding electrode.',
 'NEC 250.104(A)', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=3 LIMIT 1), 'JOURNEYMAN', 'grounding_bonding',
 'Why must the neutral-to-ground bond exist at only one point in a service (typically the main panel)?',
 'To save wire', 'To prevent parallel neutral current paths on grounding conductors', 'To reduce cost', 'It can be at multiple points', 'B',
 'A single neutral-to-ground bond prevents objectionable current on equipment grounding conductors and metallic raceways per NEC 250.6.',
 'NEC 250.6 / 250.24(A)(5)', 'hard'),

-- ============================================================
-- JOURNEYMAN Module 4: Transformers (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'transformers',
 'A 75 kVA, 480/208-120 V three-phase transformer has a secondary full-load current of approximately:',
 '104 A', '156 A', '208 A', '90 A', 'C',
 'I = kVA x 1000 / (sqrt(3) x V) = 75,000 / (1.732 x 208) = 208 A.',
 'Transformer calculations', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'transformers',
 'A delta-wye transformer connection produces what inherent phase shift between primary and secondary?',
 '0 degrees', '30 degrees', '45 degrees', '120 degrees', 'B',
 'Delta-wye (and wye-delta) connections inherently produce a 30-degree phase shift between primary and secondary voltages.',
 'IEEE C57.12.00', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'transformers',
 'Per NEC 450.3(B), what is the maximum overcurrent protection for a dry-type transformer rated 600 V or less with primary protection only?',
 '100%', '125%', '150%', '200%', 'B',
 'NEC Table 450.3(B) allows a maximum of 125% for primary-only overcurrent protection of transformers rated 600 V or less. The next standard size up to 167% is allowed if 125% does not correspond to a standard rating.',
 'NEC Table 450.3(B)', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'transformers',
 'Transformer tap changers are used to:',
 'Change the kVA rating', 'Adjust the turns ratio to compensate for voltage variations', 'Switch between single and three phase', 'Change the frequency', 'B',
 'Tap changers adjust the turns ratio by selecting different taps on the winding to compensate for supply voltage variations and maintain rated secondary voltage.',
 'Transformer theory', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'transformers',
 'When paralleling transformers, which parameters must match?',
 'kVA rating only', 'Voltage ratio, percent impedance, and polarity', 'Physical dimensions', 'Manufacturer and model', 'B',
 'Paralleling requires matching voltage ratios, percent impedance, and correct polarity (or phase rotation for 3-phase) to prevent circulating currents.',
 'IEEE C57.12.00', 'hard'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'transformers',
 'A transformer has a 480 V primary and a 120 V secondary. What is the turns ratio?',
 '2:1', '4:1', '3:1', '5:1', 'B',
 'Turns ratio = primary voltage / secondary voltage = 480 / 120 = 4:1.',
 'Transformer theory', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'transformers',
 'What is the main advantage of a delta-delta transformer connection?',
 'Higher efficiency', 'It can operate with one transformer removed (open delta)', 'Zero phase shift', 'Both B and C', 'D',
 'Delta-delta connections have no phase shift and can continue operating in open-delta configuration if one transformer fails, at reduced (57.7%) capacity.',
 'Transformer theory', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'transformers',
 'A 45 kVA single-phase transformer with a 240 V secondary has a full-load secondary current of:',
 '93.75 A', '125 A', '187.5 A', '225 A', 'C',
 'I = kVA x 1000 / V = 45,000 / 240 = 187.5 A.',
 'Transformer calculations', 'easy'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'transformers',
 'Per NEC 450.13(B), transformers rated over 600 V must be installed in:',
 'Any accessible location', 'A vault or qualified area per Article 450 Part III', 'Outdoors only', 'Within 6 feet of the service entrance', 'B',
 'NEC 450.13(B) requires transformers rated over 600 V to be installed in a transformer vault per Part III of Article 450, with certain exceptions.',
 'NEC 450.13(B)', 'medium'),

((SELECT id FROM m WHERE cert_level='JOURNEYMAN' AND module_number=4 LIMIT 1), 'JOURNEYMAN', 'transformers',
 'What causes circulating currents in parallel transformers with mismatched impedance?',
 'Unequal voltage at no load', 'Unequal load sharing causing one transformer to push current into the other', 'Different frequencies', 'Different core materials', 'B',
 'Mismatched impedance causes unequal load sharing. The lower-impedance transformer carries more than its share, and the voltage difference drives circulating currents.',
 'IEEE C57.12.00', 'hard'),

-- ============================================================
-- MASTER Module 1: Advanced Load Calculations (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'advanced_load_calculations',
 'Per NEC 220.87, the optional method for existing installations uses what data for the base load?',
 '100% of the highest 15-minute demand in the preceding 12 months', '80% of the panel rating', '125% of the connected load', 'The nameplate rating of all equipment', 'A',
 'NEC 220.87 allows use of the maximum demand data (highest 15-minute peak) measured over 12 consecutive months as the basis for existing installation calculations.',
 'NEC 220.87', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'advanced_load_calculations',
 'Per NEC Table 220.55, what is the maximum demand for a single household electric range rated at 12 kW or less?',
 '6 kW', '8 kW', '10 kW', '12 kW', 'B',
 'NEC Table 220.55 Column C specifies 8 kW as the maximum demand for a single range rated 12 kW or less.',
 'NEC Table 220.55', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'advanced_load_calculations',
 'Per NEC 220.82 (optional method for dwellings), the first 10 kVA of general loads is calculated at 100%, and the remainder at:',
 '25%', '35%', '40%', '50%', 'C',
 'NEC 220.82(B) applies 100% to the first 10 kVA and 40% to the remainder of the general calculated load for the optional method.',
 'NEC 220.82(B)', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'advanced_load_calculations',
 'Per NEC 625.42, the branch circuit for an EV charging station (EVSE) must be rated at least:',
 '100% of the EVSE nameplate current', '125% of the maximum load', '150% of the nameplate rating', '80% of the circuit rating', 'B',
 'NEC 625.42 requires the branch circuit rating to be not less than 125% of the maximum load of the EVSE, as EV charging is typically a continuous load.',
 'NEC 625.42', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'advanced_load_calculations',
 'Per NEC Table 220.42, the demand factor for the first 12,500 VA of general lighting in a dwelling is:',
 '80%', '100%', '125%', '35%', 'B',
 'NEC Table 220.42 applies 100% demand factor to the first 12,500 VA of dwelling general lighting, then 35% for the remainder over 12,500 VA.',
 'NEC Table 220.42', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'advanced_load_calculations',
 'For a multifamily dwelling with 40 units, what demand factor applies to the cooking equipment load per NEC Table 220.55?',
 '15 kW per Column C', '25 kW (Column C for 40 units)', 'Refer to Column C: 28 kW for 40 ranges', '100% of connected load', 'B',
 'NEC Table 220.55 Column C specifies 25 kW maximum demand for 40 household electric ranges rated 12 kW or less.',
 'NEC Table 220.55', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'advanced_load_calculations',
 'Per NEC 220.14(J), each dwelling unit receptacle outlet for general-use circuits is counted at:',
 '1.0 VA per outlet', '90 VA per outlet', '180 VA per outlet', '1.5 VA per sq ft', 'C',
 'NEC 220.14(J) assigns 180 VA per general-use receptacle outlet for non-dwelling occupancies. For dwellings, receptacle loads are included in the general lighting load per 220.12.',
 'NEC 220.14(J)', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'advanced_load_calculations',
 'When adding a Level 2 EV charger (48 A, 240 V) to an existing residence, the load added to the service calculation is:',
 '9,600 VA', '11,520 VA', '12,000 VA', '7,680 VA', 'B',
 'EV charging is a continuous load: 48 A x 240 V = 11,520 VA. The circuit must be rated at 125% of 48 A = 60 A per NEC 625.42.',
 'NEC 625.42', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'advanced_load_calculations',
 'Per NEC 220.82, when using the optional calculation for a dwelling, air conditioning or heat (whichever is larger) is added at what percentage?',
 '40%', '65%', '100%', '125%', 'C',
 'NEC 220.82(C) adds the largest of air conditioning or heating loads at 100%. The 40% demand factor applies only to the general loads portion.',
 'NEC 220.82(C)', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=1 LIMIT 1), 'MASTER', 'advanced_load_calculations',
 'Per NEC 220.61, the maximum unbalanced load on a neutral conductor of a 3-wire feeder is determined by:',
 'Adding all line loads together', 'Using the maximum load between any one ungrounded conductor and the neutral', 'Doubling the smallest phase load', 'Using 70% of the total connected load', 'B',
 'NEC 220.61 requires the feeder neutral load to be the maximum unbalanced load—the maximum net calculated load between the neutral and any one ungrounded conductor.',
 'NEC 220.61', 'hard'),

-- ============================================================
-- MASTER Module 2: Hazardous Locations (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'hazardous_locations',
 'Per NEC Article 500, Class I hazardous locations contain:',
 'Combustible dusts', 'Flammable gases or vapors', 'Ignitable fibers', 'Metallic particles', 'B',
 'NEC 500.5(B) defines Class I locations as those where flammable gases, flammable liquid-produced vapors, or combustible liquid-produced vapors may be present.',
 'NEC 500.5(B)', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'hazardous_locations',
 'In the NEC Division system, a Class I, Division 1 location is one where hazardous concentrations exist:',
 'Only during abnormal conditions', 'Under normal operating conditions or frequently during repair', 'Never during normal operations', 'Only outdoors', 'B',
 'Class I, Division 1 (NEC 500.5(B)(1)) includes locations where ignitable concentrations exist under normal operating conditions, or during repair/maintenance, or during breakdown/faulty operation.',
 'NEC 500.5(B)(1)', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'hazardous_locations',
 'Per NEC Article 501, what type of wiring method is generally required in Class I, Division 1 locations?',
 'NM cable', 'Rigid metal conduit (threaded) or MI cable', 'EMT', 'Flexible cord', 'B',
 'NEC 501.10(A) requires threaded rigid metal conduit, threaded IMC, or Type MI cable in Class I, Division 1 locations.',
 'NEC 501.10(A)', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'hazardous_locations',
 'NEC 505 introduces the Zone classification system as an alternative to the Division system. Zone 0 is defined as:',
 'Where ignitable concentrations exist occasionally', 'Where ignitable concentrations are present continuously or for long periods', 'Where ignitable concentrations exist only under abnormal conditions', 'Non-hazardous areas', 'B',
 'NEC 505.5(B)(1) defines Zone 0 as areas where ignitable concentrations of flammable gases or vapors are present continuously or for long periods of time.',
 'NEC 505.5(B)(1)', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'hazardous_locations',
 'Class II hazardous locations per NEC 500.5(C) contain:',
 'Flammable gases', 'Combustible dust', 'Ignitable fibers', 'Corrosive vapors', 'B',
 'Class II locations contain combustible dust. Examples include grain elevators, coal handling plants, and metal powder processing.',
 'NEC 500.5(C)', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'hazardous_locations',
 'Sealing fittings per NEC 501.15 are required in Class I locations to:',
 'Reduce conduit fill', 'Prevent the passage of gases, vapors, and flames through conduit', 'Increase wire pulling tension', 'Support the conduit weight', 'B',
 'NEC 501.15 requires sealing fittings to prevent flammable gases and vapors from traveling through the conduit system and to contain explosions within enclosures.',
 'NEC 501.15', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'hazardous_locations',
 'Per NEC 501.15(A)(4), a conduit seal is required within how many inches of an enclosure containing arcing equipment in a Class I, Division 1 location?',
 '6 inches', '12 inches', '18 inches', '24 inches', 'C',
 'NEC 501.15(A)(4) requires conduit seals within 18 inches of enclosures housing arcing or high-temperature devices in Class I, Division 1 locations.',
 'NEC 501.15(A)(4)', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'hazardous_locations',
 'Intrinsically safe (IS) systems per NEC Article 504 limit energy to levels:',
 'That can power large motors', 'Incapable of igniting a flammable atmosphere', 'Equal to standard branch circuits', 'Above 50 V', 'B',
 'Intrinsically safe systems per NEC Article 504 limit the electrical and thermal energy to levels incapable of causing ignition under both normal and fault conditions.',
 'NEC Article 504', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'hazardous_locations',
 'Per NEC 500.8(A), explosion-proof equipment is designed to:',
 'Prevent any explosion from occurring', 'Contain an internal explosion and prevent ignition of the surrounding atmosphere', 'Withstand external blast forces', 'Resist corrosion', 'B',
 'Explosion-proof equipment is designed to contain an internal explosion of a flammable gas mixture and prevent the ignition of the surrounding atmosphere.',
 'NEC 500.8(A)', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=2 LIMIT 1), 'MASTER', 'hazardous_locations',
 'Per NEC 515.3, what is the classification of the area within 18 inches of the floor in a commercial garage where volatile flammable liquids are dispensed?',
 'Unclassified', 'Class I, Division 1', 'Class I, Division 2', 'Class II, Division 1', 'C',
 'NEC 515.3 classifies the area within 18 inches of the floor in portions of commercial garages used for repair as Class I, Division 2 (where ventilation is provided).',
 'NEC 515.3', 'hard'),

-- ============================================================
-- MASTER Module 3: Power Quality (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'power_quality',
 'Harmonics in an electrical system are integer multiples of the:',
 'Voltage level', 'Fundamental frequency', 'Power factor', 'Impedance', 'B',
 'Harmonics are sinusoidal voltages or currents at integer multiples of the fundamental frequency (e.g., 3rd harmonic = 180 Hz on a 60 Hz system).',
 'IEEE 519', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'power_quality',
 'Which harmonic is particularly problematic in three-phase, four-wire systems because it adds in the neutral?',
 '2nd harmonic', '3rd harmonic (triplen)', '5th harmonic', '7th harmonic', 'B',
 'Triplen harmonics (3rd, 9th, 15th) are zero-sequence and add algebraically in the neutral conductor, potentially causing neutral overloading.',
 'IEEE 519 / NEC 310.15(E)', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'power_quality',
 'Power factor is defined as the ratio of:',
 'Reactive power to apparent power', 'Real power (kW) to apparent power (kVA)', 'Voltage to current', 'Resistance to impedance', 'B',
 'Power factor = real power (kW) / apparent power (kVA). It indicates how effectively electrical power is being converted to useful work output.',
 'IEEE 141 / Basic power theory', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'power_quality',
 'A facility has 200 kW of real power and 250 kVA of apparent power. What is the power factor?',
 '0.70', '0.80', '0.85', '0.90', 'B',
 'PF = kW / kVA = 200 / 250 = 0.80.',
 'Power factor calculation', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'power_quality',
 'Power factor correction capacitors are installed to:',
 'Increase real power', 'Reduce reactive power (kVAR) and improve power factor', 'Increase voltage', 'Store energy for backup', 'B',
 'Capacitors supply leading reactive power (kVAR) that offsets the lagging reactive power drawn by inductive loads, improving the overall power factor.',
 'IEEE 141 / NEC 460', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'power_quality',
 'Per NEC Article 285, a Type 1 surge protective device (SPD) is installed:',
 'At individual receptacles', 'On the load side of the service overcurrent device', 'On the line side of the service disconnect', 'Inside equipment enclosures only', 'C',
 'NEC 285.23 requires Type 1 SPDs to be installed on the line side of the service disconnect. Type 2 SPDs are installed on the load side.',
 'NEC 285.23', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'power_quality',
 'What is Total Harmonic Distortion (THD)?',
 'The sum of all harmonic voltages', 'The ratio of the RMS value of all harmonics to the fundamental, expressed as a percentage', 'The peak voltage divided by RMS voltage', 'The difference between line and phase voltage', 'B',
 'THD is the ratio of the root-sum-square of all harmonic components to the fundamental component, expressed as a percentage.',
 'IEEE 519', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'power_quality',
 'A double-conversion (online) UPS provides:',
 'Power only during outages', 'Continuous conditioned power by converting AC-DC-AC at all times', 'Passive standby protection only', 'Frequency conversion only', 'B',
 'A double-conversion (online) UPS continuously converts incoming AC to DC (charging batteries) and then back to AC, providing complete isolation from utility power quality issues.',
 'IEEE 446 / UPS theory', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'power_quality',
 'Per IEEE 519, the recommended maximum voltage THD at the point of common coupling (PCC) for general systems is:',
 '3%', '5%', '8%', '10%', 'B',
 'IEEE 519-2014 recommends a maximum voltage THD of 5% at the PCC for general systems (bus voltage 1 kV through 69 kV).',
 'IEEE 519-2014 Table 1', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=3 LIMIT 1), 'MASTER', 'power_quality',
 'Active harmonic filters mitigate harmonics by:',
 'Blocking harmonic frequencies with passive elements', 'Injecting equal and opposite harmonic currents to cancel distortion', 'Increasing system impedance', 'Adding capacitance to the circuit', 'B',
 'Active harmonic filters use power electronics to inject currents that are equal in magnitude but opposite in phase to the harmonic currents, effectively canceling them.',
 'IEEE 519 / Power quality engineering', 'hard'),

-- ============================================================
-- MASTER Module 4: Project Management & Code (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'project_management_code',
 'Per NEC 110.24(A), service equipment in other than dwelling units must be field-marked with:',
 'The installer name and date', 'The available fault current and date of calculation', 'The utility account number', 'The conductor size used', 'B',
 'NEC 110.24(A) requires field marking of the maximum available fault current and the date the fault current calculation was performed.',
 'NEC 110.24(A)', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'project_management_code',
 'How frequently is the National Electrical Code (NEC) updated and published?',
 'Annually', 'Every 2 years', 'Every 3 years', 'Every 5 years', 'C',
 'The NEC (NFPA 70) is updated and published on a three-year cycle by the National Fire Protection Association.',
 'NFPA 70 revision cycle', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'project_management_code',
 'Who has the authority to approve or reject electrical installations in a given jurisdiction?',
 'The electrician', 'The Authority Having Jurisdiction (AHJ)', 'The general contractor', 'The property owner', 'B',
 'The AHJ (typically the local building department or electrical inspector) has the authority to approve or reject electrical installations per NEC 90.4.',
 'NEC 90.4', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'project_management_code',
 'Per NEC 700.12, the alternate power source for emergency systems must restore power within:',
 '5 seconds', '10 seconds', '30 seconds', '60 seconds', 'B',
 'NEC 700.12 requires the emergency system alternate power source to automatically supply power within 10 seconds of failure of the normal supply.',
 'NEC 700.12', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'project_management_code',
 'Per NEC 110.14(C)(1)(b), conductors 1 AWG and larger must use which ampacity temperature column unless all terminations are rated higher?',
 '60 C', '75 C', '90 C', '105 C', 'B',
 'NEC 110.14(C)(1)(b) requires the 75 C ampacity column for conductors 1 AWG and larger unless equipment terminations are listed and marked for a higher temperature.',
 'NEC 110.14(C)(1)(b)', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'project_management_code',
 'A plan review for a commercial electrical installation typically verifies compliance with:',
 'Only the NEC', 'The NEC, local amendments, and applicable building codes', 'OSHA standards only', 'The contractor''s specifications only', 'B',
 'Plan review verifies compliance with the NEC, any local code amendments, applicable building codes (IBC), energy codes (IECC), and ADA requirements.',
 'NEC 90.4 / Local jurisdiction', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'project_management_code',
 'Per NEC 695.6(C)(1), fire pump supply conductors must have an ampacity of at least what percentage of the motor FLC?',
 '100%', '115%', '125%', '150%', 'C',
 'NEC 695.6(C)(1) requires fire pump supply conductors to have an ampacity of at least 125% of the motor FLC and be able to carry locked-rotor current.',
 'NEC 695.6(C)(1)', 'hard'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'project_management_code',
 'When is an electrical permit typically required?',
 'Only for new construction', 'For any new installation, alteration, or extension of electrical wiring', 'Only for commercial work', 'Only for work over 200 A', 'B',
 'Most jurisdictions require an electrical permit for any new installation, alteration, or extension of electrical wiring, with minor exceptions for like-for-like replacements.',
 'Local building codes / NEC 80.19', 'easy'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'project_management_code',
 'What document must a master electrician typically provide to the AHJ before starting a commercial project?',
 'A resume', 'Approved plans, permit application, and proof of license', 'A warranty certificate', 'A materials list only', 'B',
 'Before starting commercial electrical work, a master electrician must submit approved electrical plans, a permit application, and proof of a valid license to the AHJ.',
 'Local licensing laws / NEC 80.15', 'medium'),

((SELECT id FROM m WHERE cert_level='MASTER' AND module_number=4 LIMIT 1), 'MASTER', 'project_management_code',
 'Per NEC 90.3, Chapters 1-4 apply generally, while Chapters 5-7:',
 'Replace Chapters 1-4 entirely', 'Supplement or modify Chapters 1-4 for special occupancies, equipment, and conditions', 'Apply only to residential work', 'Are informational only', 'B',
 'NEC 90.3 states that Chapters 5, 6, and 7 supplement or modify the general rules in Chapters 1 through 4 for special conditions.',
 'NEC 90.3', 'medium');
