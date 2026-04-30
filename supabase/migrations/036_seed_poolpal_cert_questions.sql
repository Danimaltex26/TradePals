-- 036_seed_poolpal_cert_questions.sql
-- Seed ~100 exam-quality cert prep questions for PoolPal
-- Cert levels: CPO, CST, RESIDENTIAL, COMMERCIAL
-- Categories: water_chemistry, filtration, pumps_motors, heating, safety, codes_standards, maintenance

INSERT INTO poolpal.cert_prep_questions
  (cert_level, category, question, option_a, option_b, option_c, option_d, correct_answer, explanation, code_reference, difficulty)
VALUES

-- ============================================================
-- CPO (Certified Pool Operator) — 30 questions
-- ============================================================

-- water_chemistry
('CPO', 'water_chemistry',
 'What is the ideal pH range for a public swimming pool?',
 '6.8 – 7.0', '7.2 – 7.8', '7.8 – 8.2', '8.0 – 8.4',
 'B',
 'The recommended pH range is 7.2–7.8. This range maximizes chlorine efficacy while minimizing bather discomfort and equipment corrosion.',
 'ANSI/APSP-11 2009, Section 5.2', 1),

('CPO', 'water_chemistry',
 'A pool has a pH of 7.5, total alkalinity of 80 ppm, calcium hardness of 200 ppm, TDS of 1000 ppm, and a water temperature of 80°F. The calculated Langelier Saturation Index (LSI) is –0.3. What does this indicate?',
 'The water is scaling', 'The water is balanced', 'The water is corrosive', 'The water needs immediate draining',
 'C',
 'A negative LSI value indicates the water is corrosive and will tend to dissolve calcium from plaster surfaces and metal fittings. Values between –0.3 and +0.3 are generally acceptable, but –0.3 is at the low end and corrective action is warranted.',
 'ANSI/APSP-11 2009, Section 7', 3),

('CPO', 'water_chemistry',
 'What is the primary purpose of cyanuric acid (CYA) in an outdoor pool?',
 'To raise pH', 'To stabilize chlorine against UV degradation', 'To increase calcium hardness', 'To lower total alkalinity',
 'B',
 'Cyanuric acid forms a bond with free chlorine that protects it from rapid degradation by ultraviolet light. Without CYA, unstabilized chlorine can lose up to 90% of its effectiveness within two hours of direct sunlight.',
 'ANSI/APSP-11 2009, Section 5.7', 1),

('CPO', 'water_chemistry',
 'The recommended free chlorine residual for a public pool is:',
 '0.5 – 1.0 ppm', '1.0 – 4.0 ppm', '5.0 – 8.0 ppm', '0.1 – 0.5 ppm',
 'B',
 'Most health departments and MAHC recommend maintaining free chlorine between 1.0 and 4.0 ppm in public pools to ensure adequate disinfection while remaining safe for bathers.',
 'MAHC 4.7.3.1.1', 1),

('CPO', 'water_chemistry',
 'Which chemical should be used to lower pH without significantly affecting total alkalinity?',
 'Sodium bisulfate', 'Carbon dioxide injection', 'Muriatic acid', 'Sodium carbonate',
 'B',
 'CO2 injection lowers pH by forming carbonic acid but has a minimal net effect on total alkalinity compared to strong acids. Muriatic acid and sodium bisulfate lower both pH and alkalinity.',
 'ANSI/APSP-11 2009, Section 6.3', 2),

('CPO', 'water_chemistry',
 'What is the maximum recommended CYA level for a public pool per MAHC guidelines?',
 '30 ppm', '50 ppm', '90 ppm', '150 ppm',
 'C',
 'MAHC recommends a maximum CYA of 90 ppm for public pools. Higher levels reduce chlorine effectiveness and require proportionally higher free chlorine residuals to maintain adequate disinfection.',
 'MAHC 4.7.3.1.7', 2),

('CPO', 'water_chemistry',
 'Combined chlorine (chloramines) should not exceed:',
 '0.2 ppm', '0.4 ppm', '1.0 ppm', '2.0 ppm',
 'A',
 'Combined chlorine above 0.2 ppm causes eye and skin irritation and produces the characteristic "chlorine smell." Superchlorination or breakpoint chlorination is needed when combined chlorine exceeds this threshold.',
 'MAHC 4.7.3.1.2', 2),

('CPO', 'water_chemistry',
 'Breakpoint chlorination is achieved when the free chlorine dose reaches what multiple of the combined chlorine reading?',
 '5x', '10x', '15x', '20x',
 'B',
 'To reach breakpoint and destroy chloramines, the free chlorine dose must be approximately 10 times the combined chlorine reading. This oxidizes all chloramine compounds.',
 'Pool Operator Primer, NSPF Chapter 7', 2),

-- filtration
('CPO', 'filtration',
 'What is the standard filtration rate for a high-rate sand filter?',
 '3–5 gpm/ft²', '10–15 gpm/ft²', '15–20 gpm/ft²', '20–25 gpm/ft²',
 'C',
 'High-rate sand filters operate at 15–20 gpm per square foot of filter area. This is considerably higher than the 3–5 gpm/ft² rate of a rapid sand filter used in water treatment.',
 'ANSI/APSP-11 2009, Section 8.2', 2),

('CPO', 'filtration',
 'A DE filter is rated to remove particles down to what size?',
 '25–30 microns', '10–15 microns', '1–5 microns', '50–75 microns',
 'C',
 'Diatomaceous earth filters can remove particles as small as 1–5 microns, making them the most efficient of the three common pool filter types.',
 'ANSI/APSP-11 2009, Section 8.4', 1),

('CPO', 'filtration',
 'When should a sand filter be backwashed?',
 'Every 24 hours regardless of pressure', 'When the pressure gauge reads 8–10 psi above clean starting pressure', 'Only when water clarity drops', 'Monthly on a fixed schedule',
 'B',
 'Backwashing should occur when the pressure gauge shows 8–10 psi above the clean starting pressure. This indicates the filter bed has accumulated enough debris to restrict flow.',
 'ANSI/APSP-11 2009, Section 8.2.3', 1),

