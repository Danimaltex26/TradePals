-- Seed WindPal training modules & questions (wind turbines)
-- Cert levels: GWO_BST, GWO_BTT, ACP_TECH
-- 4 modules per level = 12 modules, 10 questions per module = 120 questions

INSERT INTO windpal.training_modules (cert_level, module_number, title, topic_list, estimated_minutes, exam_domain_weight, is_published) VALUES
-- GWO_BST (Basic Safety Training)
('GWO_BST', 1, 'Working at Heights', ARRAY['Fall protection systems','Harness inspection','Anchor points','Rescue procedures','Climb assist systems'], 55, 0.30, true),
('GWO_BST', 2, 'First Aid', ARRAY['CPR/AED','Trauma response','Confined space first aid','Heat/cold emergencies','Emergency communication'], 50, 0.25, true),
('GWO_BST', 3, 'Fire Awareness', ARRAY['Fire triangle','Extinguisher types','Turbine fire risks','Evacuation procedures','Suppression systems'], 45, 0.25, true),
('GWO_BST', 4, 'Manual Handling', ARRAY['Lifting techniques','Ergonomic risk assessment','Tool handling at height','Team lifts','Musculoskeletal injury prevention'], 40, 0.20, true),
-- GWO_BTT (Basic Technical Training)
('GWO_BTT', 1, 'Mechanical Systems', ARRAY['Drivetrain components','Main bearing','Gearbox operation','Yaw system','Pitch system mechanics'], 60, 0.30, true),
('GWO_BTT', 2, 'Electrical Systems', ARRAY['Generator types','Power conversion','Transformer basics','Cable routing','Grounding and lightning protection'], 60, 0.25, true),
('GWO_BTT', 3, 'Hydraulic Systems', ARRAY['Hydraulic principles','Pitch cylinders','Brake systems','Filtration','Troubleshooting hydraulic circuits'], 55, 0.25, true),
('GWO_BTT', 4, 'Control Systems', ARRAY['SCADA overview','PLC fundamentals','Sensor types','Safety chain','Condition monitoring'], 55, 0.20, true),
-- ACP_TECH (Advanced Certified Professional - Technician)
('ACP_TECH', 1, 'Turbine Operations', ARRAY['Startup/shutdown procedures','Power curve analysis','Curtailment modes','Cold weather operations','Grid code compliance'], 65, 0.30, true),
('ACP_TECH', 2, 'Preventive Maintenance', ARRAY['PM schedules','Torque procedures','Lubrication systems','Filter replacement','Bolt tensioning'], 60, 0.25, true),
('ACP_TECH', 3, 'Blade Inspection', ARRAY['Visual inspection methods','Leading edge erosion','Lightning damage assessment','Blade repair techniques','Drone inspection technology'], 55, 0.25, true),
('ACP_TECH', 4, 'Grid Integration', ARRAY['Power factor correction','Reactive power control','Fault ride-through','Grid frequency response','Substation basics'], 60, 0.20, true);

WITH m AS (SELECT id, cert_level, module_number FROM windpal.training_modules)
INSERT INTO windpal.training_questions (module_id, cert_level, topic, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, standard_reference, difficulty) VALUES

-- ============================================================
-- GWO_BST Module 1: Working at Heights (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=1 LIMIT 1), 'GWO_BST', 'Fall protection systems',
 'What is the maximum free-fall distance permitted when using a personal fall arrest system in a wind turbine?',
 '2 feet', '4 feet', '6 feet', '10 feet',
 'C', 'OSHA and GWO standards limit free-fall distance to 6 feet (1.8m) maximum when using a personal fall arrest system (PFAS).', 'OSHA 1926.502(d)', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=1 LIMIT 1), 'GWO_BST', 'Harness inspection',
 'How often must a full-body harness be inspected by the user before use?',
 'Monthly', 'Weekly', 'Before each use', 'Annually',
 'C', 'GWO BST requires a pre-use visual and tactile inspection of the harness before every use to check for cuts, fraying, damaged hardware, and proper function.', 'GWO BST WAH Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=1 LIMIT 1), 'GWO_BST', 'Anchor points',
 'What is the minimum strength requirement for a personal fall arrest anchor point?',
 '1,000 lbs', '3,600 lbs', '5,000 lbs', '10,000 lbs',
 'C', 'OSHA requires fall arrest anchor points to support at least 5,000 lbs (22.2 kN) per person attached, or be designed by a qualified person with a safety factor of 2.', 'OSHA 1926.502(d)(15)', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=1 LIMIT 1), 'GWO_BST', 'Rescue procedures',
 'Suspension trauma (harness hang syndrome) can become life-threatening within:',
 '30 seconds', '5-10 minutes', '1 hour', '4 hours',
 'B', 'Suspension trauma can cause venous pooling in the legs and become life-threatening within 5-10 minutes, making rapid rescue essential after a fall arrest.', 'GWO BST WAH Standard', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=1 LIMIT 1), 'GWO_BST', 'Climb assist systems',
 'A climb assist system in a wind turbine tower primarily:',
 'Replaces the need for fall protection', 'Reduces physical fatigue during tower climbs by providing powered assistance', 'Is only used for equipment hoisting', 'Eliminates the need for rescue training',
 'B', 'Climb assist systems use a powered cable or track to reduce the physical effort of climbing the tower ladder, reducing fatigue and climb time by up to 50%.', 'OEM Technical Manuals', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=1 LIMIT 1), 'GWO_BST', 'Fall protection systems',
 'A self-retracting lifeline (SRL) provides fall arrest by:',
 'Requiring manual activation', 'Automatically locking when sudden movement is detected, similar to a car seatbelt', 'Only working during descent', 'Providing a fixed-length connection',
 'B', 'An SRL allows free movement during normal activity but locks within inches when it detects sudden acceleration, minimizing free-fall distance.', 'ANSI Z359.14', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=1 LIMIT 1), 'GWO_BST', 'Harness inspection',
 'A harness involved in a fall arrest event must be:',
 'Re-inspected and returned to service if undamaged', 'Removed from service permanently', 'Used for training purposes only', 'Recertified by the manufacturer',
 'B', 'Any harness that has arrested a fall must be immediately removed from service and destroyed. The energy absorption and deformation during arrest compromises structural integrity.', 'ANSI Z359.1', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=1 LIMIT 1), 'GWO_BST', 'Anchor points',
 'When using a vertical lifeline on a turbine tower ladder, how many workers may attach to a single lifeline?',
 'One', 'Two', 'Three', 'Unlimited',
 'A', 'Only one worker may be attached to a vertical lifeline at a time unless the system is specifically designed and rated for multiple users.', 'OSHA 1926.502(d)(10)', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=1 LIMIT 1), 'GWO_BST', 'Rescue procedures',
 'The first action in a nacelle rescue scenario is to:',
 'Begin lowering the victim immediately', 'Assess the situation and call for help / alert the control room', 'Administer first aid', 'Evacuate all personnel',
 'B', 'Rescue protocol begins with scene assessment, alerting the control room, and calling emergency services before initiating the physical rescue procedure.', 'GWO BST WAH Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=1 LIMIT 1), 'GWO_BST', 'Climb assist systems',
 'What must be verified before using a climb assist system?',
 'Wind speed only', 'That the system has been inspected, the turbine is in safe mode, and the user is properly connected to fall protection', 'That the turbine is generating power', 'That at least two climbers are present',
 'B', 'Pre-climb checks include verifying the climb assist system inspection status, ensuring the turbine is in a safe/locked state, and confirming proper fall protection connection.', 'OEM Technical Manuals', 'medium'),

