-- Seed LiftPal training modules & questions (elevator/lift)
-- Cert levels: CET, QEI, CAT
-- 4 modules per level = 12 modules, 10 questions per module = 120 questions

INSERT INTO liftpal.training_modules (cert_level, module_number, title, topic_list, estimated_minutes, exam_domain_weight, is_published) VALUES
-- CET (Certified Elevator Technician)
('CET', 1, 'Elevator Fundamentals', ARRAY['Traction vs hydraulic elevators','Car and counterweight systems','Door operator types','Hoistway components','Elevator classifications'], 50, 0.30, true),
('CET', 2, 'Electrical Systems', ARRAY['Motor types','Controllers','Safety circuits','Wiring methods','Power supply requirements'], 55, 0.25, true),
('CET', 3, 'Mechanical Systems', ARRAY['Wire ropes and sheaves','Guide rails and shoes','Buffers and governors','Machine room equipment','Compensation systems'], 55, 0.25, true),
('CET', 4, 'Safety Procedures', ARRAY['Lockout/tagout','Pit safety','Top of car operations','Hoistway entry','Emergency evacuation'], 45, 0.20, true),
-- QEI (Qualified Elevator Inspector)
('QEI', 1, 'Inspection Codes & Standards', ARRAY['ASME A17.1/CSA B44','ASME A17.2 inspection guide','Local jurisdiction requirements','Code edition applicability','Variance procedures'], 65, 0.30, true),
('QEI', 2, 'Testing Procedures', ARRAY['Category 1 testing','Category 5 testing','Annual testing requirements','Load testing','Firefighter service testing'], 60, 0.25, true),
('QEI', 3, 'Documentation & Reporting', ARRAY['Inspection reports','Violation categories','Correction timelines','Record keeping','Witnessing tests'], 50, 0.20, true),
('QEI', 4, 'Hydraulic Systems', ARRAY['Jack types','Hydraulic fluids','Pressure relief valves','Underground cylinders','Hydraulic machine rooms'], 55, 0.25, true),
-- CAT (Certified Accessibility Technician)
('CAT', 1, 'ADA Accessibility', ARRAY['ADA elevator requirements','Car size requirements','Door timing','Hall call placement','Reach range requirements'], 55, 0.30, true),
('CAT', 2, 'Signage & Controls', ARRAY['Braille requirements','Tactile buttons','Audible signals','Car position indicators','Emergency communication'], 50, 0.25, true),
('CAT', 3, 'Emergency Systems', ARRAY['Emergency lighting','Emergency communication devices','Battery backup','Two-way communication','ADA emergency requirements'], 50, 0.25, true),
('CAT', 4, 'Modernization', ARRAY['Upgrade planning','Code compliance for modernization','Destination dispatch','Energy efficiency','Machine-room-less elevators'], 55, 0.20, true);

WITH m AS (SELECT id, cert_level, module_number FROM liftpal.training_modules)
INSERT INTO liftpal.training_questions (module_id, cert_level, topic, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, standard_reference, difficulty) VALUES

-- ============================================================
-- CET Module 1: Elevator Fundamentals (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CET' AND module_number=1 LIMIT 1), 'CET', 'Traction vs hydraulic elevators',
 'A gearless traction elevator is most commonly used in:',
 'Low-rise buildings (2-4 floors)', 'Mid-rise and high-rise buildings with speeds above 500 fpm', 'Freight-only applications', 'Residential dumbwaiters',
 'B', 'Gearless traction machines are used for mid-rise and high-rise applications where higher speeds (500+ fpm) and longer travel distances are required.', 'ASME A17.1 Section 2.1', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=1 LIMIT 1), 'CET', 'Car and counterweight systems',
 'The counterweight in a traction elevator is typically set to balance:',
 'The full car weight only', 'The car weight plus 40-50% of the rated load capacity', 'Twice the rated load', 'The car weight only with no load consideration',
 'B', 'The counterweight balances the car weight plus approximately 40-50% of the rated load, minimizing the motor work required for the most common loading conditions.', 'ASME A17.1 Section 2.16', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=1 LIMIT 1), 'CET', 'Door operator types',
 'A center-opening elevator door differs from a side-opening door in that:',
 'It uses a single panel sliding to one side', 'Two panels open simultaneously from the center in opposite directions', 'It swings outward like a hinged door', 'It slides vertically upward',
 'B', 'Center-opening doors have two panels that part from the center, providing a wider opening for the same wall pocket depth and faster operation than single-slide doors.', 'ASME A17.1 Section 2.11', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=1 LIMIT 1), 'CET', 'Hoistway components',
 'Guide rails in an elevator hoistway serve to:',
 'Support the weight of the car', 'Guide the car and counterweight vertically and support safety device forces during an emergency stop', 'Carry electrical wiring', 'Provide fireproofing',
 'B', 'Guide rails provide vertical guidance for the car and counterweight and must withstand the significant forces generated by the safety device during an emergency stop.', 'ASME A17.1 Section 2.3', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=1 LIMIT 1), 'CET', 'Elevator classifications',
 'A Class A elevator is designed for:',
 'General freight loading by hand', 'Passenger service', 'Automobile loading', 'Industrial heavy freight with powered trucks',
 'B', 'ASME A17.1 classifies elevators: Class A is passenger service, Class B is general freight (hand loaded), Class C1-C3 are for industrial/automobile freight.', 'ASME A17.1 Section 2.16', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=1 LIMIT 1), 'CET', 'Traction vs hydraulic elevators',
 'A hydraulic elevator is limited in rise because:',
 'Hydraulic fluid is unavailable in tall buildings', 'The cylinder length and oil column pressure make travels above approximately 60-70 feet impractical', 'Building codes prohibit them above 3 floors', 'The motor is too large',
 'B', 'Hydraulic elevators are practically limited to about 60-70 feet of travel because of the cylinder length required, oil column pressure limitations, and energy efficiency at greater heights.', 'ASME A17.1 Section 3.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=1 LIMIT 1), 'CET', 'Car and counterweight systems',
 'If the hoist ropes in a traction elevator were to lose traction on the sheave, the result would be:',
 'Normal operation continues', 'The car would slip on the sheave, requiring safety devices to stop it', 'The motor would automatically reverse', 'Nothing, the brake holds the car',
 'B', 'Loss of traction allows rope slippage. The governor and safety device system provides the backup protection to grip the rails and stop the car.', 'ASME A17.1 Section 2.19', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=1 LIMIT 1), 'CET', 'Door operator types',
 'The door restrictor (car door interlock) prevents the car doors from opening:',
 'When the car is at a landing', 'When the car is more than 18 inches from a landing', 'During power outages', 'When the car is empty',
 'B', 'The car door restrictor prevents opening of car doors when the car is more than 18 inches above or below a landing, preventing passengers from falling into the hoistway.', 'ASME A17.1 Section 2.12.5', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=1 LIMIT 1), 'CET', 'Hoistway components',
 'The traveling cable in an elevator hoistway carries:',
 'Only power to the car motor', 'Electrical signals, power for car lighting, door operation, communication, and safety circuits between the car and machine room', 'Only the car weight sensor', 'No electrical connections',
 'B', 'The traveling cable is a multi-conductor flexible cable that provides all electrical connections between the car and the controller, including lighting, signals, door operator, and safety circuits.', 'ASME A17.1 Section 2.8', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=1 LIMIT 1), 'CET', 'Elevator classifications',
 'A dumbwaiter differs from a freight elevator in that:',
 'It carries passengers', 'It has a car floor area not exceeding 9 square feet and is not designed for passenger use', 'It has a higher weight capacity', 'It travels faster',
 'B', 'A dumbwaiter has a maximum car floor area of 9 square feet, maximum height of 4 feet, and maximum capacity of 500 lbs. It must not be used to carry passengers.', 'ASME A17.1 Section 6.1', 'easy'),