-- pumps_motors
('CPO', 'pumps_motors',
 'A pool pump is rated at 80 GPM at 60 feet of total dynamic head (TDH). If the actual system TDH is 75 feet, what happens to the flow rate?',
 'Flow rate increases', 'Flow rate stays the same', 'Flow rate decreases', 'The pump shuts off automatically',
 'C',
 'As TDH increases beyond the design point, pump flow rate decreases according to the pump curve. Higher resistance means the pump moves less water per minute.',
 'Hydraulic Institute Standards', 2),

('CPO', 'pumps_motors',
 'What is the most common cause of a pump losing prime?',
 'Clogged impeller', 'Air leak on the suction side', 'High water temperature', 'Dirty filter',
 'B',
 'An air leak on the suction side of the pump allows air to enter and displace water, breaking the prime. Common leak sources include deteriorated pump lid O-rings, cracked suction pipes, and loose fittings.',
 'Pool Operator Primer, NSPF Chapter 9', 1),

-- safety
('CPO', 'safety',
 'Under the Virginia Graeme Baker Pool and Spa Safety Act, which of the following is required on all public pool and spa drain covers?',
 'Colored markings for visibility', 'Anti-vortex design meeting ASME/ANSI A112.19.8', 'Mesh screening with 1/4-inch openings', 'Magnetic locking mechanisms',
 'B',
 'The VGB Act requires all drain covers in public pools and spas to comply with ASME/ANSI A112.19.8, which specifies anti-entrapment design, flow ratings, and structural integrity standards.',
 'Virginia Graeme Baker Pool & Spa Safety Act (P.L. 110-140, Section 1404)', 1),

('CPO', 'safety',
 'If a public pool has a single main drain, which additional safety device is required by the VGB Act?',
 'A second skimmer', 'A safety vacuum release system (SVRS)', 'A floating rope at the 5-foot mark', 'An automatic chemical feeder',
 'B',
 'When a pool has a single unblockable drain, the VGB Act requires at least one additional anti-entrapment system such as an SVRS, gravity drainage, automatic pump shut-off, or drain disablement.',
 'VGB Act Section 1404(c)(1)(A)', 2),

('CPO', 'safety',
 'What is the minimum depth marking requirement for a public pool?',
 'Only at the deep end', 'At the shallow end, deep end, and break in slope', 'Only at entry points', 'Every 10 feet along the perimeter',
 'B',
 'Depth markers must be placed at the shallow end, deep end, the break in slope (where the bottom transitions from shallow to deep), and at maximum 25-foot intervals around the pool perimeter.',
 'ANSI/APSP-1 2014, Section 5.2', 1),

-- codes_standards
('CPO', 'codes_standards',
 'According to MAHC, what is the maximum water temperature allowed for a public spa?',
 '100°F', '104°F', '110°F', '115°F',
 'B',
 'MAHC limits public spa water temperature to a maximum of 104°F (40°C) to reduce the risk of hyperthermia. Temperatures above this level can cause rapid onset of heat-related illness.',
 'MAHC 4.8.6.1', 1),

('CPO', 'codes_standards',
 'How frequently must a public pool operator test free chlorine and pH levels per MAHC?',
 'Once per day', 'At least every 4 hours when open', 'Once per week', 'Every 2 hours when open',
 'D',
 'MAHC requires that free chlorine and pH be tested at minimum every two hours during operating hours. Many jurisdictions require even more frequent testing during high bather loads.',
 'MAHC 5.7.3.2.1', 2),

-- maintenance
('CPO', 'maintenance',
 'The turnover rate for a public swimming pool is typically:',
 '2 hours', '6 hours', '12 hours', '24 hours',
 'B',
 'Most codes require a 6-hour turnover for public swimming pools, meaning the entire volume of pool water passes through the filtration system once every 6 hours.',
 'ANSI/APSP-1 2014, Section 4.4', 1),

('CPO', 'maintenance',
 'What is the recommended turnover rate for a public spa?',
 '30 minutes', '1 hour', '4 hours', '6 hours',
 'A',
 'Spas require a much faster turnover of 30 minutes due to the small water volume relative to bather load and the higher operating temperatures that promote bacterial growth.',
 'ANSI/APSP-2 2014, Section 5.1', 1),

('CPO', 'maintenance',
 'A pool operator notices a strong chlorine smell around the indoor pool. The free chlorine tests at 2.0 ppm and combined chlorine at 0.8 ppm. What is the correct course of action?',
 'Reduce the chlorine feed rate', 'Superchlorinate to reach breakpoint', 'Add cyanuric acid', 'Drain and refill the pool',
 'B',
 'The strong smell is caused by chloramines (combined chlorine at 0.8 ppm exceeds the 0.2 ppm limit). Superchlorination to breakpoint—adding enough free chlorine to reach 10x the combined chlorine—will destroy the chloramines.',
 'MAHC 4.7.3.1.2', 2),

('CPO', 'codes_standards',
 'Under MAHC, what minimum free chlorine residual is required in a public pool using cyanuric acid?',
 '1 ppm', '2 ppm', '3 ppm', '5 ppm',
 'B',
 'When CYA is present, MAHC requires a minimum free chlorine of 2 ppm to compensate for the reduced disinfection efficacy caused by the chlorine-CYA bond.',
 'MAHC 4.7.3.1.1 Table', 2),

-- heating
('CPO', 'heating',
 'What is the most energy-efficient method for heating an outdoor pool in a moderate climate?',
 'Natural gas heater', 'Electric resistance heater', 'Heat pump', 'Propane heater',
 'C',
 'Heat pumps have a coefficient of performance (COP) of 5.0–6.0, meaning they produce 5–6 units of heat for every unit of electricity consumed. This makes them 300–500% more efficient than electric resistance heaters.',
 'DOE Energy Efficiency Guidelines for Pool Heating', 2),