-- ============================================================
-- GWO_BST Module 2: First Aid (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=2 LIMIT 1), 'GWO_BST', 'CPR/AED',
 'The correct compression-to-ventilation ratio for single-rescuer adult CPR is:',
 '15:2', '30:2', '15:1', '30:1',
 'B', 'The AHA-recommended compression-to-ventilation ratio for single-rescuer adult CPR is 30 compressions to 2 ventilations.', 'AHA BLS Guidelines', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=2 LIMIT 1), 'GWO_BST', 'Trauma response',
 'When treating a suspected spinal injury in the nacelle, you should:',
 'Move the victim to a comfortable position', 'Stabilize the head and neck in the position found and await professional rescue', 'Immediately begin descent with the victim', 'Apply a tourniquet',
 'B', 'Suspected spinal injuries require immobilization in the position found. Moving the victim without proper equipment could worsen spinal cord damage.', 'GWO BST First Aid Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=2 LIMIT 1), 'GWO_BST', 'Confined space first aid',
 'Before entering a confined space in a turbine to assist an injured worker, you must:',
 'Enter immediately to help', 'Test the atmosphere and follow confined space entry procedures', 'Only shout instructions from outside', 'Wait for the hospital to arrive',
 'B', 'Confined space rescue requires atmospheric testing, proper PPE, and adherence to entry procedures. Rushing in without testing has caused multiple rescuer fatalities.', 'OSHA 1910.146', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=2 LIMIT 1), 'GWO_BST', 'Heat/cold emergencies',
 'Working inside a nacelle in summer can cause heat exhaustion. The primary treatment is:',
 'Continue working but drink more water', 'Move to a cool area, remove excess clothing, cool the skin, and hydrate', 'Apply ice directly to the chest', 'Administer caffeinated beverages',
 'B', 'Heat exhaustion treatment requires moving to a cool environment, removing excess clothing, applying cool water to the skin, and providing oral rehydration.', 'GWO BST First Aid Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=2 LIMIT 1), 'GWO_BST', 'Emergency communication',
 'When reporting a medical emergency from a wind turbine, what information must be communicated first?',
 'Your name and company', 'Location (site name, turbine number), nature of emergency, and number of casualties', 'Weather conditions', 'Equipment serial numbers',
 'B', 'Emergency communication priority is location, nature of emergency, number of casualties, and current condition — enabling dispatch of appropriate resources.', 'GWO BST First Aid Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=2 LIMIT 1), 'GWO_BST', 'CPR/AED',
 'An AED should be applied to a cardiac arrest victim:',
 'Only by medical professionals', 'As soon as it is available, by any trained responder', 'Only after 5 minutes of CPR', 'Only if the victim is conscious',
 'B', 'Early defibrillation dramatically improves survival. An AED should be applied as soon as available by any trained responder while CPR continues.', 'AHA BLS Guidelines', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=2 LIMIT 1), 'GWO_BST', 'Trauma response',
 'For severe bleeding from a limb injury at height, the recommended first action is:',
 'Apply a tourniquet immediately', 'Apply direct pressure to the wound', 'Lower the victim to ground level first', 'Elevate the limb only',
 'B', 'Direct pressure is the first-line treatment for severe bleeding. A tourniquet is used if direct pressure fails to control life-threatening hemorrhage.', 'TCCC/GWO First Aid Guidelines', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=2 LIMIT 1), 'GWO_BST', 'Confined space first aid',
 'Hydrogen sulfide (H2S) can accumulate in the base of a wind turbine tower. At what concentration does it become immediately dangerous to life?',
 '10 ppm', '50 ppm', '100 ppm', '500 ppm',
 'C', 'H2S is Immediately Dangerous to Life or Health (IDLH) at 100 ppm. Even lower concentrations (10-50 ppm) cause symptoms. Tower bases can accumulate hazardous gases.', 'OSHA PEL/NIOSH IDLH', 'hard'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=2 LIMIT 1), 'GWO_BST', 'Heat/cold emergencies',
 'Hypothermia is a risk for wind turbine technicians because:',
 'Turbines are only in warm climates', 'High altitude, wind exposure, and cold metal surfaces rapidly draw body heat', 'Technicians never wear insulated clothing', 'Work shifts are limited to 2 hours',
 'B', 'Wind turbine work involves exposure to wind chill at height, contact with cold metal in winter, and wet conditions — all accelerating heat loss.', 'GWO BST First Aid Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=2 LIMIT 1), 'GWO_BST', 'Emergency communication',
 'A satellite phone or two-way radio is essential at offshore wind sites because:',
 'Cell phones are not allowed', 'Cell phone coverage is unreliable or absent offshore', 'Regulations require redundant communication', 'GPS tracking requires satellite connection',
 'B', 'Offshore wind sites typically lack reliable cellular coverage, making satellite phones or marine VHF/UHF radios essential for emergency communication.', 'GWO BST Standard', 'easy'),

-- ============================================================
-- GWO_BST Module 3: Fire Awareness (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=3 LIMIT 1), 'GWO_BST', 'Fire triangle',
 'The three elements of the fire triangle are:',
 'Heat, fuel, and water', 'Heat, fuel, and oxygen', 'Oxygen, fuel, and pressure', 'Heat, oxygen, and carbon dioxide',
 'B', 'Fire requires heat (ignition source), fuel (combustible material), and oxygen (oxidizer). Removing any one element extinguishes the fire.', 'NFPA Fire Fundamentals', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=3 LIMIT 1), 'GWO_BST', 'Extinguisher types',
 'What type of fire extinguisher is appropriate for an electrical fire in a turbine nacelle?',
 'Water (Class A)', 'CO2 or dry chemical (Class C)', 'Foam (Class B)', 'Water mist (Class A)',
 'B', 'Electrical fires (Class C) require non-conductive extinguishing agents such as CO2 or dry chemical. Water-based agents risk electrocution.', 'NFPA 10', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=3 LIMIT 1), 'GWO_BST', 'Turbine fire risks',
 'The most common cause of wind turbine fires is:',
 'Arson', 'Lightning strikes and electrical component failure', 'Fuel leaks from diesel generators', 'Blade contact with the tower',
 'B', 'Research shows lightning strikes and electrical/electronic component failures (overheated connections, cable faults) are the leading causes of turbine fires.', 'GWO BST Fire Awareness Standard', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=3 LIMIT 1), 'GWO_BST', 'Evacuation procedures',
 'If a fire breaks out in the nacelle and cannot be controlled, the primary action is:',
 'Continue fighting the fire', 'Evacuate the turbine immediately using the designated escape route', 'Shut down the turbine and wait', 'Move to the hub for safety',
 'B', 'If a nacelle fire cannot be controlled with available equipment, immediate evacuation via the designated escape route (ladder, descent device) is the priority.', 'GWO BST Fire Awareness Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=3 LIMIT 1), 'GWO_BST', 'Suppression systems',
 'Some modern turbines include automatic fire suppression systems that use:',
 'Sprinkler heads with water', 'Clean agent systems (FM-200, Novec) that suppress fire without damaging electronics', 'Sand dispensers', 'Foam cannons',
 'B', 'Automatic fire suppression in turbines typically uses clean agents like FM-200 or Novec 1230 that extinguish fire without water damage to sensitive electrical components.', 'NFPA 2001', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=3 LIMIT 1), 'GWO_BST', 'Fire triangle',
 'Removing oxygen from a fire is called:',
 'Cooling', 'Smothering', 'Starving', 'Diluting',
 'B', 'Smothering removes oxygen from the fire (e.g., CO2 extinguisher, fire blanket). Cooling removes heat, and starving removes fuel.', 'NFPA Fire Fundamentals', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=3 LIMIT 1), 'GWO_BST', 'Extinguisher types',
 'The PASS technique for operating a fire extinguisher stands for:',
 'Push, Aim, Spray, Stop', 'Pull, Aim, Squeeze, Sweep', 'Point, Activate, Spray, Secure', 'Pull, Approach, Spray, Sweep',
 'B', 'PASS: Pull the pin, Aim at the base of the fire, Squeeze the handle, Sweep from side to side.', 'NFPA 10', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=3 LIMIT 1), 'GWO_BST', 'Turbine fire risks',
 'Hydraulic oil leaks in a turbine nacelle present a fire hazard because:',
 'Hydraulic oil is non-flammable', 'Hydraulic oil has a flash point that can be reached near hot components and can create an atomized spray that ignites easily', 'Hydraulic oil only burns at temperatures above 1,000°F', 'The oil is water-based and harmless',
 'B', 'Hydraulic oil leaks near hot surfaces (brakes, generators) or atomized sprays from high-pressure leaks create serious fire and explosion risks.', 'GWO BST Fire Awareness Standard', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=3 LIMIT 1), 'GWO_BST', 'Evacuation procedures',
 'A controlled descent device (rescue descender) in a wind turbine allows:',
 'Climbing up the tower faster', 'Emergency evacuation by descending from the nacelle to ground level outside the tower', 'Remote firefighting', 'Hoisting heavy equipment',
 'B', 'Controlled descent devices allow technicians to evacuate from the nacelle or hub by descending along the outside of the tower in an emergency when internal routes are blocked.', 'GWO BST WAH/Fire Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=3 LIMIT 1), 'GWO_BST', 'Suppression systems',
 'A fire detection system in a turbine nacelle typically uses which sensor type?',
 'Motion sensors', 'Linear heat detection cables and smoke/flame detectors', 'Pressure transducers', 'Vibration sensors',
 'B', 'Nacelle fire detection typically combines linear heat detection cables (along cable trays), optical flame detectors, and aspirating smoke detection systems.', 'NFPA 850', 'medium'),