-- ============================================================
-- CET Module 2: Electrical Systems (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CET' AND module_number=2 LIMIT 1), 'CET', 'Motor types',
 'A permanent magnet synchronous motor (PMSM) is increasingly used in gearless traction elevators because it:',
 'Is the cheapest option', 'Provides high efficiency, compact size, and precise speed control without a gearbox', 'Requires no power supply', 'Only works with hydraulic systems',
 'B', 'PMSM machines are compact, highly efficient (95%+), and provide excellent low-speed torque, making them ideal for gearless machine-room-less (MRL) elevator designs.', 'ASME A17.1 Section 2.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=2 LIMIT 1), 'CET', 'Controllers',
 'A VVVF elevator drive stands for:',
 'Variable Voltage Variable Frequency', 'Very Versatile Vertical Function', 'Voltage Verified Frequency Fixed', 'Variable Velocity Vector Field',
 'A', 'Variable Voltage Variable Frequency (VVVF) drives control motor speed by adjusting both voltage and frequency, providing smooth acceleration and precise speed control.', 'Elevator Technology Reference', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=2 LIMIT 1), 'CET', 'Safety circuits',
 'The elevator safety circuit is a series-connected chain of safety switches that:',
 'Controls door opening speed', 'Must all be closed (complete) for the elevator to run; any open switch stops the elevator', 'Only monitors car position', 'Is optional in modern elevators',
 'B', 'The safety circuit connects all safety devices in series. Opening any single device (governor switch, pit switch, door interlock, etc.) breaks the circuit and stops the elevator.', 'ASME A17.1 Section 2.26', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=2 LIMIT 1), 'CET', 'Wiring methods',
 'Elevator hoistway wiring must be installed in:',
 'Any convenient manner', 'Metal raceways, rigid conduit, or approved wiring methods as specified by the electrical code', 'PVC conduit only', 'Open wiring without protection',
 'B', 'The NEC (Article 620) and ASME A17.1 require elevator wiring in the hoistway to be in rigid metal conduit, EMT, or other approved raceways for physical protection.', 'NEC Article 620 / ASME A17.1 Section 2.8', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=2 LIMIT 1), 'CET', 'Power supply requirements',
 'An elevator machine room must have a dedicated disconnect switch that is:',
 'Located inside the elevator car', 'Lockable in the open position and accessible within sight of the machine', 'Located on the roof', 'Controlled remotely only',
 'B', 'NEC 620.51 requires a lockable disconnect switch in the machine room within sight of the motor controller, enabling safe LOTO during maintenance.', 'NEC 620.51', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=2 LIMIT 1), 'CET', 'Motor types',
 'Regenerative drives in traction elevators recover energy when:',
 'The elevator is idle', 'The car descends with a heavy load or ascends with a light load (counterweight descending)', 'The doors open', 'During emergency stops only',
 'B', 'Regenerative drives feed energy back to the building power system when the motor acts as a generator — typically during heavy-load descent or light-load ascent.', 'ASME A17.1 / Energy Standards', 'hard'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=2 LIMIT 1), 'CET', 'Controllers',
 'The elevator controller determines floor position using:',
 'Only manual floor selectors', 'Position encoders, selectors, or landing switches that track car location in the hoistway', 'Passenger button presses only', 'Time-based calculations',
 'B', 'Modern controllers use absolute or incremental position encoders on the machine, supplemented by landing magnets/switches for precise floor-level positioning.', 'ASME A17.1 Section 2.26', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=2 LIMIT 1), 'CET', 'Safety circuits',
 'The governor switch in the safety circuit opens when:',
 'The car moves too slowly', 'The car speed exceeds a preset overspeed limit', 'A passenger presses the alarm button', 'The doors are open',
 'B', 'The governor monitors car speed. When overspeed is detected, the governor switch opens the safety circuit (removing power) and mechanically triggers the safety device on the car.', 'ASME A17.1 Section 2.18', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=2 LIMIT 1), 'CET', 'Wiring methods',
 'The traveling cable must be supported to prevent:',
 'Only electrical interference', 'Excessive stress on connections and cable damage from swinging or rubbing in the hoistway', 'Water entry', 'UV degradation',
 'B', 'Traveling cable must be properly supported and guided to prevent contact with hoistway equipment, excessive bending, and strain on terminal connections during car travel.', 'NEC 620.41 / ASME A17.1 Section 2.8', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=2 LIMIT 1), 'CET', 'Power supply requirements',
 'Emergency (standby) power for elevators must be capable of:',
 'Running all elevators simultaneously at full speed', 'Operating at least one elevator at a time to the nearest landing for evacuation', 'Only powering the car lights', 'Running the elevator at double speed',
 'B', 'Standby power must operate at least one elevator to allow orderly evacuation. The system typically sequences elevators one at a time to the nearest landing.', 'ASME A17.1 Section 2.27 / IBC 3003', 'medium'),

-- ============================================================
-- CET Module 3: Mechanical Systems (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CET' AND module_number=3 LIMIT 1), 'CET', 'Wire ropes and sheaves',
 'Elevator wire ropes must be replaced when they show:',
 'Any surface rust', 'Broken wires exceeding code limits, excessive wear, corrosion, or rope diameter reduction beyond 6%', 'Only if they snap', 'Minor surface scratches',
 'B', 'ASME A17.1 Section 8.6 specifies replacement criteria including broken wire count per lay, valley breaks, diameter reduction beyond 6%, and evidence of corrosion or distortion.', 'ASME A17.1 Section 8.6', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=3 LIMIT 1), 'CET', 'Guide rails and shoes',
 'Roller guides are preferred over sliding guide shoes in high-speed elevators because they:',
 'Are cheaper', 'Provide smoother ride quality with less friction and noise at high speeds', 'Require no maintenance', 'Weigh less',
 'B', 'Roller guides use polyurethane rollers that ride on the rail face, providing superior ride quality, lower friction, and reduced noise compared to sliding shoes at high speeds.', 'ASME A17.1 Section 2.3', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=3 LIMIT 1), 'CET', 'Buffers and governors',
 'The oil buffer at the bottom of an elevator hoistway serves to:',
 'Lubricate the pit floor', 'Decelerate and stop the car or counterweight in a controlled manner if it overruns the bottom terminal', 'Support the car weight during normal operation', 'Absorb vibration from the machine',
 'B', 'Oil buffers provide a controlled deceleration force by compressing hydraulic fluid through an orifice, bringing the car to a gradual stop if it overruns the lower terminal.', 'ASME A17.1 Section 2.22', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=3 LIMIT 1), 'CET', 'Machine room equipment',
 'The elevator machine brake is designed to hold:',
 'Only the empty car', 'The car with 125% of rated load at the point of contact', 'The counterweight only', 'Only during power outages',
 'B', 'The machine brake must be capable of holding the car with 125% of rated load capacity. It is a friction brake that engages when power is removed (fail-safe).', 'ASME A17.1 Section 2.24', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=3 LIMIT 1), 'CET', 'Compensation systems',
 'Compensating chains or ropes are used in high-rise traction elevators to:',
 'Add decorative elements', 'Equalize the weight of the hoist ropes as the car travels, maintaining consistent traction', 'Increase car speed', 'Carry electrical signals',
 'B', 'As the car rises, more hoist rope hangs on the counterweight side. Compensating ropes/chains balance this varying rope weight to maintain consistent sheave traction.', 'ASME A17.1 Section 2.16', 'hard'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=3 LIMIT 1), 'CET', 'Wire ropes and sheaves',
 'The minimum number of hoist ropes required for a traction elevator is:',
 '1', '2', '3', '6',
 'C', 'ASME A17.1 requires a minimum of 3 hoist ropes for traction elevators, with each individual rope capable of supporting the car and rated load with a safety factor.', 'ASME A17.1 Section 2.20', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=3 LIMIT 1), 'CET', 'Guide rails and shoes',
 'Guide rail alignment is critical because misalignment causes:',
 'No noticeable effect', 'Rough ride quality, accelerated guide shoe/roller wear, and potential safety device malfunction', 'Only cosmetic issues', 'Increased elevator speed',
 'B', 'Misaligned rails cause vibration, noise, uneven wear on guides, and can affect safety device engagement. Rail alignment is checked during installation and periodic inspections.', 'ASME A17.2 Inspection Guide', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=3 LIMIT 1), 'CET', 'Buffers and governors',
 'The governor on a traction elevator triggers the safety device at:',
 'Normal operating speed', 'A speed exceeding 115% of rated speed (tripping speed varies by governor type)', 'Only when the car is at the top floor', 'When passengers press the emergency button',
 'B', 'The governor is calibrated to trip at a speed exceeding rated speed (typically 115% for Type B safeties). When tripped, it mechanically activates the car safety device to grip the rails.', 'ASME A17.1 Section 2.18', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=3 LIMIT 1), 'CET', 'Machine room equipment',
 'Machine room temperature must be maintained because:',
 'It only affects worker comfort', 'Excessive heat degrades controller electronics, motor insulation, and lubricant life', 'Cold temperatures improve performance', 'Temperature has no effect on equipment',
 'B', 'ASME A17.1 requires machine room temperatures not exceeding 104°F (40°C). Excessive heat shortens electronic component life, degrades insulation, and thins lubricants.', 'ASME A17.1 Section 2.7', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=3 LIMIT 1), 'CET', 'Compensation systems',
 'A compensation sheave at the bottom of the hoistway must have a switch that stops the elevator if:',
 'The sheave rotates', 'The sheave displaces from its normal position, indicating a compensation rope/chain issue', 'The car reaches the top floor', 'The pit floods',
 'B', 'A compensation sheave switch monitors the sheave position. Abnormal displacement indicates a broken or jumped compensation rope, requiring the elevator to stop.', 'ASME A17.1 Section 2.16', 'hard'),