('CPO', 'heating',
 'A gas pool heater should be inspected for which condition that indicates a cracked heat exchanger?',
 'High stack temperature', 'Soot deposits inside the combustion chamber', 'Water dripping from the exhaust vent', 'Low gas pressure at the manifold',
 'C',
 'Water dripping from the exhaust vent is a telltale sign of a cracked heat exchanger, allowing pool water to leak into the combustion chamber and exit through the flue.',
 'Manufacturer service guidelines; NFPA 54', 2),

('CPO', 'pumps_motors',
 'A variable-speed pump operating at half speed uses what fraction of the energy compared to full speed?',
 '1/2 (50%)', '1/4 (25%)', '1/8 (12.5%)', '1/16 (6.25%)',
 'C',
 'The affinity laws state that power consumption is proportional to the cube of the speed. At half speed: (0.5)³ = 0.125, or 12.5% of full-speed energy consumption.',
 'Hydraulic Institute Pump Standards; DOE Title 20', 3),

('CPO', 'water_chemistry',
 'Total alkalinity in a public pool should be maintained between:',
 '40–60 ppm', '60–120 ppm', '150–200 ppm', '200–300 ppm',
 'B',
 'Total alkalinity should be maintained between 60 and 120 ppm. This range provides adequate pH buffering without contributing to scaling or cloudy water.',
 'ANSI/APSP-11 2009, Section 5.3', 1),

('CPO', 'codes_standards',
 'Per MAHC, which record-keeping duration is required for water quality test logs at a public aquatic facility?',
 '6 months', '1 year', '3 years', '5 years',
 'C',
 'MAHC requires that water quality testing records be maintained for a minimum of three years and be available for review by the local health authority upon request.',
 'MAHC 6.5.2', 2),

('CPO', 'safety',
 'At what wind speed should an outdoor public pool be closed per typical health department guidance?',
 '15 mph sustained', '25 mph sustained', '35 mph sustained or during lightning within 10 miles', '50 mph sustained',
 'C',
 'Most health departments recommend closing outdoor pools when sustained winds exceed 35 mph or when lightning is detected within a 10-mile radius. Wind impairs lifeguard visibility and lightning poses electrocution risk.',
 'MAHC 6.3.6; Local health department regulations', 2),

-- ============================================================
-- CST (Certified Service Technician) — 25 questions
-- ============================================================

-- pumps_motors
('CST', 'pumps_motors',
 'A single-speed pool pump motor draws 12 amps on a 240V circuit. What is its approximate power consumption?',
 '1,440 watts', '2,880 watts', '720 watts', '5,760 watts',
 'B',
 'Power = Voltage × Amps = 240V × 12A = 2,880 watts. For single-phase motors, the power factor may reduce the actual power slightly, but 2,880W is the correct apparent power calculation.',
 'NEC Article 430', 1),

('CST', 'pumps_motors',
 'A pump motor hums but does not start. The capacitor tests good. What is the most likely cause?',
 'Bad run winding', 'Seized impeller or bearings', 'Open centrifugal switch', 'Low voltage from the breaker',
 'B',
 'A humming motor that will not rotate typically indicates a mechanical obstruction. A seized impeller (often from calcium buildup or debris) or frozen bearings prevent the shaft from turning despite the motor being energized.',
 'Motor troubleshooting; NEC Article 430', 2),

('CST', 'pumps_motors',
 'When replacing a pool pump seal, what must be done to the seal faces before installation?',
 'Apply thread sealant tape', 'Clean with alcohol and avoid touching with bare fingers', 'Sand the faces lightly for better grip', 'Apply silicone grease generously on both faces',
 'B',
 'Mechanical seal faces must be perfectly clean and free of oils from skin contact. Fingerprint oils can create microscopic gaps that prevent the seal from seating properly, leading to leaks.',
 'Manufacturer installation guidelines', 1),

('CST', 'pumps_motors',
 'What is the purpose of a check valve on the discharge side of a booster pump for a pressure-side pool cleaner?',
 'To prevent backflow from draining the cleaner hose', 'To regulate flow rate', 'To reduce noise', 'To protect against water hammer',
 'A',
 'The check valve prevents water from flowing backward through the booster pump when it shuts off. Without it, the elevated pressure in the cleaner line would drain back through the pump, potentially losing prime.',
 'Manufacturer installation guidelines', 1),

-- filtration
('CST', 'filtration',
 'After reassembling a DE filter, the recommended initial charge of DE powder per square foot of filter area is:',
 '0.5 lb per 10 ft²', '1 lb per 10 ft²', '2 lb per 10 ft²', '1 lb per 5 ft²',
 'B',
 'The standard DE charge is approximately 1 pound per 10 square feet of filter area. Under-charging leaves grids exposed and allows debris to embed in the fabric; over-charging restricts flow prematurely.',
 'Filter manufacturer specifications; NSF/ANSI 50', 2),

('CST', 'filtration',
 'A cartridge filter shows high starting pressure immediately after cleaning. What is the most likely cause?',
 'Undersized pump', 'Calcified or damaged cartridge that needs replacement', 'Air in the system', 'Clogged skimmer basket',
 'B',
 'If a cartridge filter shows elevated pressure right after cleaning, the pleated media is likely calcified with mineral deposits or the fabric has deteriorated, both of which reduce permeability and require cartridge replacement.',
 'NSF/ANSI 50; Filter manufacturer guidelines', 2),

('CST', 'filtration',
 'What is the consequence of operating a DE filter with a torn grid or element?',
 'Reduced water flow', 'DE powder returns to the pool', 'Increased operating pressure', 'Motor overheating',
 'B',
 'A torn grid allows DE powder to pass through the filter and return to the pool, creating visible white cloudy water and depositing DE on the pool floor. The filter also loses its ability to trap fine particles.',
 'NSF/ANSI 50', 1),