-- ============================================================
-- GWO_BST Module 4: Manual Handling (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=4 LIMIT 1), 'GWO_BST', 'Lifting techniques',
 'The correct body mechanics for lifting a heavy object include:',
 'Bending at the waist with straight legs', 'Bending at the knees, keeping the back straight, and lifting with the legs', 'Twisting while lifting to gain momentum', 'Reaching overhead and pulling down',
 'B', 'Proper lifting uses leg muscles while keeping the back straight, the load close to the body, and avoiding twisting motions.', 'GWO BST Manual Handling Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=4 LIMIT 1), 'GWO_BST', 'Ergonomic risk assessment',
 'Risk factors for musculoskeletal disorders in wind turbine work include:',
 'Sitting at a desk', 'Awkward postures, repetitive movements, vibration, and working in confined spaces', 'Reading technical manuals', 'Attending safety meetings',
 'B', 'Wind turbine work involves sustained awkward postures in confined nacelle spaces, repetitive torquing tasks, vibration from tools, and heavy lifting.', 'GWO BST Manual Handling Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=4 LIMIT 1), 'GWO_BST', 'Tool handling at height',
 'Tools used at height must be:',
 'Carried in pockets', 'Tethered to the worker or structure to prevent dropped objects', 'Thrown up to the nacelle when needed', 'Only used on the ground level',
 'B', 'All tools and equipment at height must be tethered, holstered, or contained in tool bags to prevent dropped objects, which are a leading cause of fatalities in wind energy.', 'GWO/DROPS Protocol', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=4 LIMIT 1), 'GWO_BST', 'Team lifts',
 'When performing a team lift, the most important safety requirement is:',
 'Having the strongest person do most of the work', 'Clear communication with one designated leader calling lift commands', 'Lifting as quickly as possible', 'Each person using different techniques',
 'B', 'Team lifts require a designated leader who communicates clear commands (ready, lift, walk, set down) to coordinate effort and prevent injuries.', 'GWO BST Manual Handling Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=4 LIMIT 1), 'GWO_BST', 'Musculoskeletal injury prevention',
 'Pre-task stretching and warm-up exercises before climbing a turbine tower:',
 'Are a waste of time', 'Help prepare muscles for physical demands and reduce injury risk', 'Are only needed in cold weather', 'Replace the need for proper lifting technique',
 'B', 'Pre-work stretching increases blood flow to muscles, improves flexibility, and has been shown to reduce musculoskeletal injury rates in physically demanding trades.', 'GWO BST Manual Handling Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=4 LIMIT 1), 'GWO_BST', 'Lifting techniques',
 'The recommended maximum single-person lift weight under ideal conditions is:',
 '10 lbs', '25 lbs', '50 lbs', '100 lbs',
 'C', 'General ergonomic guidelines recommend a maximum single-person lift of approximately 50 lbs (23 kg) under ideal conditions, with reductions for awkward postures or repetition.', 'NIOSH Lifting Equation', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=4 LIMIT 1), 'GWO_BST', 'Ergonomic risk assessment',
 'Which body position creates the highest risk for back injury when working in a nacelle?',
 'Standing upright', 'Bending and twisting simultaneously under load', 'Sitting on a provided seat', 'Kneeling on a padded surface',
 'B', 'Combined bending and twisting under load places maximum stress on the lumbar spine and intervertebral discs, creating the highest injury risk.', 'GWO BST Manual Handling Standard', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=4 LIMIT 1), 'GWO_BST', 'Tool handling at height',
 'A dropped wrench from a nacelle at 80 meters (260 feet) height can reach what approximate impact force?',
 'Same as its resting weight', '5 times its weight', 'Over 100 times its weight due to terminal velocity', 'Twice its weight',
 'C', 'A 2 lb wrench dropped from 80m can impact with over 200 lbs of force. The kinetic energy at impact makes even small objects potentially lethal.', 'DROPS Calculator', 'hard'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=4 LIMIT 1), 'GWO_BST', 'Team lifts',
 'The hoist/crane inside a turbine tower is used instead of manual carrying when:',
 'Only for blade components', 'Components exceed safe manual lifting limits or must travel vertically up the tower', 'Workers prefer not to carry items', 'The elevator is broken',
 'B', 'Internal hoists and cranes are required for moving components that exceed manual lifting limits or need to travel vertically through the tower to the nacelle.', 'OEM Technical Manuals', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BST' AND module_number=4 LIMIT 1), 'GWO_BST', 'Musculoskeletal injury prevention',
 'Vibration from power tools can cause which occupational condition?',
 'Hearing loss only', 'Hand-arm vibration syndrome (HAVS)', 'Skin cancer', 'Respiratory disease',
 'B', 'Prolonged exposure to vibrating tools causes Hand-Arm Vibration Syndrome (HAVS), affecting blood vessels, nerves, and joints in the hands and arms.', 'OSHA Vibration Standards', 'medium'),