-- ============================================================
-- CET Module 4: Safety Procedures (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CET' AND module_number=4 LIMIT 1), 'CET', 'Lockout/tagout',
 'Before performing maintenance on an elevator, the technician must:',
 'Simply press the stop button in the car', 'Apply LOTO on the mainline disconnect, car top inspection station, and pit stop switch, and verify zero energy', 'Only notify the building manager', 'Close the machine room door',
 'B', 'Proper elevator LOTO requires locking out the mainline disconnect, placing the car on inspection operation, and engaging pit stop switches. Zero energy must be verified.', 'OSHA 1910.147 / ASME A17.1', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=4 LIMIT 1), 'CET', 'Pit safety',
 'Before entering the elevator pit, the technician must:',
 'Jump down from the lowest landing', 'Place the elevator on inspection operation, activate the pit stop switch, and ensure the pit is safe and free of water', 'Enter while the elevator is running', 'Only have someone watching from above',
 'B', 'Pit entry requires: car on inspection operation at the lowest landing, pit stop switch activated (preventing normal car movement), pit ladder used for access, and verification of safe conditions.', 'ASME A17.1 Section 2.2 / ASME A17.2', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=4 LIMIT 1), 'CET', 'Top of car operations',
 'When operating the elevator from the car top inspection station:',
 'The car runs at normal speed', 'The car moves at reduced inspection speed only while the enable switch and direction button are held simultaneously', 'Normal hall calls remain active', 'The doors operate normally',
 'B', 'Inspection operation limits car speed (typically 75-150 fpm), requires constant pressure on the run button, and cancels all automatic dispatching and hall calls.', 'ASME A17.1 Section 2.26.1.4', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=4 LIMIT 1), 'CET', 'Hoistway entry',
 'A technician may enter the hoistway from a landing door only when:',
 'Any time the door can be opened', 'The car is at that landing on inspection operation, or proper barriers and LOTO are in place', 'The car is on another floor', 'The building is unoccupied',
 'B', 'Hoistway access from a landing requires the car at that landing on inspection, or the car locked out with the hoistway protected by barriers to prevent falls.', 'ASME A17.1 / OSHA', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=4 LIMIT 1), 'CET', 'Emergency evacuation',
 'To evacuate passengers from a stalled traction elevator, the trained responder must:',
 'Pry the car doors open', 'Use the emergency hand-crank or release the brake to move the car to the nearest landing, then open the doors', 'Call the fire department and wait in all cases', 'Cut the hoist ropes',
 'B', 'Trained building personnel can perform a manual elevator evacuation by releasing the brake momentarily (allowing the counterweight to move the car) or using the hand wheel to position the car at a landing.', 'ASME A17.1 Section 2.27', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=4 LIMIT 1), 'CET', 'Lockout/tagout',
 'The elevator pit stop switch must be:',
 'A key-operated switch', 'A red mushroom-head stop button that is clearly visible and accessible upon entering the pit', 'Hidden behind a panel', 'Located in the machine room only',
 'B', 'The pit stop switch must be a conspicuous red button located within reach of the pit access door, immediately accessible upon entering the pit.', 'ASME A17.1 Section 2.2.4', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=4 LIMIT 1), 'CET', 'Pit safety',
 'The minimum pit depth required by code ensures:',
 'Adequate storage space', 'Sufficient clearance for a technician under the car platform and proper buffer stroke distance', 'Room for water pumps only', 'Space for additional machinery',
 'B', 'Minimum pit depth is determined by required refuge space under the car platform (for technician safety) plus buffer stroke and running clearance requirements.', 'ASME A17.1 Section 2.2', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=4 LIMIT 1), 'CET', 'Top of car operations',
 'The car top railing (balustrade) is required when:',
 'Never required', 'The car top is used as a working platform and is more than 48 inches above any adjacent surface', 'Only on freight elevators', 'Only in buildings over 10 stories',
 'B', 'A car top balustrade (42 inches minimum height with mid-rail and toe board) is required when the distance from the car top to any adjacent surface exceeds 48 inches, creating a fall hazard.', 'ASME A17.1 Section 2.14', 'medium'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=4 LIMIT 1), 'CET', 'Hoistway entry',
 'Opening a hoistway door with an emergency key is permitted for:',
 'Anyone at any time', 'Only authorized and trained personnel for specific maintenance, inspection, or emergency purposes', 'Building tenants for storage access', 'Delivery personnel',
 'B', 'Emergency hoistway door keys must only be possessed and used by authorized, trained personnel. Misuse of these keys is a leading cause of elevator-related fatalities.', 'ASME A17.1 Section 2.12', 'easy'),

((SELECT id FROM m WHERE cert_level='CET' AND module_number=4 LIMIT 1), 'CET', 'Emergency evacuation',
 'Phase I firefighter emergency recall brings all elevators to:',
 'The top floor', 'The designated recall floor (typically the lobby) upon activation of a fire alarm or manual key switch', 'The nearest floor', 'A complete stop wherever they are',
 'B', 'Phase I recall automatically returns all elevators to the designated recall floor (typically ground/lobby), opens the doors, and removes them from normal service for firefighter access.', 'ASME A17.1 Section 2.27.3', 'easy'),