-- heating
('CST', 'heating',
 'A gas pool heater with an electronic ignition clicks repeatedly but does not light. The gas supply is confirmed on. What should be checked first?',
 'The thermostat setting', 'The flame sensor/igniter gap and condition', 'The pump speed', 'The filter pressure',
 'B',
 'Repeated clicking with confirmed gas supply indicates the igniter is sparking but not establishing flame, or the flame sensor cannot detect the flame. Corroded or improperly gapped igniters and dirty flame sensors are the most common causes.',
 'NFPA 54, Section 10.3; Manufacturer service manual', 2),

('CST', 'heating',
 'What is the minimum clearance required between a gas pool heater and a combustible structure per most manufacturer specifications?',
 '6 inches', '12 inches', '24 inches', '36 inches',
 'C',
 'Most manufacturers require a minimum of 24 inches clearance from combustible materials. Local codes may require more. Always consult the specific heater installation manual and local building codes.',
 'NFPA 54, Section 10.3.3; Manufacturer installation guides', 2),

('CST', 'heating',
 'A heat pump pool heater operates most efficiently when the ambient air temperature is above:',
 '35°F', '45°F', '50°F', '60°F',
 'C',
 'Heat pump efficiency drops significantly when ambient air temperature falls below 50°F because there is less heat energy available to extract from the air. Below this temperature, COP drops dramatically and defrost cycles increase.',
 'AHRI Standard 1160', 2),

-- maintenance
('CST', 'maintenance',
 'White scale buildup at the waterline and inside the heater is most commonly caused by:',
 'High CYA levels', 'High calcium hardness combined with high pH', 'Low total alkalinity', 'High TDS alone',
 'B',
 'Calcium carbonate scale forms when calcium hardness is high and pH rises above 7.8. The combination shifts the LSI positive, causing calcium to precipitate out of solution, especially on heated surfaces.',
 'ANSI/APSP-11 2009, Section 7', 2),

('CST', 'maintenance',
 'When winterizing a pool in a freeze zone, which component must have water completely drained to prevent cracking?',
 'The skimmer only', 'The pump, filter, heater, and all plumbing lines', 'The main drain only', 'The automatic chlorinator only',
 'B',
 'All equipment and plumbing must be thoroughly drained or blown out with compressed air. Trapped water in any component—pump housing, filter tank, heater heat exchanger, or plumbing lines—will expand when frozen and crack the component.',
 'APSP Technical Manual; Manufacturer winterization guides', 1),

('CST', 'pumps_motors',
 'What wire gauge is typically required for a 240V, 20-amp pool pump circuit run of 100 feet?',
 '14 AWG', '12 AWG', '10 AWG', '8 AWG',
 'C',
 'At 100 feet on a 240V/20A circuit, 10 AWG copper wire is needed to keep voltage drop under 3%. While 12 AWG is rated for 20 amps, the long run distance requires upsizing to compensate for voltage drop.',
 'NEC Article 210.19(A); NEC Table 310.16', 2),

('CST', 'safety',
 'Pool and spa equipment must be bonded per NEC. What is the minimum size copper bonding conductor required?',
 '12 AWG', '10 AWG', '8 AWG solid', '6 AWG',
 'C',
 'NEC Article 680.26 requires a minimum 8 AWG solid copper conductor for bonding pool equipment, including pumps, heaters, metal ladders, and reinforcing steel within 5 feet of the pool.',
 'NEC Article 680.26(B)', 2),

('CST', 'codes_standards',
 'A salt chlorine generator cell should be inspected and cleaned when calcium buildup is visible. What solution is used for cleaning?',
 '10% bleach solution', '4:1 water to muriatic acid solution', 'Trisodium phosphate solution', 'Vinegar and baking soda paste',
 'B',
 'A 4:1 ratio of water to muriatic acid (approximately 20% HCl solution) is the standard cleaning solution for salt cell calcium deposits. The cell is soaked for 5–15 minutes until the fizzing stops.',
 'Manufacturer maintenance guidelines', 1),

('CST', 'maintenance',
 'An automation system reports a low salt reading but the salt level tests normal with a manual kit. What is the most likely issue?',
 'Bad flow sensor', 'Corroded or scaled salt cell sensor plates', 'Faulty main circuit board', 'Incorrect plumbing bypass setting',
 'B',
 'Scaled or corroded sensor plates inside the salt cell give inaccurate conductivity readings. Cleaning the cell typically resolves the discrepancy between the automation display and manual test results.',
 'Manufacturer troubleshooting guides', 2),

('CST', 'pumps_motors',
 'A variable-speed pump must be programmed to maintain what minimum flow rate through a salt chlorine generator?',
 'The flow rate specified by the salt cell manufacturer, typically 20–30 GPM', 'Any flow above zero', 'Maximum pump speed at all times', 'Flow rate matching the filter design rate',
 'A',
 'Salt chlorine generators require a minimum flow rate (typically 20–30 GPM depending on the model) to operate safely and produce chlorine efficiently. Running below this flow causes overheating of the cell and poor chlorine output.',
 'Manufacturer installation requirements', 2),

('CST', 'safety',
 'According to NEC Article 680, the GFCI protection requirement for a pool pump receptacle is:',
 'Only required for 120V circuits', 'Required for all 120V and 240V single-phase circuits', 'Only required within 6 feet of the pool', 'Not required for permanently wired equipment',
 'B',
 'NEC 680.21(C) requires GFCI protection for all single-phase 120V and 240V pump motor circuits, regardless of whether the pump is cord-connected or permanently wired.',
 'NEC Article 680.21(C)', 2),