-- ============================================================
-- GWO_BTT Module 1: Mechanical Systems (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=1 LIMIT 1), 'GWO_BTT', 'Drivetrain components',
 'The primary components of a geared wind turbine drivetrain in order from rotor to generator are:',
 'Generator, gearbox, main shaft', 'Main shaft, gearbox, generator', 'Gearbox, main shaft, generator', 'Generator, main shaft, gearbox',
 'B', 'The drivetrain transmits energy from rotor hub through the main (low-speed) shaft, through the gearbox that increases rotational speed, to the generator.', 'GWO BTT Mechanical Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=1 LIMIT 1), 'GWO_BTT', 'Main bearing',
 'The main bearing in a wind turbine supports:',
 'Only the gearbox weight', 'The rotor hub and blade assembly weight plus all aerodynamic loads', 'Only axial thrust loads', 'Only the generator shaft',
 'B', 'The main bearing supports the full weight of the rotor and blades plus all aerodynamic loads including thrust, bending moments, and dynamic forces.', 'GWO BTT Mechanical Standard', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=1 LIMIT 1), 'GWO_BTT', 'Gearbox operation',
 'A typical wind turbine gearbox increases the rotor speed from approximately 10-20 RPM to:',
 '100-200 RPM', '500-1,000 RPM', '1,000-1,800 RPM', '5,000-10,000 RPM',
 'C', 'The gearbox ratio (typically 1:80-100) converts the slow rotor speed of 10-20 RPM to the 1,000-1,800 RPM needed by a conventional generator.', 'GWO BTT Mechanical Standard', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=1 LIMIT 1), 'GWO_BTT', 'Yaw system',
 'The yaw system on a wind turbine is responsible for:',
 'Adjusting blade pitch', 'Rotating the nacelle to face the wind direction', 'Controlling generator speed', 'Operating the braking system',
 'B', 'The yaw system uses electric or hydraulic yaw drives and a yaw bearing to rotate the nacelle so the rotor faces into the wind for maximum energy capture.', 'GWO BTT Mechanical Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=1 LIMIT 1), 'GWO_BTT', 'Pitch system mechanics',
 'Blade pitch control adjusts the angle of the blades to:',
 'Change the tower height', 'Regulate rotor speed and power output, and provide aerodynamic braking', 'Reduce noise only', 'Improve lightning protection',
 'B', 'Pitch control rotates blades around their longitudinal axis to optimize power capture in variable winds and to feather blades for overspeed protection and shutdown.', 'GWO BTT Mechanical Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=1 LIMIT 1), 'GWO_BTT', 'Drivetrain components',
 'A direct-drive wind turbine eliminates which component?',
 'Main bearing', 'Gearbox', 'Generator', 'Yaw system',
 'B', 'Direct-drive turbines connect the rotor directly to a low-speed permanent magnet generator, eliminating the gearbox and its associated maintenance and failure modes.', 'GWO BTT Mechanical Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=1 LIMIT 1), 'GWO_BTT', 'Main bearing',
 'Main bearing failure is typically detected early by:',
 'Visual inspection only', 'Vibration analysis and oil particle monitoring', 'Checking blade balance', 'Measuring power output',
 'B', 'Condition monitoring systems using vibration sensors and oil debris analysis can detect early-stage bearing damage before catastrophic failure.', 'ISO 10816/ISO 4406', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=1 LIMIT 1), 'GWO_BTT', 'Gearbox operation',
 'Gearbox oil temperature is monitored because:',
 'Cold oil improves performance', 'Excessive temperature indicates increased friction, component wear, or cooling system failure', 'Oil temperature has no significance', 'Low temperature causes gearbox failure',
 'B', 'Rising oil temperature signals increased friction from wear, contamination, or cooling system failure. Operating above limits accelerates degradation.', 'OEM Technical Manuals', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=1 LIMIT 1), 'GWO_BTT', 'Yaw system',
 'Yaw misalignment (nacelle not facing the wind) results in:',
 'Improved power capture', 'Reduced energy production and increased structural loads', 'Better blade life', 'Lower noise levels',
 'B', 'Even small yaw errors (5-10 degrees) significantly reduce energy capture and create asymmetric loads on blades and the drivetrain, increasing fatigue damage.', 'IEC 61400-12', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=1 LIMIT 1), 'GWO_BTT', 'Pitch system mechanics',
 'If the pitch system fails to feather the blades during high winds, the backup safety system is:',
 'The yaw system', 'The mechanical brake on the high-speed shaft', 'The tower damper', 'The transformer disconnect',
 'B', 'The mechanical (friction) brake on the high-speed shaft serves as a backup to the pitch system for emergency stopping, though it is sized for parking rather than full aerodynamic loads.', 'IEC 61400-1', 'hard'),

-- ============================================================
-- GWO_BTT Module 2: Electrical Systems (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=2 LIMIT 1), 'GWO_BTT', 'Generator types',
 'A doubly-fed induction generator (DFIG) in a wind turbine uses:',
 'Permanent magnets with no grid connection', 'A partially rated power converter connected to the rotor windings', 'A fully rated power converter', 'Direct current output only',
 'B', 'A DFIG uses a partially rated converter (typically 30% of rated power) connected to the rotor circuit, allowing variable-speed operation while the stator connects directly to the grid.', 'GWO BTT Electrical Standard', 'hard'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=2 LIMIT 1), 'GWO_BTT', 'Power conversion',
 'The power converter in a full-converter wind turbine:',
 'Only converts AC to DC', 'Converts all generator output from variable frequency AC to DC and back to grid-frequency AC', 'Increases voltage only', 'Is only used during startup',
 'B', 'A full converter processes 100% of the generator output: rectifying variable-frequency AC to DC, then inverting back to grid-frequency (50/60 Hz) AC.', 'GWO BTT Electrical Standard', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=2 LIMIT 1), 'GWO_BTT', 'Transformer basics',
 'The turbine transformer steps up voltage from the generator level to:',
 'The same voltage', 'Medium voltage (typically 33-36 kV) for the collection system', 'Transmission voltage (>100 kV)', 'Low voltage (120V)',
 'B', 'The turbine transformer steps up from generator voltage (typically 690V) to the collection system voltage (usually 33-36 kV) for transmission to the substation.', 'IEC 60076', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=2 LIMIT 1), 'GWO_BTT', 'Cable routing',
 'The power cables inside the tower are twisted into a loop to accommodate:',
 'Cable weight', 'Yaw rotation of the nacelle without damaging the cables', 'Voltage drop compensation', 'Easier maintenance access',
 'B', 'Tower cables form a loop (cable twist or drip loop) to allow nacelle yaw rotation. A yaw counter tracks rotations and triggers unwind operations to prevent over-twist.', 'OEM Installation Manuals', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=2 LIMIT 1), 'GWO_BTT', 'Grounding and lightning protection',
 'Wind turbine lightning protection systems route lightning current from the blade tip to:',
 'The nacelle only', 'The tower base and into the earthing/grounding system', 'The gearbox', 'The converter',
 'B', 'Lightning receptors in the blade tips connect via down conductors through the hub, nacelle, and tower to the foundation earthing system, safely dissipating the current.', 'IEC 61400-24', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=2 LIMIT 1), 'GWO_BTT', 'Generator types',
 'Permanent magnet generators are preferred in direct-drive turbines because they:',
 'Are cheaper than all alternatives', 'Provide high torque at low RPM without a gearbox', 'Require no maintenance ever', 'Use no rare earth materials',
 'B', 'Permanent magnet generators produce high torque at the low rotational speeds of a direct-drive rotor (10-20 RPM), eliminating the need for a speed-increasing gearbox.', 'GWO BTT Electrical Standard', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=2 LIMIT 1), 'GWO_BTT', 'Power conversion',
 'Before working on the power converter, a technician must verify:',
 'Only that the turbine is stopped', 'That all capacitors are discharged, LOTO is applied, and zero energy state is confirmed', 'That the wind speed is below 5 m/s', 'That the SCADA system is offline',
 'B', 'Power converter capacitors store lethal energy even after shutdown. LOTO, capacitor discharge verification, and zero-energy confirmation are mandatory before any work.', 'NFPA 70E', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=2 LIMIT 1), 'GWO_BTT', 'Transformer basics',
 'Transformer oil serves two purposes:',
 'Lubrication and cooling', 'Electrical insulation and heat dissipation', 'Fire protection and aesthetics', 'Noise reduction and sealing',
 'B', 'Transformer oil provides electrical insulation between windings and the core, and conducts heat away from the windings to the cooling system.', 'IEC 60076', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=2 LIMIT 1), 'GWO_BTT', 'Cable routing',
 'The minimum bend radius for power cables in a wind turbine is important because:',
 'It affects cable color', 'Exceeding it damages insulation and conductor integrity, risking short circuits', 'It only matters for aesthetics', 'Smaller bends improve conductivity',
 'B', 'Violating minimum bend radius damages cable insulation and can fracture conductors, leading to insulation breakdown, short circuits, and potential fire.', 'IEC 60502', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=2 LIMIT 1), 'GWO_BTT', 'Grounding and lightning protection',
 'The earthing resistance of a wind turbine foundation should typically be less than:',
 '100 ohms', '50 ohms', '10 ohms', '1 ohm',
 'C', 'IEC 61400-24 recommends a turbine earthing resistance of less than 10 ohms to ensure effective lightning current dissipation and personnel safety.', 'IEC 61400-24', 'medium'),