-- ============================================================
-- QEI Module 1: Inspection Codes & Standards (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='QEI' AND module_number=1 LIMIT 1), 'QEI', 'ASME A17.1/CSA B44',
 'ASME A17.1/CSA B44 is the:',
 'Elevator inspection guide', 'Safety Code for Elevators and Escalators that sets minimum safety requirements', 'Electrical code for elevators', 'Building structural code',
 'B', 'ASME A17.1/CSA B44 is the Safety Code for Elevators and Escalators, establishing minimum safety requirements for design, construction, installation, operation, inspection, testing, maintenance, alteration, and repair.', 'ASME A17.1', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=1 LIMIT 1), 'QEI', 'ASME A17.2 inspection guide',
 'ASME A17.2 is used by inspectors as:',
 'A replacement for A17.1', 'A guide that provides inspection and testing procedures to verify compliance with A17.1', 'A maintenance manual', 'An installation manual',
 'B', 'ASME A17.2 is the companion inspection guide that provides detailed inspection checklists, testing procedures, and acceptance criteria for verifying A17.1 code compliance.', 'ASME A17.2', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=1 LIMIT 1), 'QEI', 'Local jurisdiction requirements',
 'When local elevator codes conflict with ASME A17.1, which takes precedence?',
 'Always ASME A17.1', 'The more stringent requirement typically applies, as determined by the authority having jurisdiction (AHJ)', 'Neither — conflicts void both codes', 'The building owner decides',
 'B', 'The AHJ (Authority Having Jurisdiction) determines which code applies. Generally the more restrictive requirement governs, and local amendments take precedence in that jurisdiction.', 'ASME A17.1 Section 1.1', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=1 LIMIT 1), 'QEI', 'Code edition applicability',
 'An existing elevator is generally subject to:',
 'Only the newest code edition', 'The code edition in effect at the time of its installation, plus any retroactive requirements', 'No code requirements', 'Only local building codes',
 'B', 'Existing installations must comply with the code edition under which they were installed, plus any retroactive safety requirements mandated by the AHJ or ASME A17.3 (Existing Elevators).', 'ASME A17.1 Section 1.2 / A17.3', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=1 LIMIT 1), 'QEI', 'Variance procedures',
 'A variance (or equivalent safety measure) may be granted when:',
 'The owner prefers a different design', 'Strict code compliance is impractical and an alternative provides equivalent or greater safety', 'Cost savings justify the change', 'The contractor requests it',
 'B', 'Variances are granted by the AHJ when strict code compliance is impractical due to existing conditions, provided the proposed alternative delivers at least equivalent safety.', 'ASME A17.1 Section 1.2', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=1 LIMIT 1), 'QEI', 'ASME A17.1/CSA B44',
 'The A17.1 code organizes elevator requirements by:',
 'Building height', 'Equipment type (electric elevators, hydraulic elevators, escalators, etc.) in separate sections', 'Manufacturer', 'Geographic region',
 'B', 'A17.1 is organized by equipment type: Section 2 covers electric elevators, Section 3 covers hydraulic elevators, Section 6 covers escalators, etc.', 'ASME A17.1 Table of Contents', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=1 LIMIT 1), 'QEI', 'ASME A17.2 inspection guide',
 'An inspector using A17.2 must document:',
 'Only items that pass', 'All items inspected, noting compliance, non-compliance, and any items requiring correction', 'Only major violations', 'Only items the building owner requests',
 'B', 'A17.2 requires thorough documentation of all inspection items including compliant items, violations, recommended corrections, and a clear record of the inspection scope.', 'ASME A17.2', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=1 LIMIT 1), 'QEI', 'Local jurisdiction requirements',
 'The QEI certification program is administered by:',
 'OSHA', 'NAESA International (National Association of Elevator Safety Authorities)', 'ASME directly', 'The elevator manufacturers',
 'B', 'NAESA International administers the QEI certification program, testing inspectors on their knowledge of A17.1, A17.2, and inspection practices.', 'NAESA/QEI Program', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=1 LIMIT 1), 'QEI', 'Code edition applicability',
 'ASME A17.3 specifically addresses:',
 'New installations only', 'Safety requirements for existing elevators and escalators, including retroactive upgrades', 'Escalators only', 'Elevator manufacturing standards',
 'B', 'ASME A17.3 establishes safety requirements for existing elevators and escalators, specifying retroactive safety improvements that must be implemented regardless of the original installation code.', 'ASME A17.3', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=1 LIMIT 1), 'QEI', 'Variance procedures',
 'When granting a variance, the AHJ typically requires:',
 'Nothing beyond a verbal request', 'Written documentation of the alternative method, engineering analysis, and demonstration of equivalent safety', 'Only the building owner signature', 'Payment of an additional fee only',
 'B', 'Variance requests typically require detailed engineering documentation demonstrating that the alternative approach provides safety equivalent to or exceeding the code requirement.', 'ASME A17.1 Section 1.2', 'hard'),

-- ============================================================
-- QEI Module 2: Testing Procedures (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='QEI' AND module_number=2 LIMIT 1), 'QEI', 'Category 1 testing',
 'Category 1 testing includes:',
 'Full load safety test with rated speed', 'No-load and reduced-speed safety tests verifying governor tripping and safety device engagement', 'Destructive testing of ropes', 'Only visual inspection',
 'B', 'Category 1 tests are periodic tests performed at reduced speed with no load to verify governor tripping speed and safety device engagement without subjecting components to full-load stresses.', 'ASME A17.1 Section 8.6', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=2 LIMIT 1), 'QEI', 'Category 5 testing',
 'Category 5 testing (full-load, full-speed safety test) is required:',
 'Monthly', 'At installation and every 5 years thereafter', 'Only when problems are reported', 'Annually',
 'B', 'Category 5 tests are the most comprehensive, performed at full rated load and speed at initial installation, then every 5 years to verify the complete safety system under maximum conditions.', 'ASME A17.1 Section 8.6', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=2 LIMIT 1), 'QEI', 'Annual testing requirements',
 'Annual elevator inspections must include testing of:',
 'Only the car lighting', 'Door force, firefighter service, emergency power, and all safety devices', 'Only the call buttons', 'Only the machine brake',
 'B', 'Annual inspections include door closing force (30 lbs max kinetic energy), firefighter Phase I and II operation, emergency power operation, buffers, and all safety circuit devices.', 'ASME A17.1 Section 8.6 / A17.2', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=2 LIMIT 1), 'QEI', 'Load testing',
 'A load test for a new elevator installation verifies that:',
 'The car can carry half its rated load', 'The car can safely support 150% of rated load (traction) or 150% capacity on the buffer (hydraulic)', 'The doors close properly', 'The cab finishes match the drawings',
 'B', 'Acceptance load tests verify the elevator can support 150% of rated load for traction elevators at the buffer and 150% capacity for hydraulic elevators, confirming structural integrity.', 'ASME A17.1 Section 8.10', 'hard'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=2 LIMIT 1), 'QEI', 'Firefighter service testing',
 'Phase II firefighter service testing verifies that:',
 'The elevator returns to the lobby automatically', 'A firefighter can manually control the elevator using a key switch, with doors only opening/closing on continuous pressure', 'The elevator runs faster during fires', 'Sprinklers activate in the hoistway',
 'B', 'Phase II testing confirms that with the firefighter key, the elevator operates under manual control: doors only open/close with constant pressure, the car travels to the selected floor, and all safety features function.', 'ASME A17.1 Section 2.27.3', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=2 LIMIT 1), 'QEI', 'Category 1 testing',
 'How often must Category 1 safety tests be performed on a traction elevator?',
 'Monthly', 'Annually (every year)', 'Every 5 years', 'Every 10 years',
 'B', 'Category 1 tests (reduced-speed, no-load safety device tests) are required annually as part of the periodic inspection and testing program.', 'ASME A17.1 Section 8.6', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=2 LIMIT 1), 'QEI', 'Category 5 testing',
 'During a Category 5 test, the safety devices are expected to:',
 'Slow the car gradually over 100 feet', 'Stop the car within the code-specified stopping distance with full rated load at rated speed', 'Only engage if the governor activates first', 'Not engage — only the brake stops the car',
 'B', 'Category 5 testing verifies the complete safety system (governor + safety device) stops the car with rated load at rated speed within the specified deceleration limits without exceeding maximum deceleration.', 'ASME A17.1 Section 2.17', 'hard'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=2 LIMIT 1), 'QEI', 'Annual testing requirements',
 'The maximum door closing force (kinetic energy) allowed by A17.1 is:',
 '2.5 ft-lbs', '7 ft-lbs', '10 ft-lbs', '15 ft-lbs',
 'A', 'The maximum kinetic energy of a power-operated sliding door is 2.5 ft-lbs for passenger elevators, measured using an approved force gauge. Reopening devices must also be functional.', 'ASME A17.1 Section 2.13', 'hard'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=2 LIMIT 1), 'QEI', 'Load testing',
 'During a no-load standstill test of the machine brake, the elevator must:',
 'Move slowly downward', 'Remain stationary with the motor de-energized and only the brake holding the car and counterweight', 'Run at half speed', 'Open the doors',
 'B', 'The brake must hold the car stationary with the motor de-energized. This verifies the brake alone can support the traction or hydraulic system safely.', 'ASME A17.1 Section 2.24', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=2 LIMIT 1), 'QEI', 'Firefighter service testing',
 'Phase I recall is triggered automatically by:',
 'Pressing a button in the car', 'Smoke detectors in the elevator lobby, machine room, or hoistway activating', 'A key switch in the fire command center only', 'Loss of building power',
 'B', 'Phase I automatic recall is triggered by smoke detectors located in the elevator lobby, machine room, and hoistway. A manual key switch at the designated level provides manual recall.', 'ASME A17.1 Section 2.27.3', 'easy'),