('CST', 'codes_standards',
 'What is the minimum required distance from the inside wall of a pool to a receptacle outlet per NEC?',
 '5 feet', '6 feet', '10 feet', '20 feet',
 'B',
 'NEC Article 680.22(A)(1) requires receptacle outlets to be at least 6 feet from the inside wall of a pool. Between 6 and 20 feet, the receptacle must be GFCI protected.',
 'NEC Article 680.22(A)', 1),

('CST', 'maintenance',
 'A pool service technician notices air bubbles consistently entering the pool through the return jets. What is the most systematic first step?',
 'Replace the pump lid O-ring', 'Check the water level and ensure it is above the skimmer weir', 'Replace the pump shaft seal', 'Install a check valve on the suction line',
 'B',
 'Low water level exposing the skimmer throat is the most common cause of air ingestion and should be verified first. Systematic troubleshooting starts with the simplest, most common cause before moving to equipment repairs.',
 'Service technician best practices', 1),

-- ============================================================
-- RESIDENTIAL — 25 questions
-- ============================================================

-- water_chemistry
('RESIDENTIAL', 'water_chemistry',
 'A homeowner tests their pool and finds a free chlorine reading of 0 ppm and a total chlorine reading of 1.5 ppm. What does this indicate?',
 'The test kit is faulty', 'All chlorine is in the form of chloramines', 'The pool has too much CYA', 'The saltwater generator needs a new cell',
 'B',
 'When total chlorine exceeds free chlorine, the difference is combined chlorine (chloramines). A free chlorine of 0 means all available chlorine has reacted with nitrogen compounds and is no longer an effective sanitizer.',
 'Pool Chemistry Fundamentals', 1),

('RESIDENTIAL', 'water_chemistry',
 'A residential pool owner should test the water at minimum:',
 'Once a month', 'Once a week', '2–3 times per week', 'Daily',
 'C',
 'Residential pool owners should test free chlorine and pH 2–3 times per week during swimming season. More frequent testing may be needed after heavy use, rain, or high temperatures.',
 'APSP Residential Pool Care Guidelines', 1),

('RESIDENTIAL', 'water_chemistry',
 'What happens when calcium hardness drops below 150 ppm in a plaster pool?',
 'The water becomes cloudy', 'The water becomes aggressive and etches the plaster surface', 'Algae growth accelerates', 'The filter clogs more frequently',
 'B',
 'Low calcium hardness makes water aggressive (corrosive), and it will attempt to dissolve calcium from the nearest source—the plaster surface. This causes etching, roughening, and premature surface deterioration.',
 'ANSI/APSP-11 2009, Section 5.5', 2),

('RESIDENTIAL', 'water_chemistry',
 'A pool owner adds liquid chlorine (sodium hypochlorite) to their pool. Over time, this raises which water chemistry parameter?',
 'Calcium hardness', 'pH and total dissolved solids', 'Cyanuric acid', 'Iron content',
 'B',
 'Sodium hypochlorite has a pH of approximately 13. Regular use progressively raises pH and contributes sodium to the water, increasing TDS over time.',
 'Pool Chemistry Fundamentals', 2),

-- filtration
('RESIDENTIAL', 'filtration',
 'A homeowner reports their pool pressure gauge reads 0 psi even with the pump running. The most likely cause is:',
 'A perfectly clean filter', 'A clogged or faulty pressure gauge', 'A broken impeller', 'A closed return valve',
 'B',
 'A zero reading with the pump running almost always indicates a stuck or failed pressure gauge. Gauges should be replaced periodically as they are prone to clogging with debris or mineral deposits at the sensing port.',
 'Equipment maintenance fundamentals', 1),

('RESIDENTIAL', 'filtration',
 'How often should a residential cartridge filter element be chemically soaked?',
 'Weekly', 'Monthly', 'Every 3–6 months', 'Only when replacing',
 'C',
 'Cartridge elements should be chemically soaked in a filter cleaning solution every 3–6 months to dissolve oils, minerals, and organic deposits that regular hosing cannot remove. This extends cartridge life to 2–3 years.',
 'Filter manufacturer maintenance guidelines', 1),

-- pumps_motors
('RESIDENTIAL', 'pumps_motors',
 'The DOE Title 20 regulation requires that replacement pool pumps above what horsepower must be variable-speed?',
 '0.5 HP', '1.0 HP', '1.65 THP', '2.0 HP',
 'C',
 'DOE energy conservation standards effective July 2021 require that self-priming pool filter pumps with a total horsepower of 1.65 or greater must be variable-speed to meet the weighted energy factor (WEF) requirements.',
 'DOE 10 CFR 431; Title 20, Section 1605.3', 2),

('RESIDENTIAL', 'pumps_motors',
 'What is the recommended maximum suction pipe velocity for a residential pool pump?',
 '4 feet per second', '6 feet per second', '8 feet per second', '12 feet per second',
 'B',
 'Suction pipe velocity should not exceed 6 fps to prevent cavitation, excessive noise, and air entrainment. On the return side, up to 8–10 fps is acceptable.',
 'ANSI/APSP-1 2014, Section 4.5', 2),

-- heating
('RESIDENTIAL', 'heating',
 'A homeowner wants to extend their swimming season in a temperate climate. Which combination provides the best energy efficiency?',
 'Gas heater alone', 'Heat pump with a solar blanket cover', 'Electric resistance heater with timer', 'Solar panels without a cover',
 'B',
 'A heat pump provides efficient heating (COP 5.0+), and a solar blanket reduces heat loss by up to 70% overnight. This combination minimizes both heating and heat-loss energy costs.',
 'DOE Energy Efficiency Guidelines for Residential Pools', 1),

('RESIDENTIAL', 'heating',
 'What BTU rating gas heater is generally recommended for a 15,000-gallon residential pool?',
 '100,000 BTU', '200,000 BTU', '300,000 BTU', '400,000 BTU',
 'C',
 'A 300,000 BTU heater can raise the temperature of a 15,000-gallon pool approximately 1°F per hour. A 400,000 BTU unit is suitable for pools over 20,000 gallons or for faster heat-up times.',
 'Pool heater sizing guidelines; ASHRAE', 2),