-- ============================================================
-- GWO_BTT Module 3: Hydraulic Systems (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=3 LIMIT 1), 'GWO_BTT', 'Hydraulic principles',
 'Pascal''s law states that pressure applied to a confined fluid:',
 'Decreases with distance', 'Is transmitted equally in all directions', 'Only acts downward', 'Is absorbed by the fluid',
 'B', 'Pascal''s law is the foundation of hydraulics: pressure applied to a confined fluid is transmitted undiminished in all directions throughout the fluid.', 'Fluid Power Fundamentals', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=3 LIMIT 1), 'GWO_BTT', 'Pitch cylinders',
 'Hydraulic pitch cylinders in a wind turbine control blade angle by:',
 'Rotating the gearbox', 'Extending or retracting a piston connected to the blade root bearing', 'Pressurizing the blade interior', 'Moving the nacelle',
 'B', 'Hydraulic pitch cylinders use pressurized oil to extend or retract a piston rod connected to the blade root, rotating the blade around its pitch axis.', 'GWO BTT Hydraulic Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=3 LIMIT 1), 'GWO_BTT', 'Brake systems',
 'The hydraulic yaw brake operates as a:',
 'Positive engagement brake', 'Friction brake using hydraulic caliper pressure on the yaw ring', 'Eddy current brake', 'Regenerative brake',
 'B', 'Yaw brakes use hydraulically actuated calipers that press friction pads against the yaw ring (bull gear) to control and stop nacelle rotation.', 'GWO BTT Hydraulic Standard', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=3 LIMIT 1), 'GWO_BTT', 'Filtration',
 'Hydraulic oil contamination is the leading cause of:',
 'Low oil temperature', 'Premature component failure in hydraulic systems', 'Increased system pressure', 'Improved valve response',
 'B', 'Contamination (particles, water, air) causes approximately 80% of hydraulic system failures through abrasive wear, corrosion, and cavitation.', 'ISO 4406', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=3 LIMIT 1), 'GWO_BTT', 'Troubleshooting hydraulic circuits',
 'A hydraulic system that is slow to respond and making unusual noise likely has:',
 'Too much oil', 'Air in the system (aeration or cavitation)', 'New filters', 'Correct operating temperature',
 'B', 'Air in hydraulic fluid causes spongy response, noise (cavitation), overheating, and accelerated component wear. Bleeding air is a critical maintenance task.', 'GWO BTT Hydraulic Standard', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=3 LIMIT 1), 'GWO_BTT', 'Hydraulic principles',
 'Hydraulic system pressure is typically measured in:',
 'Degrees Fahrenheit', 'Bar or PSI', 'Watts', 'RPM',
 'B', 'Hydraulic pressure is measured in bar (metric) or PSI (pounds per square inch). Typical wind turbine hydraulic systems operate at 100-350 bar.', 'ISO 1219', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=3 LIMIT 1), 'GWO_BTT', 'Pitch cylinders',
 'An accumulator in the hydraulic pitch system serves as:',
 'A filter', 'An emergency energy reserve to feather blades if the hydraulic pump fails', 'A flow meter', 'A temperature sensor',
 'B', 'Hydraulic accumulators store pressurized fluid as emergency backup energy to drive pitch cylinders to the feathered position if the main hydraulic pump fails.', 'GWO BTT Hydraulic Standard', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=3 LIMIT 1), 'GWO_BTT', 'Brake systems',
 'The high-speed shaft mechanical brake is activated by:',
 'Applying hydraulic pressure', 'Releasing hydraulic pressure (spring-applied, hydraulic-released)', 'Electrical solenoid only', 'Manual lever',
 'B', 'Most turbine mechanical brakes are spring-applied and hydraulic-released (fail-safe design). Loss of hydraulic pressure automatically applies the brake.', 'IEC 61400-1', 'hard'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=3 LIMIT 1), 'GWO_BTT', 'Filtration',
 'ISO 4406 cleanliness code 16/14/11 refers to:',
 'Oil temperature ratings', 'Particle count per milliliter at three size thresholds (4, 6, and 14 microns)', 'Filter replacement intervals', 'Oil viscosity grade',
 'B', 'ISO 4406 uses three numbers representing particle counts per mL at >4μm, >6μm, and >14μm thresholds to quantify fluid cleanliness.', 'ISO 4406:2021', 'hard'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=3 LIMIT 1), 'GWO_BTT', 'Troubleshooting hydraulic circuits',
 'Elevated hydraulic oil temperature most commonly indicates:',
 'Normal operation', 'Internal leakage, relief valve bypass, or cooling system failure', 'The system needs more oil', 'Low ambient temperature',
 'B', 'High oil temperature signals energy being converted to heat through internal leakage (worn pumps/valves), relief valve bypass, or inadequate cooling.', 'GWO BTT Hydraulic Standard', 'medium'),