-- ============================================================
-- QEI Module 3: Documentation & Reporting (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='QEI' AND module_number=3 LIMIT 1), 'QEI', 'Inspection reports',
 'An elevator inspection report must include:',
 'Only the inspector name', 'Date of inspection, inspector credentials, equipment identification, all items inspected, findings, violations, and required corrections', 'Only violation photos', 'A letter grade',
 'B', 'Comprehensive inspection reports must document the inspector, date, equipment ID, scope, all items checked, compliance status, violations found, and corrective action requirements.', 'ASME A17.2 / QEI Standards', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=3 LIMIT 1), 'QEI', 'Violation categories',
 'A violation that poses an immediate threat to life safety requires:',
 'Correction within 90 days', 'Immediate shutdown of the elevator until the violation is corrected', 'A note in the next annual report', 'The building owner to be notified within 30 days',
 'B', 'Imminent hazard violations require the elevator to be taken out of service immediately until the dangerous condition is corrected and verified by re-inspection.', 'ASME A17.2 / AHJ Requirements', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=3 LIMIT 1), 'QEI', 'Correction timelines',
 'Non-life-threatening code violations typically must be corrected within:',
 '24 hours', '30 to 90 days, as determined by the AHJ', 'No deadline', 'One year',
 'B', 'Non-critical violations typically receive a correction deadline of 30-90 days set by the AHJ, with follow-up inspection to verify compliance.', 'AHJ Requirements / ASME A17.2', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=3 LIMIT 1), 'QEI', 'Record keeping',
 'Maintenance records and test logs for an elevator must be kept:',
 'For 1 year only', 'On-site or readily accessible, for the life of the equipment or as required by the AHJ', 'Only by the elevator company', 'Records are not required',
 'B', 'A17.1 requires maintenance control programs with records kept on-site or readily accessible. Many jurisdictions require records for the life of the installation.', 'ASME A17.1 Section 8.6', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=3 LIMIT 1), 'QEI', 'Witnessing tests',
 'A QEI witnessing a Category 5 test must verify:',
 'Only that the test was performed', 'Proper test setup, load verification, speed measurement, stopping distance within limits, and safety device condition after the test', 'Only the paperwork', 'That the building owner is present',
 'B', 'The QEI must witness the actual test, verify the load is correct, measure the tripping speed, confirm stopping distance is within code limits, and inspect safety device condition after the test.', 'ASME A17.2 / QEI Standards', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=3 LIMIT 1), 'QEI', 'Inspection reports',
 'An inspector discovers a code violation installed by a previous contractor. The inspector should:',
 'Ignore it if it has been there a long time', 'Document the violation and require correction regardless of who installed it or when', 'Only note it as a comment', 'Contact the previous contractor directly',
 'B', 'All code violations must be documented and corrected regardless of their age or origin. The current building owner is responsible for bringing the equipment into compliance.', 'ASME A17.2 / AHJ Requirements', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=3 LIMIT 1), 'QEI', 'Violation categories',
 'A missing pit stop switch would be classified as:',
 'A minor aesthetic issue', 'A significant safety violation requiring immediate attention, as it is a life-safety device', 'An optional recommendation', 'Not a code violation',
 'B', 'The pit stop switch is a critical life-safety device protecting technicians. Its absence is a significant violation requiring immediate correction before pit entry is permitted.', 'ASME A17.1 Section 2.2.4', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=3 LIMIT 1), 'QEI', 'Correction timelines',
 'If a building owner fails to correct violations within the specified timeframe, the AHJ may:',
 'Do nothing', 'Issue fines, revoke the operating permit, or order the elevator removed from service', 'Extend the deadline indefinitely', 'Correct the violation and send no bill',
 'B', 'The AHJ has enforcement authority including fines, operating certificate revocation, and ordering the elevator shut down until violations are corrected.', 'AHJ Enforcement Authority', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=3 LIMIT 1), 'QEI', 'Record keeping',
 'A Maintenance Control Program (MCP) required by A17.1 must include:',
 'Only a list of contractors', 'Documented maintenance procedures, schedules, examination and testing requirements, and records of all maintenance performed', 'Only warranty information', 'Only the original installation drawings',
 'B', 'A17.1 Section 8.6 requires a written MCP documenting maintenance tasks, frequencies, testing schedules, and records of all work performed by qualified personnel.', 'ASME A17.1 Section 8.6', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=3 LIMIT 1), 'QEI', 'Witnessing tests',
 'The inspector may reject a test result if:',
 'The weather is bad', 'The test setup does not comply with A17.2 procedures, instruments are not calibrated, or results fall outside acceptable limits', 'The contractor disagrees', 'The test was performed on a weekday',
 'B', 'Inspectors must reject tests performed with improper setup, uncalibrated instruments, or results outside code-specified acceptance criteria, requiring the test to be repeated.', 'ASME A17.2', 'medium'),