-- safety
('RESIDENTIAL', 'safety',
 'The CPSC recommends which type of fencing around a residential pool?',
 'At least 4 feet high with self-closing, self-latching gate', 'Chain-link at least 3 feet high', 'Any decorative fence with a gate', 'Solid wall at least 6 feet high',
 'A',
 'CPSC guidelines call for a minimum 4-foot-high barrier with a self-closing, self-latching gate that opens outward away from the pool. The latch should be out of reach of young children.',
 'CPSC Pub. 362; ANSI/APSP-7 2013', 1),

('RESIDENTIAL', 'safety',
 'According to ANSI/APSP-7, the maximum gap at the bottom of a pool fence should not exceed:',
 '2 inches', '4 inches', '6 inches', '8 inches',
 'B',
 'The gap between the bottom of the fence and the ground must not exceed 4 inches to prevent children from crawling under the barrier.',
 'ANSI/APSP-7 2013, Section 4.4', 1),

('RESIDENTIAL', 'safety',
 'A residential pool cover must support how much weight to be considered a safety cover per ASTM F1346?',
 'A child weighing 30 lbs', 'An adult weighing 200 lbs', 'A rescue worker and equipment weighing 485 lbs', 'A vehicle weighing 2000 lbs',
 'C',
 'ASTM F1346 requires safety covers to support a minimum weight of 485 lbs to allow a rescue worker with equipment to walk on the cover to rescue a person who may have fallen onto it.',
 'ASTM F1346-91', 2),

-- maintenance
('RESIDENTIAL', 'maintenance',
 'Green water with zero chlorine reading in a residential pool is best treated by:',
 'Adding algaecide only', 'Triple shocking with liquid chlorine, brushing walls, and running the filter 24/7', 'Draining and refilling', 'Adding flocculant and vacuuming',
 'B',
 'Severe algae blooms require aggressive shocking (3x normal dose), thorough brushing to break algae off surfaces, and continuous filtration until the water clears. Algaecide alone cannot overcome a zero-chlorine bloom.',
 'Pool maintenance best practices', 1),

('RESIDENTIAL', 'maintenance',
 'A salt chlorine generator displays "Check Salt." The salt level tests at 3,200 ppm, which is within range. What should be investigated?',
 'The cell needs cleaning', 'The flow switch or flow sensor', 'The main circuit board is bad', 'The salt is the wrong brand',
 'B',
 'When salt levels are correct but the system shows an error, the flow switch/sensor is a common culprit. Insufficient detected flow prevents the cell from generating chlorine as a safety measure.',
 'Manufacturer troubleshooting guide', 2),

('RESIDENTIAL', 'maintenance',
 'Phosphates in pool water primarily contribute to:',
 'Metal staining', 'Algae growth by providing a nutrient source', 'Scale formation', 'Chloramine production',
 'B',
 'Phosphates are a nutrient source for algae. While adequate chlorine levels can still prevent algae growth in the presence of phosphates, elevated phosphate levels make algae control more difficult.',
 'Pool water chemistry literature', 1),

('RESIDENTIAL', 'codes_standards',
 'In most jurisdictions, a residential pool electrical installation requires a permit and inspection for:',
 'Only the pump circuit', 'All pool-related electrical work including pumps, heaters, lights, and bonding', 'Only underwater lighting', 'Only 240V circuits',
 'B',
 'All pool-related electrical work requires permits and inspections because of the unique safety hazards of electricity near water. This includes bonding, grounding, GFCI protection, and all equipment circuits.',
 'NEC Article 680; Local building codes', 1),

('RESIDENTIAL', 'pumps_motors',
 'A homeowner notices their variable-speed pump makes a high-pitched whine at low speed. What is the most likely cause?',
 'Cavitation from insufficient water supply', 'Normal inverter drive noise', 'A failing capacitor', 'Loose mounting bolts',
 'A',
 'At low speeds the pump may not generate enough suction to maintain full prime, especially if there are suction restrictions. Cavitation produces a high-pitched whine as water vaporizes and collapses at the impeller.',
 'Pump manufacturer troubleshooting', 2),

('RESIDENTIAL', 'water_chemistry',
 'After heavy rain, a pool owner should test and likely adjust:',
 'Calcium hardness and CYA only', 'pH, alkalinity, and chlorine levels', 'Salt level only', 'Copper and iron levels',
 'B',
 'Rainwater is acidic (pH ~5.5) and contains no sanitizer. Heavy rain dilutes chlorine, lowers pH, and reduces alkalinity. These three parameters should be tested and corrected first.',
 'Pool maintenance fundamentals', 1),

('RESIDENTIAL', 'heating',
 'What is the primary advantage of a pool solar blanket beyond heating?',
 'It prevents algae growth', 'It reduces chemical consumption by reducing evaporation', 'It improves filtration efficiency', 'It extends equipment life',
 'B',
 'A solar blanket reduces evaporation by up to 95%. Since evaporation is the primary source of chemical loss (especially chlorine) and heat loss, a cover significantly reduces chemical consumption.',
 'DOE Swimming Pool Heating Guidelines', 1),

('RESIDENTIAL', 'filtration',
 'A multiport valve on a sand filter has which position used for lowering the water level?',
 'Backwash', 'Rinse', 'Waste', 'Recirculate',
 'C',
 'The Waste position bypasses the filter and sends water directly to the drain/waste line. This is used to lower water level, vacuum heavy debris directly out, or drain the pool.',
 'Filter equipment operation manuals', 1),

('RESIDENTIAL', 'safety',
 'A GFCI outlet near the pool keeps tripping. After verifying no moisture in the receptacle box, what should be checked next?',
 'Replace the GFCI with a standard outlet', 'Check for a ground fault in the downstream wiring or connected equipment', 'Install a higher-amp breaker', 'Bypass the GFCI with a jumper',
 'B',
 'Persistent GFCI tripping with a dry receptacle box indicates a ground fault somewhere in the circuit—either in the downstream wiring, a connected device, or deteriorated insulation. Never bypass or replace a GFCI with a standard outlet near a pool.',
 'NEC Article 680; Electrical troubleshooting fundamentals', 2),