-- ============================================================
-- GWO_BTT Module 4: Control Systems (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=4 LIMIT 1), 'GWO_BTT', 'SCADA overview',
 'SCADA in wind energy stands for:',
 'Standard Control and Data Acquisition', 'Supervisory Control and Data Acquisition', 'System Communication and Data Analysis', 'Safety Control and Diagnostic Assessment',
 'B', 'SCADA (Supervisory Control and Data Acquisition) is the central system for monitoring, controlling, and collecting data from all turbines in a wind farm.', 'IEC 61400-25', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=4 LIMIT 1), 'GWO_BTT', 'PLC fundamentals',
 'The turbine PLC (Programmable Logic Controller) primary function is to:',
 'Generate electricity', 'Execute the control logic for turbine operation including startup, power regulation, and safety shutdowns', 'Measure wind speed only', 'Communicate with the utility grid only',
 'B', 'The PLC runs the real-time control algorithms that manage all turbine operations: startup sequences, pitch and yaw control, power regulation, and safety system responses.', 'GWO BTT Control Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=4 LIMIT 1), 'GWO_BTT', 'Sensor types',
 'An anemometer mounted on the nacelle measures:',
 'Blade pitch angle', 'Wind speed', 'Generator temperature', 'Tower vibration',
 'B', 'The nacelle-mounted anemometer measures wind speed, providing data for turbine control decisions including power regulation and shutdown thresholds.', 'IEC 61400-12', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=4 LIMIT 1), 'GWO_BTT', 'Safety chain',
 'The turbine safety chain is a hardwired circuit that:',
 'Controls normal power production', 'Provides an independent emergency stop path that bypasses the PLC software', 'Monitors weather conditions', 'Controls the yaw motor only',
 'B', 'The safety chain is a hardwired series circuit of emergency stops and safety sensors that can shut down the turbine independently of the PLC, ensuring fail-safe operation.', 'IEC 61400-1', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=4 LIMIT 1), 'GWO_BTT', 'Condition monitoring',
 'Vibration-based condition monitoring on the gearbox can detect:',
 'Wind direction changes', 'Bearing defects, gear tooth wear, and shaft misalignment', 'Blade ice accumulation', 'Lightning strikes',
 'B', 'Accelerometers on the gearbox detect characteristic vibration patterns associated with bearing defects, gear tooth damage, and shaft misalignment.', 'ISO 10816', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=4 LIMIT 1), 'GWO_BTT', 'SCADA overview',
 'A 10-minute average wind speed of 25 m/s typically triggers:',
 'Maximum power production', 'Turbine shutdown (cut-out) to protect the structure', 'Yaw system calibration', 'Generator cooling test',
 'B', 'Most modern turbines have a cut-out wind speed of approximately 25 m/s (56 mph). Above this, the turbine shuts down to prevent structural damage.', 'IEC 61400-1', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=4 LIMIT 1), 'GWO_BTT', 'PLC fundamentals',
 'A PLC input module reads signals from:',
 'The grid transformer', 'Sensors such as temperature probes, pressure transducers, and proximity switches', 'The SCADA server only', 'Other wind farms',
 'B', 'PLC input modules digitize analog and digital signals from turbine sensors, providing real-time data for the control algorithms.', 'GWO BTT Control Standard', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=4 LIMIT 1), 'GWO_BTT', 'Sensor types',
 'A wind vane on the nacelle provides data for:',
 'Power output measurement', 'Yaw control by measuring wind direction relative to the nacelle', 'Blade pitch adjustment', 'Oil temperature monitoring',
 'B', 'The wind vane measures the angle between the wind direction and the nacelle orientation. The yaw controller uses this to minimize yaw error.', 'IEC 61400-12', 'easy'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=4 LIMIT 1), 'GWO_BTT', 'Safety chain',
 'If any single element in the safety chain is triggered (e.g., overspeed sensor), the result is:',
 'An alarm that can be acknowledged remotely', 'Immediate turbine shutdown with blade feathering and brake application', 'Reduced power operation', 'The safety chain continues monitoring',
 'B', 'The safety chain is a series circuit — any triggered element breaks the chain, immediately commanding blade feathering and brake application for an emergency stop.', 'IEC 61400-1', 'medium'),

((SELECT id FROM m WHERE cert_level='GWO_BTT' AND module_number=4 LIMIT 1), 'GWO_BTT', 'Condition monitoring',
 'Oil particle counters in the gearbox lubrication system detect:',
 'Oil color', 'Metal debris indicating gear or bearing wear progression', 'Oil brand', 'Oil temperature only',
 'B', 'Online particle counters detect and quantify metallic debris in gearbox oil, providing early warning of gear tooth pitting, bearing spalling, or other internal wear.', 'ISO 4406', 'medium'),

-- ============================================================
-- ACP_TECH Module 1: Turbine Operations (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=1 LIMIT 1), 'ACP_TECH', 'Startup/shutdown procedures',
 'Before remotely starting a turbine after maintenance, the technician must:',
 'Simply press the start button in SCADA', 'Verify all personnel are clear of the turbine, all safety systems are reset, and maintenance locks are removed', 'Wait for high wind speeds', 'Replace all filters first',
 'B', 'Pre-start verification ensures no personnel are in danger zones, all LOTO devices are removed, safety chain is intact, and the turbine is mechanically ready.', 'OEM Operational Procedures', 'easy'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=1 LIMIT 1), 'ACP_TECH', 'Power curve analysis',
 'A turbine''s power curve plots:',
 'Time versus maintenance cost', 'Wind speed versus electrical power output', 'Temperature versus efficiency', 'RPM versus voltage',
 'B', 'The power curve shows the relationship between wind speed and electrical output, used to verify turbine performance against the manufacturer specification.', 'IEC 61400-12-1', 'easy'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=1 LIMIT 1), 'ACP_TECH', 'Curtailment modes',
 'Noise curtailment mode reduces turbine output by:',
 'Shutting down completely', 'Reducing rotor speed through pitch adjustment and/or generator torque limiting', 'Turning off the lights in the nacelle', 'Lowering the tower height',
 'B', 'Noise curtailment reduces aerodynamic noise by limiting rotor speed via pitch control or generator torque limits, typically during nighttime hours near residences.', 'IEC 61400-11', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=1 LIMIT 1), 'ACP_TECH', 'Cold weather operations',
 'Ice detection systems on wind turbines use which method?',
 'Visual cameras only', 'Sensors measuring blade mass imbalance, power curve deviation, or direct ice detection probes', 'Temperature measurement alone', 'Manual inspection during operation',
 'B', 'Ice detection combines multiple methods: rotor imbalance monitoring, power curve deviation analysis, and dedicated ice sensors on blades or the nacelle.', 'IEC 61400-1 Annex E', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=1 LIMIT 1), 'ACP_TECH', 'Grid code compliance',
 'Low voltage ride-through (LVRT) requires the turbine to:',
 'Shut down during voltage dips', 'Remain connected and support the grid during short-duration voltage sags', 'Increase output during voltage drops', 'Disconnect from the grid immediately',
 'B', 'LVRT grid code requirements mandate that turbines remain connected during voltage dips (down to 0V for short durations) and provide reactive current support to aid grid recovery.', 'FERC Order 661-A', 'hard'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=1 LIMIT 1), 'ACP_TECH', 'Startup/shutdown procedures',
 'A normal (non-emergency) turbine shutdown sequence involves:',
 'Immediately applying the mechanical brake', 'Gradually pitching blades to feather, reducing rotor speed, then applying the parking brake', 'Disconnecting from the grid first', 'Only the yaw system stopping',
 'B', 'Normal shutdown gradually feathers blades to reduce aerodynamic torque, allows rotor speed to decrease, then applies the parking brake — minimizing mechanical stress.', 'OEM Operational Procedures', 'easy'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=1 LIMIT 1), 'ACP_TECH', 'Power curve analysis',
 'A turbine consistently underperforming its warranted power curve may indicate:',
 'Higher than expected wind speeds', 'Blade degradation, pitch calibration error, or yaw misalignment', 'New turbine components', 'Correct operation',
 'B', 'Power curve underperformance is commonly caused by leading edge blade erosion, pitch angle calibration drift, yaw misalignment, or controller tuning issues.', 'IEC 61400-12-1', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=1 LIMIT 1), 'ACP_TECH', 'Curtailment modes',
 'Shadow flicker curtailment stops the turbine when:',
 'Wind speed is too low', 'The rotating blades cast moving shadows on nearby residences during specific sun angles', 'Grid frequency drops', 'The turbine overheats',
 'B', 'Shadow flicker modules use sun position calculations and turbine orientation to predict when blade shadows will affect nearby buildings, stopping the turbine during those periods.', 'Local Permitting Requirements', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=1 LIMIT 1), 'ACP_TECH', 'Cold weather operations',
 'Operating a turbine with ice on the blades poses which primary risk?',
 'Reduced noise only', 'Ice throw hazard to people and property, plus structural imbalance loads on the drivetrain', 'Improved aerodynamic performance', 'Lower generator temperature',
 'B', 'Ice on blades creates mass imbalance causing excessive vibration/loads, and ice shedding or throw poses a safety hazard with fragments traveling hundreds of meters.', 'IEC 61400-1 Annex E', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=1 LIMIT 1), 'ACP_TECH', 'Grid code compliance',
 'Reactive power compensation in a wind farm is primarily used to:',
 'Increase active power output', 'Maintain voltage stability and power factor at the point of interconnection', 'Reduce turbine speed', 'Increase blade pitch angle',
 'B', 'Reactive power control maintains the voltage and power factor requirements at the grid connection point as specified by the grid operator or interconnection agreement.', 'FERC Order 661-A', 'hard'),