-- ============================================================
-- QEI Module 4: Hydraulic Systems (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='QEI' AND module_number=4 LIMIT 1), 'QEI', 'Jack types',
 'A holeless hydraulic elevator differs from a holed hydraulic elevator in that:',
 'It does not use hydraulic fluid', 'The jack (cylinder) does not extend into a borehole below the pit floor', 'It has no car', 'It only serves one floor',
 'B', 'Holeless hydraulic elevators use telescoping or roped-hydraulic jacks that do not require a borehole drilled below the pit, making them suitable for sites with high water tables or contaminated soil.', 'ASME A17.1 Section 3.1', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=4 LIMIT 1), 'QEI', 'Hydraulic fluids',
 'Hydraulic elevator fluid must meet which property requirements?',
 'Only low cost', 'Proper viscosity, fire resistance rating, compatibility with seals, and non-toxic properties', 'Any automotive fluid works', 'Only water-based fluids are permitted',
 'B', 'Hydraulic elevator fluid must maintain proper viscosity across operating temperatures, be fire-resistant per code, be compatible with cylinder seals, and meet environmental requirements.', 'ASME A17.1 Section 3.19', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=4 LIMIT 1), 'QEI', 'Pressure relief valves',
 'The pressure relief valve on a hydraulic elevator must be set to open at:',
 'Normal operating pressure', 'Not more than 150% of the pressure required to raise the car with rated load', 'Twice the operating pressure', 'Any convenient setting',
 'B', 'The relief valve must limit system pressure to no more than 150% of the working pressure needed to lift the car with rated load, preventing over-pressurization.', 'ASME A17.1 Section 3.19', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=4 LIMIT 1), 'QEI', 'Underground cylinders',
 'Underground hydraulic cylinders (in-ground jacks) pose what environmental concern?',
 'No environmental concern', 'Hydraulic fluid leaks from corroded cylinders can contaminate groundwater and soil', 'They attract lightning', 'They interfere with radio signals',
 'B', 'Underground cylinders can corrode over time, causing undetected hydraulic fluid leaks that contaminate soil and groundwater. Many jurisdictions now require double-bottomed cylinders or PVC liners.', 'ASME A17.1 Section 3.18 / EPA', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=4 LIMIT 1), 'QEI', 'Hydraulic machine rooms',
 'The hydraulic elevator machine room must have:',
 'Only a door', 'A floor drain or containment for potential oil spills, adequate ventilation, and temperature control', 'No special requirements', 'Only a fire extinguisher',
 'B', 'Hydraulic machine rooms require oil containment (drain/dike), ventilation for heat and fume control, temperature management (fluid viscosity changes with temperature), and proper access.', 'ASME A17.1 Section 3.6', 'easy'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=4 LIMIT 1), 'QEI', 'Jack types',
 'A roped hydraulic elevator uses ropes in conjunction with a hydraulic jack to:',
 'Increase the maximum travel distance beyond what the jack alone can provide', 'Decrease the speed', 'Eliminate the need for a machine room', 'Provide emergency backup only',
 'A', 'Roped hydraulic systems use a 2:1 or 4:1 roping arrangement so the car travels a multiple of the jack stroke, allowing greater rise than a direct-acting jack.', 'ASME A17.1 Section 3.1', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=4 LIMIT 1), 'QEI', 'Hydraulic fluids',
 'Low hydraulic fluid temperature causes which operational issue?',
 'Faster car speed', 'Sluggish valve response and slow car speed due to increased fluid viscosity', 'Lower energy consumption', 'Better seal performance',
 'B', 'Cold hydraulic fluid has higher viscosity, causing sluggish valve operation, slow car movement (especially on startup), and potential pump cavitation.', 'ASME A17.1 Section 3.19', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=4 LIMIT 1), 'QEI', 'Pressure relief valves',
 'During an annual inspection, the relief valve must be:',
 'Visually checked only', 'Function tested to verify it opens at the correct pressure and reseats properly', 'Replaced regardless of condition', 'Ignored if the elevator runs normally',
 'B', 'Annual testing requires verifying the relief valve opens at the set pressure (not exceeding 150% of working pressure) and reseats cleanly without leakage.', 'ASME A17.1 Section 8.6 / A17.2', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=4 LIMIT 1), 'QEI', 'Underground cylinders',
 'A cylinder drift test (the car slowly sinks when idle) indicates:',
 'Normal operation', 'Internal leakage past the packing or check valve, or an external cylinder leak', 'The pump is running properly', 'The car is overloaded',
 'B', 'Excessive drift (car settling when the pump is off) indicates internal leakage past the piston packing, a leaking check valve, or an external cylinder leak — all requiring investigation.', 'ASME A17.2 Inspection Guide', 'medium'),

((SELECT id FROM m WHERE cert_level='QEI' AND module_number=4 LIMIT 1), 'QEI', 'Hydraulic machine rooms',
 'The minimum size of the hydraulic oil reservoir must ensure:',
 'Only that the pump is submerged', 'Adequate oil volume for full car travel plus reserve, with space for thermal expansion and de-aeration', 'Any container size is acceptable', 'Only that it fits in the machine room',
 'B', 'The reservoir must hold sufficient oil for the full stroke of the jack plus reserve volume, with adequate surface area for heat dissipation and air separation.', 'ASME A17.1 Section 3.19', 'hard'),

-- ============================================================
-- CAT Module 1: ADA Accessibility (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CAT' AND module_number=1 LIMIT 1), 'CAT', 'ADA elevator requirements',
 'The Americans with Disabilities Act (ADA) requires elevators in:',
 'Only hospitals', 'All newly constructed multi-story buildings open to the public (with limited exceptions)', 'Only buildings over 10 stories', 'Only government buildings',
 'B', 'ADA requires elevators in all new multi-story buildings open to the public. Limited exceptions exist for buildings under 3 stories or under 3,000 sq ft per floor.', 'ADA Standards Section 407', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=1 LIMIT 1), 'CAT', 'Car size requirements',
 'The minimum ADA elevator car size for a stretcher-accessible elevator is:',
 '51 inches wide by 51 inches deep', '80 inches wide by 51 inches deep', '68 inches wide by 51 inches deep', '36 inches wide by 48 inches deep',
 'C', 'ADA Section 407.4.1 requires a minimum car size of 68 inches wide by 51 inches deep for stretcher-accessible elevators with center-opening doors.', 'ADA Standards Section 407.4.1', 'hard'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=1 LIMIT 1), 'CAT', 'Door timing',
 'ADA requires elevator doors to remain fully open for a minimum of:',
 '1 second', '3 seconds', '5 seconds', '10 seconds',
 'B', 'Elevator doors must remain fully open for a minimum of 3 seconds to allow persons with disabilities adequate time to enter or exit the car.', 'ADA Standards Section 407.3.5', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=1 LIMIT 1), 'CAT', 'Hall call placement',
 'ADA-compliant hall call buttons must be mounted at a centerline height of:',
 '60 inches maximum from the floor', '42 inches from the floor', '36 inches from the floor', '54 inches from the floor',
 'B', 'Hall call buttons must be centered at 42 inches above the finished floor, within reach range for wheelchair users.', 'ADA Standards Section 407.2.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=1 LIMIT 1), 'CAT', 'Reach range requirements',
 'The highest operable control in an elevator car accessible from a forward approach must not exceed:',
 '60 inches', '54 inches', '48 inches', '42 inches',
 'C', 'For a forward approach (wheelchair user facing the controls), the maximum reach height is 48 inches. For a side approach, it is 54 inches maximum.', 'ADA Standards Section 308', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=1 LIMIT 1), 'CAT', 'ADA elevator requirements',
 'An existing building undergoing renovation must bring the elevator into ADA compliance:',
 'Never', 'To the maximum extent feasible without disproportionate cost', 'Only if the entire building is demolished', 'Only if the elevator is replaced',
 'B', 'ADA requires existing buildings undergoing alterations to make elevators accessible to the maximum extent feasible. A safe harbor may apply for unaltered elements that comply with the original standard.', 'ADA Standards Section 202', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=1 LIMIT 1), 'CAT', 'Car size requirements',
 'The minimum clear door width for an ADA-compliant elevator is:',
 '32 inches', '36 inches', '42 inches', '48 inches',
 'B', 'ADA requires a minimum clear door opening of 36 inches for elevator cars to accommodate wheelchair access.', 'ADA Standards Section 407.3.6', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=1 LIMIT 1), 'CAT', 'Door timing',
 'The minimum acceptable door opening/closing speed is calculated based on:',
 'Building height', 'A formula using the distance from the hall call button to the elevator car centerline (5 feet per second minimum)', 'Passenger count', 'Time of day',
 'B', 'ADA specifies the door must remain open long enough for a person to travel from the hall call button to the car, calculated at a speed of not less than 1.5 feet per second.', 'ADA Standards Section 407.3.4', 'hard'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=1 LIMIT 1), 'CAT', 'Hall call placement',
 'Hall call buttons must have a visual indication that the call has been registered, and the indicator must be:',
 'Any color', 'At least 3/4 inch in the smallest dimension', 'Only audible, not visual', 'Located on the ceiling',
 'B', 'ADA requires hall call buttons with a visible signal (at least 3/4 inch) confirming the call is registered, assisting persons with hearing impairments.', 'ADA Standards Section 407.2.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=1 LIMIT 1), 'CAT', 'Reach range requirements',
 'Floor selection buttons inside the elevator car must be:',
 'Arranged randomly', 'Arranged with the lowest floor at the bottom-left, ascending left-to-right and bottom-to-top', 'Arranged with the highest floor at the bottom', 'In alphabetical order',
 'B', 'ADA and A17.1 require floor buttons arranged in ascending order from left to right and bottom to top, with the lowest floor at the bottom-left of the panel.', 'ADA Standards Section 407.4.7', 'easy'),