-- ============================================================
-- COMMERCIAL — 20 questions
-- ============================================================

-- water_chemistry
('COMMERCIAL', 'water_chemistry',
 'A commercial aquatic facility uses a secondary disinfection system. Which technology provides both oxidation and disinfection without chemical residual?',
 'Calcium hypochlorite feed', 'UV-C irradiation', 'Ozone injection', 'Bromine tablets',
 'C',
 'Ozone is a powerful oxidizer and disinfectant but has no lasting residual in the water. It destroys chloramines and pathogens on contact in the treatment loop but a primary disinfectant (chlorine) is still required for residual protection in the pool.',
 'MAHC 4.7.3.3', 2),

('COMMERCIAL', 'water_chemistry',
 'In a commercial facility, the ORP (oxidation-reduction potential) reading that indicates adequate disinfection is:',
 '400–500 mV', '550–650 mV', '650–750 mV or higher', '800–900 mV',
 'C',
 'An ORP of 650 mV or higher indicates that the water has sufficient oxidizing power for effective disinfection. Many health departments accept ORP as a supplemental monitoring tool but still require chemical residual testing.',
 'MAHC 4.7.3.2.2; WHO Guidelines for Safe Recreational Water', 2),

('COMMERCIAL', 'water_chemistry',
 'A commercial pool operator notices a persistent haze despite adequate chlorine and proper filtration. What water chemistry parameter should be investigated?',
 'pH', 'Total dissolved solids (TDS)', 'Calcium hardness', 'Cyanuric acid',
 'B',
 'Elevated TDS (above 1500 ppm over source water) can cause persistent haziness that filtration cannot resolve. The dissolved minerals scatter light. Partial drain and refill is the only practical remedy for high TDS.',
 'ANSI/APSP-11 2009, Section 5.9', 3),

-- filtration
('COMMERCIAL', 'filtration',
 'A commercial pool using a regenerative media filter (perlite) offers what advantage over conventional DE?',
 'Lower initial cost', 'The media can be reused after backwashing by "bumping" the filter', 'Higher filtration rate', 'No chemical disposal requirements',
 'B',
 'Regenerative media filters allow the perlite coating to be dislodged and redistributed ("bumped") rather than backwashed to waste, conserving water and extending media life.',
 'NSF/ANSI 50; Filter manufacturer specifications', 2),

('COMMERCIAL', 'filtration',
 'What is the maximum turbidity reading allowed in a public pool per MAHC?',
 '0.5 NTU', '1.0 NTU', '2.0 NTU', '5.0 NTU',
 'A',
 'MAHC requires pool water turbidity to not exceed 0.5 NTU. Additionally, the main drain must be clearly visible from the pool deck at all times for safety reasons.',
 'MAHC 4.7.3.4.1', 2),

-- codes_standards
('COMMERCIAL', 'codes_standards',
 'MAHC requires a minimum of how many lifeguard stations for a pool with 4,000 square feet of water surface?',
 '1', '2', '3', '4',
 'B',
 'MAHC provides guidelines based on pool area, configuration, and sight lines. A 4,000 sq ft pool typically requires a minimum of 2 lifeguard stations to ensure full visual coverage of the water surface.',
 'MAHC 6.3.1; Lifeguard zone coverage tables', 2),

('COMMERCIAL', 'codes_standards',
 'Per MAHC, an emergency action plan (EAP) for an aquatic facility must include:',
 'Only drowning response procedures', 'Drowning, spinal injury, chemical spill, weather emergency, and facility evacuation procedures', 'Only chemical spill response', 'Only severe weather procedures',
 'B',
 'MAHC requires comprehensive EAPs covering all reasonably foreseeable emergencies including drowning, spinal injuries, chemical exposures, severe weather, power outages, and full facility evacuation.',
 'MAHC 6.3.5', 1),

('COMMERCIAL', 'codes_standards',
 'ADA requires that at least one means of accessible pool entry be provided. For pools with more than 300 linear feet of pool wall, how many accessible means of entry are required?',
 '1', '2', '3', '4',
 'B',
 'Pools with more than 300 linear feet of pool wall must have at least two accessible means of entry, with at least one being a pool lift or sloped entry.',
 'ADA Standards for Accessible Design, Section 242.2', 2),

-- safety
('COMMERCIAL', 'safety',
 'A commercial facility stores bulk liquid chlorine (sodium hypochlorite 12.5%). Per NFPA 400, the storage area must have:',
 'Standard ventilation only', 'Secondary containment capable of holding 110% of the largest container', 'A fire suppression sprinkler system', 'Temperature-controlled refrigeration',
 'B',
 'NFPA 400 and most building codes require secondary containment (110% of the largest container volume) for bulk chemical storage to prevent environmental contamination from leaks or spills.',
 'NFPA 400, Chapter 14; MAHC 5.8.4', 2),

('COMMERCIAL', 'safety',
 'When mixing sodium hypochlorite and muriatic acid accidentally, what hazardous gas is produced?',
 'Carbon monoxide', 'Chlorine gas', 'Hydrogen sulfide', 'Ammonia',
 'B',
 'Mixing an oxidizer (sodium hypochlorite) with an acid (muriatic acid/HCl) produces toxic chlorine gas, which is immediately dangerous to life and health (IDLH) at 10 ppm. Chemical storage areas must separate oxidizers from acids.',
 'OSHA 29 CFR 1910.106; MAHC 5.8.4', 1),