-- ============================================================
-- ACP_TECH Module 2: Preventive Maintenance (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=2 LIMIT 1), 'ACP_TECH', 'PM schedules',
 'A typical comprehensive preventive maintenance interval for a modern wind turbine is:',
 'Monthly', 'Every 6 months or annually', 'Every 5 years', 'Only when faults occur',
 'B', 'Most OEMs schedule comprehensive PM visits semi-annually or annually, with minor checks quarterly. The specific interval depends on the turbine model and site conditions.', 'OEM Maintenance Manuals', 'easy'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=2 LIMIT 1), 'ACP_TECH', 'Torque procedures',
 'Bolt torque checks on the turbine are critical because:',
 'Bolts never need re-torquing', 'Dynamic loads cause bolt relaxation and loosening, which can lead to catastrophic structural failure', 'Torque only matters during initial installation', 'Over-torquing improves performance',
 'B', 'Wind turbine bolts experience constant dynamic loading from wind and rotation. Bolt relaxation and embedding cause preload loss, requiring periodic re-torquing to prevent failure.', 'VDI 2230', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=2 LIMIT 1), 'ACP_TECH', 'Lubrication systems',
 'Automatic grease lubrication systems in turbines must be checked for:',
 'Grease color only', 'Proper grease levels, line integrity, distribution to all points, and correct grease type', 'Whether the grease smells correct', 'Nothing — they are fully automatic',
 'B', 'Automatic lubrication systems require verification of reservoir levels, line connections, distribution to all bearings, and that the correct grease specification is used.', 'OEM Maintenance Manuals', 'easy'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=2 LIMIT 1), 'ACP_TECH', 'Filter replacement',
 'Gearbox oil filter differential pressure indicates:',
 'Oil temperature', 'The degree of filter loading — high differential pressure means the filter is nearing capacity', 'Generator output', 'Wind speed',
 'B', 'Differential pressure across the filter element increases as contaminants accumulate. Exceeding the limit triggers a bypass alarm, meaning unfiltered oil is circulating.', 'ISO 16889', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=2 LIMIT 1), 'ACP_TECH', 'Bolt tensioning',
 'Foundation bolt (anchor bolt) tensioning uses hydraulic tensioning equipment because:',
 'Torque wrenches are too expensive', 'Large-diameter bolts require precise and uniform preload that only hydraulic tensioning can reliably achieve', 'It is faster than torquing', 'Foundation bolts are smaller than other bolts',
 'B', 'Foundation bolts (M48-M72) require precise preloads of hundreds of kN. Hydraulic tensioning achieves ±5% accuracy versus ±25% for torque methods on large bolts.', 'VDI 2230 / OEM Specs', 'hard'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=2 LIMIT 1), 'ACP_TECH', 'PM schedules',
 'During a PM visit, the technician should always check the tower bolt torque at:',
 'Only the top flange', 'All flange connections, with particular attention to the top and bottom flanges', 'Only the foundation bolts', 'Only if vibration is reported',
 'B', 'Tower flange bolts at all levels must be inspected. The top flange (yaw bearing) and bottom flange (foundation) experience the highest loads and are checked with particular attention.', 'OEM Maintenance Manuals', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=2 LIMIT 1), 'ACP_TECH', 'Torque procedures',
 'When using a hydraulic torque wrench, the reaction arm must be:',
 'Left floating freely', 'Securely positioned against an adjacent bolt or structure to absorb the reaction force', 'Removed before use', 'Held by a second technician',
 'B', 'The reaction arm transfers the torque reaction force to an adjacent structure. If unsecured, the wrench can spin violently, causing serious injury.', 'Tool Manufacturer Guidelines', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=2 LIMIT 1), 'ACP_TECH', 'Lubrication systems',
 'Using the wrong grease specification in a main bearing can cause:',
 'No issues if the grease is similar', 'Premature bearing failure due to chemical incompatibility, inadequate load capacity, or temperature range mismatch', 'Improved bearing performance', 'Only cosmetic differences',
 'B', 'Wrong grease can cause chemical incompatibility (separation, hardening), insufficient load-carrying capacity, or poor performance at operating temperatures, accelerating bearing failure.', 'ISO 281 / OEM Specs', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=2 LIMIT 1), 'ACP_TECH', 'Filter replacement',
 'Hydraulic system filters should be replaced:',
 'Only when the system fails', 'At scheduled intervals and whenever differential pressure alarms indicate saturation', 'Every 10 years', 'Only during major overhauls',
 'B', 'Filters are replaced on a preventive schedule (typically annually) and reactively when differential pressure monitoring indicates the filter is reaching capacity.', 'ISO 16889 / OEM Manuals', 'easy'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=2 LIMIT 1), 'ACP_TECH', 'Bolt tensioning',
 'A bolt stretch measurement (using ultrasonic bolt gauging) verifies:',
 'Bolt material composition', 'The actual bolt preload by measuring the elongation of the bolt', 'Bolt surface finish', 'Bolt temperature',
 'B', 'Ultrasonic bolt gauging measures the actual bolt elongation (stretch), which directly correlates to preload — providing more accurate verification than torque alone.', 'ASTM E1685', 'hard'),