-- ============================================================
-- CAT Module 2: Signage & Controls (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CAT' AND module_number=2 LIMIT 1), 'CAT', 'Braille requirements',
 'Elevator car control buttons must include Braille that is:',
 'Grade 1 (uncontracted) only', 'Grade 2 (contracted) Braille placed to the left of the corresponding raised character', 'Any Braille format on any side', 'Braille is optional',
 'B', 'ADA requires Grade 2 Braille placed directly below or adjacent to the raised (tactile) floor designation, typically to the left of the button.', 'ADA Standards Section 407.4.7.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=2 LIMIT 1), 'CAT', 'Tactile buttons',
 'Elevator floor buttons must be raised (tactile) so that:',
 'They look better', 'Persons with visual impairments can identify them by touch', 'They are easier to clean', 'They last longer',
 'B', 'Tactile (raised) characters and Braille on elevator buttons allow persons who are blind or have low vision to identify floor selections and controls by touch.', 'ADA Standards Section 407.4.7', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=2 LIMIT 1), 'CAT', 'Audible signals',
 'ADA requires that elevator car arrival at a floor be announced by:',
 'Visual signal only', 'An audible signal (chime or voice) indicating the direction of travel or floor number', 'A physical vibration of the car', 'No announcement is required',
 'B', 'An audible signal must indicate car arrival and direction of travel. A single chime indicates "up" and a double chime indicates "down." Voice annunciation is also acceptable.', 'ADA Standards Section 407.2.2', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=2 LIMIT 1), 'CAT', 'Car position indicators',
 'The car position indicator inside the elevator must:',
 'Only show the current floor', 'Display the current floor with characters at least 1/2 inch high, visible from the car entrance', 'Be located on the ceiling', 'Only be audible',
 'B', 'ADA requires a car position indicator with characters at least 1/2 inch high, located above the car operating panel or above the door, visible to passengers entering the car.', 'ADA Standards Section 407.4.8', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=2 LIMIT 1), 'CAT', 'Emergency communication',
 'The emergency communication system in an elevator must include:',
 'Only a bell alarm', 'A two-way communication system usable by persons with hearing and speech disabilities', 'Only a telephone handset', 'A text display only',
 'B', 'ADA requires the emergency communication system to be usable by persons with hearing and speech impairments, typically requiring both voice and visual/text capability.', 'ADA Standards Section 407.4.9', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=2 LIMIT 1), 'CAT', 'Braille requirements',
 'Hoistway entrance jambs must have tactile floor designations placed at:',
 'Any height', 'Both jambs at 60 inches above the finished floor on the strike side', 'Only on one jamb at 48 inches', 'On the door itself',
 'B', 'Tactile floor designations with Braille must be located on both hoistway entrance jambs at 60 inches above the finished floor, on the strike (latch) side.', 'ADA Standards Section 407.2.3', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=2 LIMIT 1), 'CAT', 'Tactile buttons',
 'The star symbol on elevator buttons designates:',
 'The express floor', 'The main entry floor (level of primary building entrance/egress)', 'The penthouse', 'The maintenance floor',
 'B', 'A raised 5-point star to the left of the button designates the main entry floor (the primary level of building entrance and exit).', 'ADA Standards Section 407.4.7', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=2 LIMIT 1), 'CAT', 'Audible signals',
 'Voice annunciation in an elevator should announce:',
 'The building name', 'The floor number or name at each stop and the direction of travel', 'The weather', 'Only emergency messages',
 'B', 'Voice annunciation should clearly announce the floor at each stop and the direction of travel, assisting persons with visual impairments in navigating the building.', 'ADA Standards Section 407.4.8', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=2 LIMIT 1), 'CAT', 'Car position indicators',
 'An audible floor passing signal is required to:',
 'Entertain passengers', 'Alert persons with visual impairments as the car passes or stops at each floor', 'Test the speaker system', 'Only play in express elevators',
 'B', 'Audible signals at each floor (or an automated voice announcement) help persons with visual impairments track their position and know when to exit.', 'ADA Standards Section 407.4.8', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=2 LIMIT 1), 'CAT', 'Emergency communication',
 'The emergency intercom activation button must be identified by:',
 'The word "HELP" only', 'A raised phone symbol, the word "HELP" in raised letters, and Braille', 'A red color only', 'No specific identification required',
 'B', 'The emergency communication button must bear a tactile phone symbol, the word "HELP" in raised letters, and corresponding Braille to be accessible to all users.', 'ADA Standards Section 407.4.9', 'medium'),