('COMMERCIAL', 'safety',
 'OSHA requires that Safety Data Sheets (SDS) for all pool chemicals be:',
 'Filed with the local fire department only', 'Available within the facility and accessible to all employees who handle chemicals', 'Posted on the exterior of the building', 'Kept only in the corporate office',
 'B',
 'OSHA Hazard Communication Standard requires SDS to be readily accessible to all employees during their work shifts. For pool facilities, this means SDS must be available in or near the chemical storage and handling areas.',
 'OSHA 29 CFR 1910.1200(g)', 1),

('COMMERCIAL', 'safety',
 'A dual-drain system for a commercial pool main drain is required to be spaced at least how far apart?',
 '12 inches', '24 inches', '36 inches or 3 feet', 'Distance equal to the diagonal of one drain cover',
 'C',
 'Dual main drains must be spaced at least 36 inches apart (measuring center to center) or a distance sufficient to prevent simultaneous blockage by a single person. This spacing ensures that if one drain is blocked, the other remains fully functional.',
 'VGB Act; ANSI/APSP-7 2013; ASME A112.19.8', 2),

-- pumps_motors
('COMMERCIAL', 'pumps_motors',
 'A commercial pool requires 500 GPM flow for proper turnover. What is the minimum pipe diameter for the main suction line to keep velocity below 6 fps?',
 '3 inches', '4 inches', '6 inches', '8 inches',
 'C',
 'Using the flow velocity formula: Area = Flow / Velocity. At 500 GPM (1.11 cfs) and 6 fps max, the minimum pipe area is 0.185 ft² = 26.7 in², which corresponds to a 6-inch pipe (internal area ~28.3 in²).',
 'Hydraulic design principles; ANSI/APSP-1 2014', 3),

('COMMERCIAL', 'pumps_motors',
 'A commercial facility has two circulation pumps operating in parallel. If one pump fails, what happens to the system flow?',
 'Flow drops to exactly 50%', 'Flow drops to approximately 60–70% of dual-pump flow', 'Flow drops to zero', 'Flow stays the same',
 'B',
 'With parallel pumps sharing a common piping system, the remaining pump operates at a different point on its curve due to reduced system friction. The single pump typically delivers 60–70% of the total dual-pump flow, not exactly 50%.',
 'Hydraulic Institute Parallel Pump Operation Guidelines', 3),

-- maintenance
('COMMERCIAL', 'maintenance',
 'A commercial aquatic facility is required to maintain a daily operations log. Per MAHC, which parameters must be recorded?',
 'Only free chlorine and pH', 'Free chlorine, combined chlorine, pH, temperature, and bather load', 'Only flow rate and filter pressure', 'Only chemical additions',
 'B',
 'MAHC requires recording free chlorine, combined chlorine, pH, water temperature, bather load, and any chemical adjustments. Additional parameters may be required based on the disinfection system used.',
 'MAHC 5.7.3.2', 1),

('COMMERCIAL', 'maintenance',
 'A commercial pool chemical controller shows a pH reading that drifts significantly from manual test results. The probe was recently replaced. What is the most likely issue?',
 'The controller is defective', 'The pH probe was not properly calibrated with fresh buffer solutions', 'The water temperature is too high', 'The flow cell needs to be upsized',
 'B',
 'New pH probes must be calibrated with fresh pH 7.0 and pH 4.0 (or 10.0) buffer solutions. Expired or contaminated buffers cause calibration offset, leading to drift between controller readings and manual tests.',
 'Chemical controller manufacturer guidelines; MAHC 5.7.3.1', 2),

('COMMERCIAL', 'codes_standards',
 'Per the International Building Code (IBC), a public pool must have a recirculation system capable of providing a turnover rate that meets or exceeds local health code requirements, but what is the IBC minimum for a competition pool?',
 '4 hours', '6 hours', '8 hours', '12 hours',
 'B',
 'The IBC defers to ANSI/APSP standards and local health codes, which typically require a 6-hour turnover for competition pools. Wading pools and spas require faster turnovers.',
 'IBC Section 3109; ANSI/APSP-1 2014, Section 4.4', 2),

('COMMERCIAL', 'maintenance',
 'What is the primary reason a commercial pool facility should maintain a preventive maintenance schedule for all mechanical equipment?',
 'To satisfy insurance requirements only', 'To minimize unplanned downtime, extend equipment life, and ensure code compliance', 'To reduce chemical costs', 'To improve water clarity',
 'B',
 'Preventive maintenance reduces unplanned equipment failures (minimizing pool closures and revenue loss), extends the service life of expensive commercial equipment, and ensures ongoing compliance with health and safety codes.',
 'MAHC 5.6; Facility management best practices', 1),

('COMMERCIAL', 'heating',
 'A commercial indoor pool facility is experiencing excessive condensation and corrosion on metal structural members. What is the primary solution?',
 'Lower the pool temperature', 'Maintain the natatorium air temperature 2–4°F above the pool water temperature with proper dehumidification', 'Increase ventilation with outside air only', 'Apply anti-corrosion coatings to all metal',
 'B',
 'The ASHRAE guideline for indoor pools is to maintain air temperature 2–4°F above water temperature and use a dehumidification system designed for natatoriums. This reduces evaporation rates and prevents condensation on cooler surfaces.',
 'ASHRAE Applications Handbook, Chapter 5: Places of Assembly', 2),

('COMMERCIAL', 'safety',
 'Per MAHC, a fecal contamination incident in a public pool involving formed stool requires the pool to be closed and hyperchlorinated to what free chlorine level for what duration?',
 '2 ppm for 30 minutes', '10 ppm for 30 minutes', '20 ppm for 12.75 hours', '20 ppm for 8 hours at pH 7.5 or lower',
 'D',
 'For formed stool incidents, MAHC requires raising free chlorine to 20 ppm at pH 7.5 or lower and maintaining it for 8 hours. This CT value is necessary to inactivate Cryptosporidium, which is highly resistant to chlorine.',
 'MAHC 4.7.3.5.2 Table; CDC Fecal Incident Response', 3);