-- ============================================================
-- ACP_TECH Module 3: Blade Inspection (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=3 LIMIT 1), 'ACP_TECH', 'Visual inspection methods',
 'Ground-based visual blade inspection uses:',
 'Unaided eyesight only', 'High-powered spotting scopes or telephoto cameras to identify surface defects', 'X-ray equipment', 'Thermal cameras from inside the tower',
 'B', 'Ground-based inspection uses spotting scopes and telephoto cameras with high magnification to identify surface erosion, cracks, and lightning damage without climbing.', 'ASTM E2533', 'easy'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=3 LIMIT 1), 'ACP_TECH', 'Leading edge erosion',
 'Leading edge erosion is primarily caused by:',
 'UV radiation only', 'Repeated impact of rain, hail, and airborne particles at high tip speeds', 'Blade manufacturing defects only', 'Tower shadow',
 'B', 'At tip speeds of 80+ m/s, rain droplets, hail, and sand impact the leading edge with tremendous force, progressively eroding the coating, filler, and laminate.', 'DNV-GL Blade Erosion Report', 'easy'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=3 LIMIT 1), 'ACP_TECH', 'Lightning damage assessment',
 'After a confirmed lightning strike, blade inspection should look for:',
 'Only external burn marks', 'Entry and exit point damage, internal delamination, receptor condition, and down conductor continuity', 'Blade color changes only', 'Nothing — blades are designed to withstand lightning',
 'B', 'Lightning can cause surface burns, puncture holes, internal delamination from shock waves, receptor tip damage, and conductor damage — all requiring thorough assessment.', 'IEC 61400-24', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=3 LIMIT 1), 'ACP_TECH', 'Blade repair techniques',
 'Leading edge protection (LEP) tape or coating is applied to:',
 'The entire blade surface', 'The outer third of the blade leading edge where tip speeds are highest', 'Only the blade root', 'The trailing edge only',
 'B', 'LEP is applied to the outer portion of the blade where tip speeds and rain erosion rates are highest, typically the outer 25-35% of blade length.', 'OEM Blade Repair Manuals', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=3 LIMIT 1), 'ACP_TECH', 'Drone inspection technology',
 'Drone blade inspection advantages over rope-access inspection include:',
 'Higher resolution images in all cases', 'Faster coverage, reduced safety risk, no turbine climb required, and consistent image capture', 'Ability to perform repairs', 'No data processing needed',
 'B', 'Drones inspect blades in 15-30 minutes versus hours for rope access, eliminate fall risk, and provide consistent, geo-referenced images for trending analysis.', 'ASTM E3344', 'easy'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=3 LIMIT 1), 'ACP_TECH', 'Visual inspection methods',
 'A blade surface crack running along the span (longitudinal) is typically more critical than a short transverse crack because:',
 'It looks worse', 'It may indicate structural spar cap or shear web delamination beneath the surface', 'Transverse cracks are always cosmetic', 'All cracks are equally minor',
 'B', 'Longitudinal cracks aligned with the spar cap or structural elements may indicate delamination or debonding of load-carrying laminate, requiring immediate structural assessment.', 'DNV-GL Blade Guidelines', 'hard'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=3 LIMIT 1), 'ACP_TECH', 'Leading edge erosion',
 'Leading edge erosion reduces annual energy production (AEP) by:',
 'Less than 0.1%', 'Up to 2-5% depending on severity', 'More than 25%', 'It has no effect on energy production',
 'B', 'Severe leading edge erosion degrades blade aerodynamic performance, increasing drag and reducing lift, with studies showing AEP losses of 2-5%.', 'DTU Wind Energy Research', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=3 LIMIT 1), 'ACP_TECH', 'Lightning damage assessment',
 'Lightning receptor continuity testing measures:',
 'Blade weight', 'The electrical resistance of the down conductor from the receptor tip to the blade root connection', 'Blade pitch angle', 'Air pressure inside the blade',
 'B', 'Continuity testing verifies the lightning down conductor has low resistance (typically <10 ohms) from tip to root, ensuring effective lightning current path.', 'IEC 61400-24', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=3 LIMIT 1), 'ACP_TECH', 'Blade repair techniques',
 'Composite blade repairs using wet layup must be cured at:',
 'Any temperature', 'The temperature specified by the resin system manufacturer, typically using heating blankets or lamps', 'Freezing temperatures for best results', 'Room temperature is always sufficient',
 'B', 'Epoxy resin systems require specific cure temperatures (typically 40-80°C) for proper cross-linking. Heating blankets with thermocouples ensure correct cure profiles.', 'OEM Blade Repair Manuals', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=3 LIMIT 1), 'ACP_TECH', 'Drone inspection technology',
 'AI-assisted drone blade inspection improves efficiency by:',
 'Flying the drone faster', 'Automatically detecting and classifying defects from images, reducing manual review time', 'Eliminating the need for a pilot', 'Replacing all other inspection methods',
 'B', 'Machine learning algorithms trained on thousands of blade images can automatically identify, classify, and prioritize defects, reducing analysis time from hours to minutes.', 'Industry AI/ML Research', 'medium'),

-- ============================================================
-- ACP_TECH Module 4: Grid Integration (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=4 LIMIT 1), 'ACP_TECH', 'Power factor correction',
 'Power factor in a wind farm is the ratio of:',
 'Voltage to current', 'Real power (kW) to apparent power (kVA)', 'Reactive power to real power', 'Generator speed to rated speed',
 'B', 'Power factor = Real Power (kW) / Apparent Power (kVA). A power factor of 1.0 means all power delivered is useful real power with no reactive component.', 'IEEE 1547', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=4 LIMIT 1), 'ACP_TECH', 'Reactive power control',
 'A wind farm may need to absorb reactive power (operate at leading power factor) when:',
 'The grid voltage is too low', 'The grid voltage is too high and needs to be reduced', 'Active power output is at maximum', 'Turbines are in standby',
 'B', 'Absorbing reactive power (leading PF) reduces grid voltage. The wind farm controller adjusts individual turbine reactive power output to maintain the required voltage at the POI.', 'IEEE 1547', 'hard'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=4 LIMIT 1), 'ACP_TECH', 'Fault ride-through',
 'During a grid fault (voltage dip), a modern wind turbine must:',
 'Disconnect immediately to protect itself', 'Remain connected and inject reactive current to support grid voltage recovery', 'Increase active power output', 'Switch to island mode',
 'B', 'Grid codes require turbines to ride through voltage dips and inject reactive current proportional to the voltage drop to support grid stability and recovery.', 'FERC Order 661-A / Grid Codes', 'hard'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=4 LIMIT 1), 'ACP_TECH', 'Grid frequency response',
 'If grid frequency drops below nominal (e.g., below 60 Hz in the US), wind turbines with frequency response capability will:',
 'Shut down to protect the generator', 'Increase active power output (if available) to support frequency recovery', 'Reduce power output', 'Disconnect from the grid',
 'B', 'Under-frequency response involves releasing additional active power (from de-rated operation or stored kinetic energy) to arrest the frequency decline and support recovery.', 'NERC Reliability Standards', 'hard'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=4 LIMIT 1), 'ACP_TECH', 'Substation basics',
 'The wind farm substation steps up voltage from the collection system to:',
 'Generator voltage (690V)', 'Collection system voltage (34.5 kV)', 'Transmission voltage (115-345 kV) for connection to the bulk power system', 'Distribution voltage (12 kV)',
 'C', 'The wind farm substation contains a main power transformer that steps up from the collection system voltage (typically 34.5 kV) to the transmission voltage for grid interconnection.', 'IEEE C57', 'easy'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=4 LIMIT 1), 'ACP_TECH', 'Power factor correction',
 'A wind farm is typically required to operate within a power factor range of:',
 '0.50 to 0.75', '0.85 to 1.0', '0.95 leading to 0.95 lagging', 'Exactly 1.0 at all times',
 'C', 'Most grid codes require wind farms to operate within a power factor range of 0.95 leading to 0.95 lagging at the point of interconnection.', 'FERC Order 661-A', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=4 LIMIT 1), 'ACP_TECH', 'Reactive power control',
 'STATCOM and SVC devices at a wind farm substation provide:',
 'Active power only', 'Dynamic reactive power compensation to maintain voltage at the point of interconnection', 'Frequency regulation only', 'Mechanical braking',
 'B', 'STATCOM (Static Synchronous Compensator) and SVC (Static VAR Compensator) provide fast dynamic reactive power to maintain voltage stability at the grid connection point.', 'IEEE 1031', 'medium'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=4 LIMIT 1), 'ACP_TECH', 'Fault ride-through',
 'The chopper resistor (dump load) in a full-converter turbine is used during grid faults to:',
 'Generate additional power', 'Dissipate excess energy that cannot be exported to the grid during the voltage dip', 'Test the generator', 'Heat the nacelle',
 'B', 'During a grid fault when active power export is limited, the chopper resistor absorbs excess generator energy as heat, allowing the turbine to remain connected without overspeeding.', 'OEM Technical Documentation', 'hard'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=4 LIMIT 1), 'ACP_TECH', 'Grid frequency response',
 'Synthetic (or virtual) inertia from a wind turbine is provided by:',
 'Adding a flywheel', 'Temporarily extracting kinetic energy from the rotating rotor mass via converter control', 'Increasing blade pitch', 'Battery storage only',
 'B', 'Synthetic inertia uses the converter control to temporarily increase electrical output above mechanical input, decelerating the rotor to release stored kinetic energy to the grid.', 'NERC Reliability Standards', 'hard'),

((SELECT id FROM m WHERE cert_level='ACP_TECH' AND module_number=4 LIMIT 1), 'ACP_TECH', 'Substation basics',
 'Protection relays at the wind farm substation monitor for:',
 'Wind speed only', 'Overcurrent, overvoltage, undervoltage, frequency deviations, and differential faults', 'Only transformer temperature', 'Bird activity',
 'B', 'Substation protection relays continuously monitor electrical parameters and trip breakers to isolate faults, protecting equipment and maintaining grid stability.', 'IEEE C37', 'medium');