-- ============================================================
-- CAT Module 3: Emergency Systems (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CAT' AND module_number=3 LIMIT 1), 'CAT', 'Emergency lighting',
 'Emergency lighting in the elevator car must provide illumination for a minimum of:',
 '15 minutes', '30 minutes', '4 hours', '24 hours',
 'C', 'Emergency lighting must provide at least 4 hours of illumination at a minimum of 0.2 foot-candles, powered by a rechargeable battery that activates automatically on power loss.', 'ASME A17.1 Section 2.27', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=3 LIMIT 1), 'CAT', 'Emergency communication devices',
 'The two-way communication system must connect to:',
 'The local police station', 'A location staffed 24 hours or an answering service that can initiate rescue', 'The building janitor closet', 'The elevator manufacturer',
 'B', 'The emergency communication must connect to a continuously attended station (building security, answering service, or monitoring center) capable of initiating elevator rescue.', 'ASME A17.1 Section 2.27 / ADA 407.4.9', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=3 LIMIT 1), 'CAT', 'Battery backup',
 'The emergency communication battery backup must be:',
 'Disposable batteries replaced annually', 'Rechargeable and automatically tested, maintaining sufficient charge for emergency duration', 'Not required if the building has a generator', 'Solar powered only',
 'B', 'Emergency systems require rechargeable batteries that automatically charge and are periodically tested to ensure sufficient capacity during power outages.', 'ASME A17.1 Section 2.27', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=3 LIMIT 1), 'CAT', 'Two-way communication',
 'For ADA compliance, the two-way communication system must have:',
 'Only voice capability', 'Both voice communication and a visual signal indicating the call has been received', 'Text messaging only', 'Video only',
 'B', 'ADA requires both an audible communication path and a visual indicator that the emergency call has been acknowledged, serving persons with hearing impairments.', 'ADA Standards Section 407.4.9', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=3 LIMIT 1), 'CAT', 'ADA emergency requirements',
 'The elevator emergency alarm button must be usable:',
 'Only by building staff', 'By all passengers including those with disabilities, located within reach range of wheelchair users', 'Only during business hours', 'Only with a key',
 'B', 'The emergency alarm must be within the accessible reach range (maximum 48 inches forward approach) and operable with one hand without tight grasping, pinching, or twisting.', 'ADA Standards Section 407.4.9 / Section 309.4', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=3 LIMIT 1), 'CAT', 'Emergency lighting',
 'Emergency car lighting must activate:',
 'When the emergency button is pressed', 'Automatically upon loss of normal power supply', 'Only during fire alarm', 'When the car reaches the top floor',
 'B', 'Emergency lighting must activate automatically when normal power is interrupted, providing continuous illumination for trapped passengers.', 'ASME A17.1 Section 2.27', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=3 LIMIT 1), 'CAT', 'Emergency communication devices',
 'An elevator phone or intercom must include what accessibility feature?',
 'Speed dial only', 'Volume control and compatibility with hearing aids (hearing aid coupling)', 'Voice recognition', 'Fingerprint scanner',
 'B', 'Emergency communication devices must include volume control and be compatible with hearing aids to serve passengers with hearing impairments.', 'ADA Standards Section 407.4.9', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=3 LIMIT 1), 'CAT', 'Battery backup',
 'Emergency battery systems in elevators must be tested:',
 'Never', 'At regular intervals per code and manufacturer requirements to verify capacity', 'Only after a power outage occurs', 'Every 10 years',
 'B', 'Emergency battery systems must be tested periodically (typically monthly or quarterly) per A17.1 maintenance requirements to verify they can provide the required duration of backup.', 'ASME A17.1 Section 8.6', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=3 LIMIT 1), 'CAT', 'Two-way communication',
 'If an elevator is not continuously monitored by building staff, the communication system must connect to:',
 'Nobody', 'An approved answering service or monitoring station available 24/7', 'The nearest police station only', 'A voicemail system',
 'B', 'When no on-site 24-hour staff exists, the emergency communication must connect to an approved 24/7 answering service capable of contacting emergency responders and initiating rescue.', 'ASME A17.1 Section 2.27 / IBC 3003', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=3 LIMIT 1), 'CAT', 'ADA emergency requirements',
 'Elevator emergency signage must include instructions that are:',
 'In English only', 'In raised letters, Braille, and pictograms to be accessible to persons with visual impairments', 'Only in the machine room', 'Not required by ADA',
 'B', 'Emergency instructions and signage within the car must be accessible, including raised characters, Braille, and universally understood pictograms.', 'ADA Standards Section 407 / ASME A17.1', 'medium'),

-- ============================================================
-- CAT Module 4: Modernization (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CAT' AND module_number=4 LIMIT 1), 'CAT', 'Upgrade planning',
 'When planning an elevator modernization, the first step is typically:',
 'Ordering new equipment immediately', 'Conducting a thorough assessment of existing conditions, code compliance gaps, and building needs', 'Demolishing the existing elevator', 'Contacting only one vendor',
 'B', 'Modernization planning begins with a complete assessment of the existing installation, identifying code compliance gaps, performance issues, and the building''s current and future needs.', 'ASME A17.1 / Industry Best Practice', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=4 LIMIT 1), 'CAT', 'Code compliance for modernization',
 'An elevator alteration (modernization) triggers compliance with:',
 'Only the original installation code', 'The current code edition for the altered components, plus any retroactive requirements per A17.3', 'No code requirements', 'Only local fire code',
 'B', 'Alterations must comply with the current code edition for all replaced or modified components. Unchanged components may remain under the original code unless A17.3 retroactive requirements apply.', 'ASME A17.1 Section 8.7', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=4 LIMIT 1), 'CAT', 'Destination dispatch',
 'Destination dispatch elevator systems improve efficiency by:',
 'Running all cars to every floor', 'Grouping passengers by destination floor before they enter the car, reducing stops per trip', 'Eliminating the need for door operators', 'Only serving one floor at a time',
 'B', 'Destination dispatch assigns passengers to specific cars based on their destination floor, grouping passengers going to the same or nearby floors to reduce stops and travel time.', 'Industry Technology Standards', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=4 LIMIT 1), 'CAT', 'Energy efficiency',
 'LED car lighting, regenerative drives, and sleep mode are examples of:',
 'Aesthetic improvements only', 'Energy efficiency measures that can reduce elevator energy consumption by 30-70%', 'Safety improvements', 'Code-required changes',
 'B', 'Modern energy efficiency features including regenerative drives, LED lighting, standby/sleep mode, and efficient machine designs can dramatically reduce elevator energy consumption.', 'ISO 25745 / VDI 4707', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=4 LIMIT 1), 'CAT', 'Machine-room-less elevators',
 'Machine-room-less (MRL) elevators place the machine and controller:',
 'In a separate building', 'Within the hoistway or on the hoistway wall, eliminating the need for a dedicated machine room', 'On the roof', 'In the elevator car',
 'B', 'MRL elevators use compact gearless machines mounted in the hoistway (typically at the top) with controllers in a cabinet on the landing wall, eliminating the traditional machine room.', 'ASME A17.1 Section 2.7', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=4 LIMIT 1), 'CAT', 'Upgrade planning',
 'A modernization phasing plan is important because:',
 'All work can be done in one day', 'It minimizes building disruption by scheduling work on some elevators while keeping others in service', 'It is not important', 'It only affects the contractor schedule',
 'B', 'Phased modernization keeps some elevators operational while others are out of service for upgrades, maintaining building accessibility and minimizing tenant disruption.', 'Industry Best Practice', 'easy'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=4 LIMIT 1), 'CAT', 'Code compliance for modernization',
 'Adding a new fire service (Phase I/II) system during modernization requires:',
 'No changes to existing wiring', 'New smoke detectors in the lobby, machine room, and hoistway, plus compliant key switches and recall logic', 'Only a new key switch', 'Only posting a sign',
 'B', 'A complete fire service installation requires properly located smoke detectors, Phase I recall key switch at the designated level, Phase II car key switch, and compliant control logic.', 'ASME A17.1 Section 2.27.3 / NFPA 72', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=4 LIMIT 1), 'CAT', 'Destination dispatch',
 'ADA compliance for destination dispatch systems requires:',
 'No special considerations', 'Accessible input devices at each floor with tactile/Braille floor lists, audible confirmation, and wheelchair-accessible touchscreens', 'Only a phone next to the kiosk', 'Verbal instructions from staff',
 'B', 'Destination dispatch kiosks must be accessible: within reach ranges, operable without vision (tactile/Braille/audible), and usable from a wheelchair. Many systems provide an accessible car operating panel as backup.', 'ADA Standards / A17.1', 'hard'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=4 LIMIT 1), 'CAT', 'Energy efficiency',
 'The ISO 25745 standard classifies elevator energy efficiency using:',
 'Star ratings like appliances', 'Energy performance classes from A (most efficient) to G (least efficient)', 'Horsepower ratings', 'Color-coded labels',
 'B', 'ISO 25745 establishes energy classification from A (most efficient) to G (least efficient) based on measured or calculated energy consumption in running and standby modes.', 'ISO 25745', 'medium'),

((SELECT id FROM m WHERE cert_level='CAT' AND module_number=4 LIMIT 1), 'CAT', 'Machine-room-less elevators',
 'A key maintenance challenge with MRL elevators is:',
 'They require more oil', 'Access to the machine and controller is more constrained than in a traditional machine room', 'They cannot be modernized', 'They produce more noise',
 'B', 'MRL maintenance is more challenging because the machine is in the hoistway (requiring top-of-car access) and the controller is in a wall cabinet rather than a spacious machine room.', 'ASME A17.1 Section 2.7 / Industry Practice', 'medium');
