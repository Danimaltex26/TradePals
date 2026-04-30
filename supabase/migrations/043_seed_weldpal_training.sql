-- 043_seed_weldpal_training.sql
-- Seed training modules and questions for WeldPal (welding certifications).
-- Cert levels: CW, CAWI, CWI
-- 12 modules (4 per cert level), 120 questions (10 per module)

-- ============================================================
-- PART 1: Training Modules (12 total)
-- ============================================================

INSERT INTO weldpal.training_modules (cert_level, module_number, title, topic_list, estimated_minutes, exam_domain_weight, is_published) VALUES

-- CW (Certified Welder) — 4 modules
('CW', 1, 'Welding Processes', ARRAY['SMAW fundamentals', 'GMAW fundamentals', 'GTAW fundamentals', 'FCAW fundamentals'], 90, 0.30, true),
('CW', 2, 'Joint Preparation & Fit-Up', ARRAY['joint types', 'bevels', 'root openings', 'backing'], 75, 0.25, true),
('CW', 3, 'Visual Inspection Basics', ARRAY['weld defects', 'acceptance criteria', 'measurement tools'], 60, 0.25, true),
('CW', 4, 'Welding Safety', ARRAY['PPE', 'ventilation', 'fire prevention', 'confined space'], 60, 0.20, true),

-- CAWI (Certified Associate Welding Inspector) — 4 modules
('CAWI', 1, 'Welding Metallurgy', ARRAY['base metals', 'HAZ', 'heat treatment', 'carbon equivalence'], 90, 0.25, true),
('CAWI', 2, 'Codes & Standards Overview', ARRAY['AWS D1.1', 'ASME Section IX', 'API 1104'], 90, 0.30, true),
('CAWI', 3, 'Weld Symbols & Drawing Interpretation', ARRAY['weld symbols', 'joint details', 'NDE symbols'], 75, 0.20, true),
('CAWI', 4, 'Inspection Documentation', ARRAY['WPS', 'PQR', 'welder qualification', 'inspection reports'], 75, 0.25, true),

-- CWI (Certified Welding Inspector) — 4 modules
('CWI', 1, 'Advanced Metallurgy & Weldability', ARRAY['stainless steel', 'aluminum', 'dissimilar metals', 'PWHT'], 120, 0.25, true),
('CWI', 2, 'NDE Methods', ARRAY['VT', 'PT', 'MT', 'RT', 'UT principles and applications'], 120, 0.30, true),
('CWI', 3, 'Code Application', ARRAY['D1.1 structural', 'prequalified joints', 'engineer approval'], 90, 0.25, true),
('CWI', 4, 'Quality Systems & Ethics', ARRAY['QA/QC programs', 'inspector responsibilities', 'ethics'], 75, 0.20, true);

-- ============================================================
-- PART 2: Training Questions (120 total — 10 per module)
-- ============================================================

WITH m AS (
  SELECT id, cert_level, module_number FROM weldpal.training_modules
)
INSERT INTO weldpal.training_questions (module_id, cert_level, topic, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, standard_reference, difficulty) VALUES

-- ============================================================
-- CW Module 1: Welding Processes (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CW' AND module_number=1 LIMIT 1), 'CW', 'processes',
 'SMAW uses a consumable electrode coated with:',
 'Inert gas', 'Flux', 'Ceramic backing', 'Copper cladding',
 'B', 'Shielded Metal Arc Welding (SMAW) uses a flux-coated electrode. The flux decomposes during welding to produce a shielding gas and slag that protect the molten weld pool from atmospheric contamination.', 'AWS A3.0', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=1 LIMIT 1), 'CW', 'processes',
 'In GMAW (MIG), the shielding gas for carbon steel is typically:',
 '100% argon', '75% argon / 25% CO₂', '100% nitrogen', '100% oxygen',
 'B', 'A common shielding gas mixture for GMAW on carbon steel is 75% argon and 25% CO₂ (C-25). Pure argon is used for nonferrous metals. CO₂-rich mixes improve penetration on steel.', 'AWS A5.18', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=1 LIMIT 1), 'CW', 'processes',
 'GTAW (TIG) welding uses a non-consumable electrode made of:',
 'Mild steel', 'Tungsten', 'Copper', 'Aluminum',
 'B', 'Gas Tungsten Arc Welding uses a non-consumable tungsten electrode. Tungsten has the highest melting point of any metal (3,422°C), allowing it to sustain the arc without being consumed.', 'AWS A5.12', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=1 LIMIT 1), 'CW', 'processes',
 'FCAW differs from GMAW primarily because FCAW uses:',
 'A solid wire electrode', 'A tubular wire electrode filled with flux', 'No shielding gas under any condition', 'A non-consumable electrode',
 'B', 'Flux-Cored Arc Welding uses a tubular wire electrode with flux in its core. FCAW can be self-shielded (no external gas) or dual-shielded (with external gas), depending on the wire type.', 'AWS A5.20', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=1 LIMIT 1), 'CW', 'processes',
 'The AWS electrode classification E7018 indicates a tensile strength of:',
 '60,000 psi', '70,000 psi', '80,000 psi', '90,000 psi',
 'B', 'In the E7018 designation, "70" represents the minimum tensile strength in ksi (70,000 psi). The "1" indicates all-position capability, and "8" indicates low-hydrogen potassium iron powder coating with AC or DCEP.', 'AWS A5.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=1 LIMIT 1), 'CW', 'processes',
 'What polarity is typically used for SMAW with E7018 electrodes?',
 'DCEN (DC electrode negative)', 'DCEP (DC electrode positive)', 'AC only', 'No polarity preference',
 'B', 'E7018 electrodes are designed for DCEP (reverse polarity) or AC. DCEP provides deeper penetration and better arc stability with low-hydrogen electrodes. The "8" suffix indicates DCEP or AC capability.', 'AWS A5.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=1 LIMIT 1), 'CW', 'processes',
 'Short-circuit transfer in GMAW is characterized by:',
 'High heat input and deep penetration', 'The wire touching the weld pool and extinguishing the arc briefly in a rapid cycle', 'A spray of fine droplets across the arc', 'Globular drops falling by gravity',
 'B', 'Short-circuit (short-arc) transfer occurs at low voltage and wire feed speed. The wire contacts the pool 20-200 times per second, creating low heat input suitable for thin materials and out-of-position welding.', 'AWS A3.0', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=1 LIMIT 1), 'CW', 'processes',
 'Which GTAW tungsten electrode type is recommended for DC welding of steel?',
 'Pure tungsten (green)', '2% thoriated tungsten (red)', 'Zirconiated tungsten (brown)', 'Any type performs equally',
 'B', '2% thoriated (red, EWTh-2) tungsten electrodes provide excellent arc starting, stability, and current-carrying capacity for DC welding of steel and stainless steel. Pure tungsten is better suited for AC on aluminum.', 'AWS A5.12', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=1 LIMIT 1), 'CW', 'processes',
 'The primary advantage of FCAW-S (self-shielded) over FCAW-G (gas-shielded) is:',
 'Higher deposition rate', 'Better suitability for outdoor and windy conditions', 'Lower fume generation', 'Higher weld quality on stainless steel',
 'B', 'Self-shielded FCAW does not require external shielding gas, making it ideal for outdoor and windy conditions where gas shielding would be blown away. It relies entirely on the flux core for atmospheric protection.', 'AWS A5.20', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=1 LIMIT 1), 'CW', 'processes',
 'Spray transfer in GMAW requires:',
 'Low voltage and low wire feed speed', 'Argon-rich shielding gas and current above the transition current', 'CO₂ shielding gas only', 'Pulsed power supply only',
 'B', 'Spray transfer requires an argon-rich shielding gas (≥80% argon) and amperage above the transition current for the given wire diameter. It produces a stream of fine droplets with high deposition rates but high heat input.', 'AWS A3.0', 'hard'),

-- ============================================================
-- CW Module 2: Joint Preparation & Fit-Up (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CW' AND module_number=2 LIMIT 1), 'CW', 'joints',
 'A butt joint with a single-V groove is typically used for material thickness:',
 'Up to 1/8 inch', 'Up to 1/4 inch', '3/8 inch and above', 'Only on pipe',
 'C', 'Single-V groove joints are commonly used for plate thicknesses of 3/8 inch and above. Thinner materials can often be welded with square-groove butt joints or partial penetration welds.', 'AWS D1.1 Table 3.4', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=2 LIMIT 1), 'CW', 'joints',
 'The root opening in a groove weld serves primarily to:',
 'Reduce the amount of filler metal needed', 'Allow complete joint penetration at the root', 'Increase welding speed', 'Prevent distortion',
 'B', 'The root opening provides space for the arc to penetrate to the root of the joint, ensuring complete fusion at the bottom of the weld groove. Insufficient root opening can cause lack of penetration.', 'AWS D1.1', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=2 LIMIT 1), 'CW', 'joints',
 'A backing bar (backing strip) is used to:',
 'Increase weld strength by 50%', 'Support the root pass and prevent melt-through', 'Replace the root pass entirely', 'Act as filler metal',
 'B', 'Backing bars support the molten weld metal at the root, preventing melt-through and ensuring complete joint penetration. They can be steel (permanent) or ceramic/copper (removable).', 'AWS D1.1 §5.9', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=2 LIMIT 1), 'CW', 'joints',
 'The included angle of a standard single-V groove weld per AWS D1.1 is typically:',
 '30°', '45°', '60°', '90°',
 'C', 'AWS D1.1 prequalified single-V groove joints typically have a 60° included angle (30° bevel on each plate). This angle provides adequate access for the electrode while minimizing the volume of weld metal required.', 'AWS D1.1 Figure 3.2', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=2 LIMIT 1), 'CW', 'joints',
 'The root face (land) on a groove weld is the:',
 'Width of the root opening', 'Unbeveled portion of the joint at the root', 'First weld pass deposited', 'Reinforcement height',
 'B', 'The root face is the small flat portion at the root of the groove that is not beveled. It helps control penetration and prevents burn-through. Typical root face dimensions are 0 to 1/8 inch.', 'AWS A3.0', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=2 LIMIT 1), 'CW', 'joints',
 'Tack welds used for assembly should be:',
 'Made as large as possible', 'Of sufficient quality to be incorporated into the final weld or completely removed', 'Always ground flush before welding', 'Made with a different electrode than the production weld',
 'B', 'Per AWS D1.1, tack welds that become part of the final weld must meet the same quality requirements as the production weld. Cracked tack welds must be removed before welding.', 'AWS D1.1 §5.17', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=2 LIMIT 1), 'CW', 'joints',
 'A T-joint is formed when:',
 'Two plates are aligned end-to-end', 'One plate is set perpendicular to the surface of another', 'Two plates overlap', 'A pipe meets a flat plate at 45°',
 'B', 'A T-joint is formed when one member is placed approximately perpendicular (90°) to the other, forming a "T" shape. T-joints are commonly welded with fillet welds on one or both sides.', 'AWS A3.0', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=2 LIMIT 1), 'CW', 'joints',
 'When fitting up a pipe butt joint, the maximum allowable misalignment (high-low) per AWS D1.1 is typically:',
 '1/16 inch', '1/8 inch', '3/16 inch', '1/4 inch',
 'B', 'Internal misalignment (high-low) for pipe butt joints should generally not exceed 1/8 inch per applicable codes. Excessive misalignment creates stress concentrations and incomplete fusion at the root.', 'AWS D1.1 §5.21', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=2 LIMIT 1), 'CW', 'joints',
 'A double-V groove joint is preferred over a single-V groove when:',
 'Material is less than 1/4 inch thick', 'Both sides of the joint are accessible and reduced distortion is desired', 'Only one welder is available', 'The weld is non-structural',
 'B', 'Double-V grooves allow welding from both sides, balancing heat input and reducing angular distortion. They also require less filler metal than single-V grooves on thick materials.', 'AWS D1.1 Figure 3.3', 'hard'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=2 LIMIT 1), 'CW', 'joints',
 'Proper fit-up for a fillet weld on a lap joint requires:',
 'A gap of at least 1/4 inch between plates', 'Tight contact between the overlapping plates with no gap exceeding 1/16 inch', 'The plates to be tack welded on only one end', 'Preheating to 400°F regardless of material',
 'B', 'Lap joint fit-up for fillet welds requires tight contact. Gaps exceeding 1/16 inch must be compensated by increasing the fillet weld size by the amount of the gap per AWS D1.1.', 'AWS D1.1 §5.21', 'medium'),

-- ============================================================
-- CW Module 3: Visual Inspection Basics (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CW' AND module_number=3 LIMIT 1), 'CW', 'inspection',
 'The most common and first NDE method applied to a weld is:',
 'Radiographic testing (RT)', 'Ultrasonic testing (UT)', 'Visual testing (VT)', 'Magnetic particle testing (MT)',
 'C', 'Visual testing is the most fundamental and widely used inspection method. It should be performed before, during, and after welding. All other NDE methods supplement visual inspection.', 'AWS B1.11', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=3 LIMIT 1), 'CW', 'inspection',
 'Undercut is a weld defect defined as:',
 'Excess weld metal above the surface of the base metal', 'A groove melted into the base metal adjacent to the weld toe that is left unfilled', 'A cavity formed by entrapped gas', 'Incomplete fusion between the weld and base metal',
 'B', 'Undercut is a groove or channel melted into the base metal at the weld toe or root that reduces the cross-section of the base metal. It acts as a stress riser and can initiate cracking.', 'AWS A3.0', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=3 LIMIT 1), 'CW', 'inspection',
 'Porosity in a weld is caused primarily by:',
 'Excessive welding speed', 'Gas entrapment in the solidifying weld metal', 'Too much filler metal', 'Improper electrode angle',
 'B', 'Porosity results from gas bubbles trapped in the weld metal during solidification. Common causes include moisture, oil, rust on the base metal, inadequate shielding gas, or damp electrodes.', 'AWS B1.11', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=3 LIMIT 1), 'CW', 'inspection',
 'Per AWS D1.1, the maximum allowable weld reinforcement (cap height) for a groove weld on material up to 1 inch thick is:',
 '1/32 inch', '1/8 inch', '3/16 inch', '1/4 inch',
 'B', 'AWS D1.1 Table 6.1 limits weld reinforcement to 1/8 inch for material up to 1 inch thick. Excessive reinforcement creates stress concentrations at the weld toe.', 'AWS D1.1 Table 6.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=3 LIMIT 1), 'CW', 'inspection',
 'A fillet weld gauge measures:',
 'Tensile strength of the weld', 'Throat size and leg length of a fillet weld', 'Hardness of the HAZ', 'Electrical resistance of the weld',
 'B', 'Fillet weld gauges measure the leg size and theoretical throat of fillet welds. They come in sets to check minimum and maximum sizes against the drawing requirements.', 'AWS B1.11', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=3 LIMIT 1), 'CW', 'inspection',
 'Incomplete fusion (lack of fusion) is:',
 'A condition where the weld metal does not fuse completely with the base metal or preceding weld bead', 'The same as undercut', 'Excessive penetration through the root', 'Normal in multi-pass welds',
 'B', 'Incomplete fusion occurs when the weld metal fails to fuse with the base metal or previous weld passes. Common causes include insufficient heat input, improper electrode angle, or inadequate interpass cleaning.', 'AWS A3.0', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=3 LIMIT 1), 'CW', 'inspection',
 'Crater cracks typically occur at:',
 'The start of a weld bead', 'The termination (end) of a weld bead', 'The center of a long weld', 'Only in the HAZ',
 'B', 'Crater cracks form in the depression at the end of a weld bead when the arc is terminated abruptly. The small pool solidifies rapidly and shrinks, creating star-shaped cracks. Proper crater fill techniques prevent them.', 'AWS D1.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=3 LIMIT 1), 'CW', 'inspection',
 'The minimum acceptable leg size for a fillet weld on 1/2 inch material per AWS D1.1 is:',
 '1/8 inch', '3/16 inch', '1/4 inch', '5/16 inch',
 'B', 'AWS D1.1 Table 5.7 specifies minimum fillet weld sizes based on the thicker part joined. For material from 1/4 to 1/2 inch, the minimum single-pass fillet weld size is 3/16 inch.', 'AWS D1.1 Table 5.7', 'hard'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=3 LIMIT 1), 'CW', 'inspection',
 'Overlap in a weld refers to:',
 'Two weld beads placed side by side', 'Weld metal that rolls over the weld toe without fusing to the base metal', 'Excessive penetration at the root', 'A properly finished weld cap',
 'B', 'Overlap occurs when weld metal flows onto the base metal surface without fusing to it. It is a surface discontinuity often caused by excessive weld pool size or incorrect travel angle. It is rejectable per AWS D1.1.', 'AWS A3.0', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=3 LIMIT 1), 'CW', 'inspection',
 'Acceptable weld profile for a fillet weld requires:',
 'Concave face with legs shorter than specified size', 'Convex or flat face with legs meeting or exceeding the specified size and no undercut', 'Any shape as long as it contains enough metal', 'A perfectly flat surface measured by straightedge',
 'B', 'AWS D1.1 requires fillet welds to have legs meeting the specified minimum size, smooth transition to base metal without undercut exceeding limits, and no incomplete fusion or overlap.', 'AWS D1.1 §5.23', 'hard'),

-- ============================================================
-- CW Module 4: Welding Safety (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CW' AND module_number=4 LIMIT 1), 'CW', 'safety',
 'The minimum shade number for an arc welding helmet lens when welding at 200 amperes with SMAW is:',
 'Shade 8', 'Shade 10', 'Shade 12', 'Shade 14',
 'B', 'ANSI Z49.1 and OSHA recommend a minimum shade 10 for SMAW at 100-200 amperes. Higher amperages require darker shades. Proper shade selection prevents arc eye (photokeratitis).', 'ANSI Z49.1', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=4 LIMIT 1), 'CW', 'safety',
 'Welding fumes from galvanized (zinc-coated) steel can cause:',
 'Improved respiratory function', 'Metal fume fever with flu-like symptoms', 'Permanent blindness', 'No health effects',
 'B', 'Zinc oxide fumes from welding galvanized steel cause metal fume fever, characterized by chills, fever, nausea, and muscle aches. Adequate ventilation or respiratory protection is required.', 'OSHA 29 CFR 1910.252', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=4 LIMIT 1), 'CW', 'safety',
 'Before performing hot work (welding or cutting), a fire watch must:',
 'Be present only during cutting operations', 'Be maintained during and for at least 30 minutes after hot work in areas with combustible materials', 'Be required only in confined spaces', 'Only be used when sprinklers are out of service',
 'B', 'OSHA and NFPA 51B require a fire watch during and for at least 30 minutes after welding or cutting when combustible materials are within 35 feet and cannot be removed or protected.', 'NFPA 51B', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=4 LIMIT 1), 'CW', 'safety',
 'When welding in a confined space, the primary hazard is:',
 'Excessive noise', 'Oxygen depletion and accumulation of toxic fumes or flammable gases', 'UV radiation only', 'Falling objects',
 'B', 'Confined spaces can rapidly accumulate welding fumes and shielding gases while depleting oxygen. OSHA 1910.146 requires atmospheric monitoring, ventilation, and a trained attendant outside the space.', 'OSHA 1910.146', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=4 LIMIT 1), 'CW', 'safety',
 'Cylinders of oxygen and fuel gas must be stored:',
 'Together in the same rack for convenience', 'Separated by at least 20 feet or by a 5-foot fire-resistant barrier', 'Outside only', 'On their sides to prevent tipping',
 'B', 'OSHA 29 CFR 1910.253 requires oxygen and fuel gas cylinders to be separated by at least 20 feet or by a noncombustible barrier at least 5 feet high with a fire-resistance rating of at least 1/2 hour.', 'OSHA 1910.253', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=4 LIMIT 1), 'CW', 'safety',
 'Leather welding gloves and aprons protect primarily against:',
 'Electrical shock only', 'Sparks, spatter, UV radiation, and hot metal burns', 'Toxic gas inhalation', 'Noise exposure',
 'B', 'Leather PPE provides protection from radiant heat, sparks, spatter, and UV radiation. It must be dry and free of holes to also help insulate against electrical shock from the welding circuit.', 'ANSI Z49.1', 'easy'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=4 LIMIT 1), 'CW', 'safety',
 'The primary purpose of local exhaust ventilation during welding is to:',
 'Cool the welder', 'Capture and remove fumes at the source before the welder inhales them', 'Improve arc stability', 'Reduce spatter',
 'B', 'Local exhaust ventilation (LEV) captures welding fumes at or near the arc, removing them before they enter the welder breathing zone. It is more effective than general ventilation for fume control.', 'OSHA 1910.252(c)', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=4 LIMIT 1), 'CW', 'safety',
 'Electric shock from welding equipment is most dangerous when:',
 'Wearing dry leather gloves', 'The welder is sweating or standing on a wet surface, reducing skin resistance', 'Using low amperage settings', 'Welding outdoors in dry conditions',
 'B', 'Moisture dramatically reduces skin resistance, increasing current flow through the body. Wet conditions, perspiration, and damaged insulation are the primary risk factors for fatal electrocution during welding.', 'ANSI Z49.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=4 LIMIT 1), 'CW', 'safety',
 'A hot work permit system requires:',
 'Only verbal approval from the supervisor', 'A written authorization identifying hazards, precautions, and fire prevention measures before welding begins', 'No permits for outdoor welding', 'Permits only when cutting, not welding',
 'B', 'Hot work permits document the location, hazards, precautions, fire watch requirements, and authorization before any welding, cutting, or brazing outside designated welding areas per NFPA 51B and OSHA.', 'NFPA 51B', 'medium'),

((SELECT id FROM m WHERE cert_level='CW' AND module_number=4 LIMIT 1), 'CW', 'safety',
 'Hexavalent chromium (Cr VI) fumes are a serious health concern when welding:',
 'Mild carbon steel', 'Stainless steel and chrome-containing alloys', 'Aluminum', 'Copper',
 'B', 'Welding stainless steel and chromium alloys generates hexavalent chromium fumes, which are carcinogenic. OSHA PEL for Cr(VI) is 5 µg/m³. Proper ventilation and respiratory protection are critical.', 'OSHA 1910.1026', 'hard'),

-- ============================================================
-- CAWI Module 1: Welding Metallurgy (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=1 LIMIT 1), 'CAWI', 'metallurgy',
 'The heat-affected zone (HAZ) is the area of base metal that:',
 'Melts and resolidifies during welding', 'Has its microstructure and properties altered by welding heat without melting', 'Is unaffected by the welding process', 'Receives filler metal deposition',
 'B', 'The HAZ is the portion of base metal adjacent to the weld that does not melt but undergoes microstructural changes due to the thermal cycle. These changes can affect hardness, toughness, and corrosion resistance.', 'AWS WHB Vol 1', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=1 LIMIT 1), 'CAWI', 'metallurgy',
 'Carbon equivalence (CE) is used to predict:',
 'Weld metal strength', 'The hardenability and susceptibility of the HAZ to hydrogen-induced cracking', 'Corrosion resistance', 'Melting temperature',
 'B', 'Carbon equivalence formulas (IIW CE or Pcm) account for carbon and alloying elements that increase hardenability. Higher CE values indicate greater risk of HAZ cracking and a need for preheat.', 'AWS D1.1 Table 3.2', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=1 LIMIT 1), 'CAWI', 'metallurgy',
 'Preheating before welding is primarily done to:',
 'Speed up welding', 'Slow the cooling rate to reduce the risk of hydrogen cracking in the HAZ', 'Increase penetration depth', 'Reduce the need for filler metal',
 'B', 'Preheating slows the cooling rate after welding, reducing the formation of hard, brittle martensite in the HAZ and allowing hydrogen to diffuse out. This is critical for high-CE steels and thick sections.', 'AWS D1.1 §5.6', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=1 LIMIT 1), 'CAWI', 'metallurgy',
 'Martensite forms in the HAZ when:',
 'Cooling is very slow', 'The cooling rate exceeds the critical rate for the steel composition, trapping carbon in a body-centered tetragonal structure', 'The steel is preheated above 600°F', 'Austenite transforms to ferrite and pearlite slowly',
 'B', 'Martensite forms when austenite is cooled rapidly enough to bypass the ferrite/pearlite and bainite transformations. It is very hard and brittle, and susceptible to hydrogen-induced cracking.', 'AWS WHB Vol 1', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=1 LIMIT 1), 'CAWI', 'metallurgy',
 'Hydrogen-induced cracking (cold cracking) requires three simultaneous conditions:',
 'High heat input, low carbon content, and thin material', 'Sufficient hydrogen, susceptible microstructure, and tensile stress', 'Porosity, slag inclusions, and undercut', 'High interpass temperature, slow travel speed, and large electrodes',
 'B', 'Hydrogen-induced cracking (also called delayed or cold cracking) requires: (1) diffusible hydrogen in the weld, (2) a hard, susceptible microstructure (usually martensite), and (3) sufficient tensile stress (residual or applied).', 'AWS D1.1 Annex XI', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=1 LIMIT 1), 'CAWI', 'metallurgy',
 'Post-weld heat treatment (PWHT) is performed to:',
 'Increase hardness of the weld', 'Relieve residual stresses and temper hard microstructures in the weld and HAZ', 'Melt excess weld reinforcement', 'Apply protective coating',
 'B', 'PWHT (stress relief) heats the weldment to a temperature below the lower critical temperature (typically 1100-1250°F for carbon steel) to reduce residual stresses and temper the HAZ microstructure.', 'ASME BPVC Section VIII', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=1 LIMIT 1), 'CAWI', 'metallurgy',
 'Sensitization of austenitic stainless steel occurs when:',
 'The steel is quenched rapidly from high temperature', 'Chromium carbides precipitate at grain boundaries during heating to 800-1500°F, depleting adjacent areas of chromium', 'The steel is welded with too much filler metal', 'Nitrogen is introduced into the weld',
 'B', 'Sensitization occurs when austenitic stainless steel is held in the 800-1500°F range, causing chromium to combine with carbon at grain boundaries. The depleted zones lose corrosion resistance, leading to intergranular corrosion.', 'AWS WHB Vol 4', 'hard'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=1 LIMIT 1), 'CAWI', 'metallurgy',
 'The iron-carbon phase diagram shows that the eutectoid transformation occurs at approximately:',
 '727°C (1341°F)', '912°C (1674°F)', '1538°C (2800°F)', '1148°C (2098°F)',
 'A', 'The eutectoid reaction occurs at 727°C where austenite (0.77% C) transforms to pearlite (alternating layers of ferrite and cementite). This temperature is the lower critical temperature (A1).', 'AWS WHB Vol 1', 'hard'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=1 LIMIT 1), 'CAWI', 'metallurgy',
 'Low-hydrogen electrodes (E7018) must be stored in a holding oven at:',
 'Room temperature', '150-200°F', '250-300°F', '500°F or higher',
 'C', 'After removal from a sealed container, E7018 electrodes must be held at 250-300°F to prevent moisture pickup. Moisture decomposes in the arc, introducing hydrogen into the weld, which can cause cracking.', 'AWS A5.1 / D1.1 §5.3', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=1 LIMIT 1), 'CAWI', 'metallurgy',
 'Grain growth in the HAZ is most pronounced:',
 'At the weld root', 'In the coarse-grained zone immediately adjacent to the fusion line where peak temperature was highest', 'At the weld toe', 'At locations far from the weld',
 'B', 'The coarse-grained HAZ (CGHAZ) nearest the fusion line experiences temperatures well above the upper critical, causing austenite grains to grow significantly. Larger grains reduce toughness and increase crack susceptibility.', 'AWS WHB Vol 1', 'medium'),

-- ============================================================
-- CAWI Module 2: Codes & Standards Overview (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=2 LIMIT 1), 'CAWI', 'codes',
 'AWS D1.1 is the structural welding code for:',
 'Pipe and pipeline welding', 'Steel structures', 'Aluminum welding', 'Sheet metal fabrication',
 'B', 'AWS D1.1 Structural Welding Code—Steel covers welding requirements for steel structures including buildings, bridges (see D1.5), and other structures subject to static or cyclic loading.', 'AWS D1.1 §1.1', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=2 LIMIT 1), 'CAWI', 'codes',
 'ASME Section IX governs:',
 'Structural steel design', 'Welding, brazing, and fusing qualifications for pressure vessels and piping', 'Architectural metalwork', 'Bridge construction',
 'B', 'ASME Boiler and Pressure Vessel Code Section IX covers qualification of welding and brazing procedures (WPS/PQR) and welders/operators for pressure equipment fabrication under the ASME code.', 'ASME BPVC IX', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=2 LIMIT 1), 'CAWI', 'codes',
 'API 1104 covers welding of:',
 'Structural steel beams', 'Pipelines and related facilities for the petroleum and natural gas industry', 'Nuclear components', 'Automotive frames',
 'B', 'API Standard 1104 covers welding of pipelines and related facilities including gas, oil, and water pipelines. It addresses procedure and welder qualification, inspection, and acceptance criteria.', 'API 1104 §1.1', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=2 LIMIT 1), 'CAWI', 'codes',
 'A prequalified WPS under AWS D1.1 means:',
 'The WPS has been tested by an independent lab', 'The WPS conforms to D1.1 specified parameters and does not require qualification testing', 'Any WPS the contractor has used before', 'A WPS approved by the owner',
 'B', 'Prequalified WPSs follow all requirements in D1.1 §3 (approved processes, joint details, filler metals, preheat, etc.) and do not require procedure qualification testing by the contractor.', 'AWS D1.1 §3.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=2 LIMIT 1), 'CAWI', 'codes',
 'Under ASME Section IX, an essential variable is one that:',
 'Can be changed without requalification', 'If changed beyond specified limits, requires requalification of the WPS', 'Is optional in the WPS', 'Only applies to welder performance qualification',
 'B', 'Essential variables are WPS parameters that, if changed beyond specified ranges, affect the mechanical properties of the weld and require a new procedure qualification (PQR). Examples include base metal P-Number, thickness range, and filler metal classification.', 'ASME BPVC IX QW-251', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=2 LIMIT 1), 'CAWI', 'codes',
 'The P-Number system in ASME Section IX groups base metals by:',
 'Tensile strength only', 'Comparable weldability and metallurgical characteristics', 'Thickness', 'Country of origin',
 'B', 'P-Numbers group base metals with similar welding characteristics (composition, weldability, mechanical properties) so that qualification on one material in a P-Number group applies to other materials in that group.', 'ASME BPVC IX QW-422', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=2 LIMIT 1), 'CAWI', 'codes',
 'Under AWS D1.1, a welder performance qualification test requires welding a test coupon and subjecting it to:',
 'Only visual inspection', 'Visual inspection plus guided bend tests or RT/UT', 'Only hardness testing', 'Only chemical analysis',
 'B', 'AWS D1.1 §4.9 requires visual inspection of the test weld, followed by guided bend tests (face and root bends) or alternatively RT or UT of the test coupon to verify welder competency.', 'AWS D1.1 §4.9', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=2 LIMIT 1), 'CAWI', 'codes',
 'Per API 1104, the destructive tests required for procedure qualification include:',
 'Only tensile tests', 'Tensile, nick-break, and bend tests', 'Charpy impact only', 'Hardness survey only',
 'B', 'API 1104 §5.6 requires tensile tests, nick-break tests (for butt welds), and root and face bend tests from the procedure qualification coupon. Additional tests may be required for sour service or other special conditions.', 'API 1104 §5.6', 'hard'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=2 LIMIT 1), 'CAWI', 'codes',
 'The CWI exam administered by AWS consists of which three parts?',
 'Written, oral, and practical', 'Part A (Fundamentals), Part B (Practical), and Part C (Code Application)', 'Visual acuity, written theory, and hands-on welding', 'Metallurgy, NDE, and safety',
 'B', 'The CWI exam has three parts: Part A covers welding fundamentals (metallurgy, processes, inspection), Part B is a practical (hands-on) examination using replicas, and Part C tests the ability to apply a specific welding code.', 'AWS QC1', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=2 LIMIT 1), 'CAWI', 'codes',
 'AWS D1.1 requires that WPS qualification records (PQR) include:',
 'Only the date and welder name', 'All essential variables used during testing and the results of mechanical tests', 'A cost estimate for the project', 'The owners approval signature only',
 'B', 'The PQR documents the actual welding parameters used (essential variables) and the results of all required tests (tensile, bend, macro-etch as applicable). It serves as evidence that the WPS produces acceptable welds.', 'AWS D1.1 §4.7', 'medium'),

-- ============================================================
-- CAWI Module 3: Weld Symbols & Drawing Interpretation (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=3 LIMIT 1), 'CAWI', 'symbols',
 'On a welding symbol, information placed below the reference line indicates:',
 'The weld is on the other side', 'The weld is on the arrow side of the joint', 'Supplementary information only', 'NDE requirements',
 'B', 'Per AWS A2.4, the arrow side of the welding symbol is indicated by information placed below the reference line. Other-side information goes above the reference line.', 'AWS A2.4', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=3 LIMIT 1), 'CAWI', 'symbols',
 'A flag at the junction of the reference line and arrow indicates:',
 'The weld must be ground smooth', 'The weld is to be made in the field (not in the shop)', 'The weld requires NDE', 'The weld is structural',
 'B', 'The field weld flag (a filled or open triangle) at the reference line junction indicates the weld is to be made at the erection site rather than in the shop.', 'AWS A2.4 §3.5', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=3 LIMIT 1), 'CAWI', 'symbols',
 'A circle at the junction of the reference line and arrow indicates:',
 'A spot weld', 'A weld-all-around (continuous around the joint)', 'A plug weld', 'An intermittent weld',
 'B', 'The weld-all-around symbol (circle) indicates the weld extends completely around the joint. It is commonly used on pipe-to-plate connections and similar circumferential joints.', 'AWS A2.4 §3.4', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=3 LIMIT 1), 'CAWI', 'symbols',
 'The number to the left of a fillet weld symbol indicates:',
 'The number of passes', 'The leg size of the fillet weld', 'The length of the weld', 'The electrode diameter',
 'B', 'The dimension to the left of the fillet weld symbol specifies the leg size. If both legs are equal, one number is shown. Unequal legs are shown as two dimensions separated by a multiplication sign.', 'AWS A2.4 §3.7', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=3 LIMIT 1), 'CAWI', 'symbols',
 'On a groove weld symbol, the angle shown inside the symbol indicates:',
 'The electrode angle', 'The groove angle or included angle', 'The bevel angle', 'The work angle',
 'B', 'The angle shown within or adjacent to the groove weld symbol represents the groove angle (included angle). The root opening is shown inside the weld symbol, and the depth of groove is to the left.', 'AWS A2.4 §3.8', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=3 LIMIT 1), 'CAWI', 'symbols',
 'A tail on the welding symbol is used to convey:',
 'Arrow direction changes', 'Supplementary information such as process, specification, or procedure reference', 'Base metal type only', 'Nothing — it is always present',
 'B', 'The tail of the welding symbol carries supplementary information: welding process (e.g., GMAW), WPS number, specification references, or other notes. If no information is needed, the tail is omitted.', 'AWS A2.4 §3.2', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=3 LIMIT 1), 'CAWI', 'symbols',
 'The NDE symbol for ultrasonic testing placed on a welding symbol is:',
 'RT', 'UT', 'MT', 'PT',
 'B', 'NDE symbols are letter designations added to the welding symbol tail or placed in a separate examination symbol: VT (visual), PT (penetrant), MT (magnetic particle), UT (ultrasonic), RT (radiographic).', 'AWS A2.4 §7', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=3 LIMIT 1), 'CAWI', 'symbols',
 'A staggered intermittent fillet weld symbol shows dimensions as:',
 'Size only', 'Size, length of each weld segment, and pitch (center-to-center spacing) with the symbol offset on opposite sides', 'Total weld length only', 'Number of welds per foot',
 'B', 'Staggered intermittent fillet welds show the weld size, length, and pitch on both sides of the reference line. The symbols are offset (staggered) to show that welds on opposite sides are not aligned.', 'AWS A2.4 §3.9', 'hard'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=3 LIMIT 1), 'CAWI', 'symbols',
 'A CJP (complete joint penetration) groove weld symbol differs from a PJP symbol by:',
 'Color coding on the drawing', 'CJP shows no depth of groove dimension, indicating full thickness penetration is required; PJP shows a specific groove depth', 'There is no difference in the symbols', 'CJP is always double-V',
 'B', 'A CJP groove weld symbol has no depth of groove dimension because the weld must achieve complete penetration through the full joint thickness. A PJP weld shows a specific groove depth less than the full thickness.', 'AWS A2.4 / D1.1 §2.3', 'hard'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=3 LIMIT 1), 'CAWI', 'symbols',
 'The backing symbol (rectangle) placed on the other side of the reference line indicates:',
 'A backing weld (back weld)', 'A backing bar on the other side of the joint', 'A spacer in the joint', 'A surfacing weld',
 'B', 'A rectangle on the other side of the reference line represents a backing bar. If a semicircle is used, it indicates a back weld or backing weld. These symbols specify root reinforcement methods.', 'AWS A2.4 §3.12', 'medium'),

-- ============================================================
-- CAWI Module 4: Inspection Documentation (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=4 LIMIT 1), 'CAWI', 'documentation',
 'A Welding Procedure Specification (WPS) documents:',
 'The welders qualification test results', 'The specific welding variables and parameters to be followed during production welding', 'NDE results only', 'Material purchase records',
 'B', 'A WPS is a written document that provides direction for making production welds. It lists essential, supplementary essential, and nonessential variables including process, base/filler metals, preheat, joint design, and technique.', 'AWS D1.1 §3.5 / ASME IX', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=4 LIMIT 1), 'CAWI', 'documentation',
 'A Procedure Qualification Record (PQR) provides:',
 'The contractors quality manual', 'Documentation of the actual welding variables used during WPS qualification testing and the test results', 'A list of certified welders', 'Equipment calibration records',
 'B', 'The PQR records the actual parameters used when welding the qualification test coupon and all required test results (tensile, bend, impact, etc.). It serves as evidence that the WPS produces acceptable welds.', 'ASME BPVC IX QW-200', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=4 LIMIT 1), 'CAWI', 'documentation',
 'Welder qualification records must include:',
 'Only the welders name and date', 'The welders identification, WPS used, essential variables, test results, and range of qualification', 'Just a pass/fail notation', 'Equipment serial numbers only',
 'B', 'Welder qualification records (WPQ or WQTR) document the welders identity, variables used, test coupon description, test results (bend/RT), and the range of qualification (positions, thickness, diameter) the welder is qualified for.', 'AWS D1.1 §4.7 / ASME IX', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=4 LIMIT 1), 'CAWI', 'documentation',
 'A welding inspection report should contain, at minimum:',
 'Only photos of the finished weld', 'Date, inspector ID, WPS reference, acceptance criteria, results, and location/identification of the weld inspected', 'Just the contract number', 'Only the NDE results',
 'B', 'Complete inspection reports document the weld identification/location, date, inspector identification, WPS or procedure reference, applicable acceptance criteria, inspection results, and disposition.', 'AWS B1.11', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=4 LIMIT 1), 'CAWI', 'documentation',
 'A material test report (MTR) or certified mill test report (CMTR) provides:',
 'Welding procedure details', 'Chemical composition, mechanical properties, and heat number for the base metal as certified by the mill', 'NDE technician qualifications', 'Equipment maintenance records',
 'B', 'MTRs/CMTRs certify that the base metal meets specification requirements (chemistry, tensile, yield, elongation, Charpy impact if specified). They are traceable to the heat number for quality documentation.', 'ASTM A6 / ASME II Part A', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=4 LIMIT 1), 'CAWI', 'documentation',
 'Under AWS D1.1, the inspector must verify that welders are qualified before welding by reviewing:',
 'The welders résumé', 'Current welder qualification test records showing the welder is qualified for the WPS being used', 'Verbal confirmation only', 'Social Security records',
 'B', 'The inspector must verify that each welder has a current WPQ or continuity log demonstrating qualification for the specific WPS, position, process, and thickness/diameter range before allowing production welding.', 'AWS D1.1 §6.3', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=4 LIMIT 1), 'CAWI', 'documentation',
 'A welder who has not used a qualified process for a period exceeding __ months must requalify:',
 '3 months', '6 months', '12 months', '24 months',
 'B', 'Per AWS D1.1 §4.1.3 and ASME IX QW-322, if a welder has not used a specific process for 6 months or more, requalification is required unless the employer maintains continuity records.', 'AWS D1.1 §4.1.3', 'medium'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=4 LIMIT 1), 'CAWI', 'documentation',
 'Nonconformance reports (NCRs) must be issued when:',
 'A weld passes all tests', 'A weld or welding activity does not conform to the applicable code, specification, or drawing requirements', 'Only for safety violations', 'Only at the owners request',
 'B', 'NCRs document any condition that deviates from specified requirements. They must describe the nonconformance, disposition (repair, rework, use-as-is, or reject), and corrective action to prevent recurrence.', 'AWS D1.1 §6.6', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=4 LIMIT 1), 'CAWI', 'documentation',
 'The purpose of a weld map is to:',
 'Show the chemical composition of welds', 'Identify and locate all welds on a structure with reference numbers for traceability to WPS and inspection records', 'Display the welding sequence only', 'Record daily temperatures',
 'B', 'Weld maps provide a visual representation of all weld locations on a structure, each with a unique identification number. They enable traceability between the physical weld and its associated WPS, NDE, and inspection records.', 'AWS B1.11', 'easy'),

((SELECT id FROM m WHERE cert_level='CAWI' AND module_number=4 LIMIT 1), 'CAWI', 'documentation',
 'ASME Section IX requires that PQRs be:',
 'Kept for one year only', 'Certified by the organization and maintained for the life of the equipment', 'Submitted to ASME for approval', 'Available only during audits',
 'B', 'PQRs must be certified by the manufacturer or contractor as a true record and maintained as long as the WPS they support is in use. They are not submitted to ASME but must be available for review by the Authorized Inspector.', 'ASME BPVC IX QW-201', 'hard'),

-- ============================================================
-- CWI Module 1: Advanced Metallurgy & Weldability (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CWI' AND module_number=1 LIMIT 1), 'CWI', 'metallurgy',
 'When welding austenitic stainless steel to carbon steel (dissimilar metal joint), the recommended filler metal is typically:',
 'Carbon steel electrode (E7018)', 'An over-alloyed filler such as ERNiCr-3 or E309L', 'Pure nickel', 'No filler metal (autogenous weld)',
 'B', 'Dissimilar welds between austenitic stainless and carbon steel commonly use E309L or ERNiCr-3 (Inconel 82). These over-alloyed fillers compensate for dilution from the carbon steel side and resist cracking.', 'AWS WHB Vol 4 / ASME IX', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=1 LIMIT 1), 'CWI', 'metallurgy',
 'Sigma phase formation in austenitic stainless steel occurs at:',
 'Room temperature', 'Prolonged exposure to 1050-1700°F (565-925°C), especially in high-chromium grades', 'Below 32°F (0°C)', 'Only during welding',
 'B', 'Sigma phase is a hard, brittle intermetallic (iron-chromium) compound that forms during prolonged exposure to 1050-1700°F. It severely reduces ductility and toughness and is most common in high-Cr duplex and austenitic grades.', 'AWS WHB Vol 4', 'hard'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=1 LIMIT 1), 'CWI', 'metallurgy',
 'Hot cracking (solidification cracking) in austenitic stainless steel welds is minimized by:',
 'Increasing sulfur content', 'Ensuring the weld deposit contains 3-8% delta ferrite', 'Using pure austenitic filler metal', 'Increasing heat input',
 'B', 'A small amount of delta ferrite (3-8 FN) in the weld metal improves resistance to solidification cracking by providing a more favorable solidification mode and dissolving harmful impurities (S, P) more readily.', 'AWS WHB Vol 4 / WRC-1992', 'hard'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=1 LIMIT 1), 'CWI', 'metallurgy',
 'PWHT for carbon steel pressure vessels per ASME Code typically involves holding at:',
 '400-500°F for 1 hour', '1100-1200°F for 1 hour per inch of thickness (minimum 1 hour)', '1500-1600°F for 30 minutes', 'Any temperature above 500°F',
 'B', 'ASME Section VIII requires PWHT at 1100-1200°F (595-650°C) with a minimum holding time of 1 hour per inch of weld thickness (1 hour minimum). Heating and cooling rates must be controlled to prevent thermal shock.', 'ASME BPVC VIII UCS-56', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=1 LIMIT 1), 'CWI', 'metallurgy',
 'Welding of 5xxx series aluminum alloys (Al-Mg) presents a risk of:',
 'Hydrogen embrittlement', 'Stress corrosion cracking if the alloy is sensitized (continuous Mg₂Al₃ at grain boundaries)', 'Sigma phase formation', 'Martensite formation',
 'B', 'Certain 5xxx aluminum alloys (particularly those with >3% Mg) can become sensitized with prolonged elevated temperature exposure. Continuous beta-phase (Mg₂Al₃) precipitation at grain boundaries leads to intergranular SCC.', 'AWS D1.2 / ASTM G67', 'hard'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=1 LIMIT 1), 'CWI', 'metallurgy',
 'The primary challenge when welding aluminum is:',
 'Its high melting point', 'Its high thermal conductivity and tenacious oxide layer with a much higher melting point than the base metal', 'Excessive hardness in the HAZ', 'Low coefficient of thermal expansion',
 'B', 'Aluminum oxide melts at 3722°F while aluminum melts at 1220°F. The oxide must be removed (mechanical cleaning + shielding gas or flux) before welding. High thermal conductivity requires higher heat input and faster travel speed.', 'AWS WHB Vol 3', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=1 LIMIT 1), 'CWI', 'metallurgy',
 'Lamellar tearing occurs in:',
 'Thin sheet metal', 'Thick rolled steel plates loaded in the through-thickness (Z) direction, particularly at T-joints and corner joints', 'Only in cast metals', 'Pipe welds only',
 'B', 'Lamellar tearing is a subsurface, step-like fracture parallel to the rolling plane. It occurs in thick plates with elongated MnS inclusions when restrained joints apply through-thickness (Z-direction) tensile stress. Low-sulfur or Z-quality steels resist it.', 'AWS D1.1 Annex VIII', 'hard'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=1 LIMIT 1), 'CWI', 'metallurgy',
 'Duplex stainless steels require careful control of heat input because:',
 'They are not weldable', 'Excessive or insufficient heat input can disrupt the 50/50 ferrite-austenite balance, promoting sigma phase or excessive ferrite', 'They require PWHT above 2000°F', 'They are identical to carbon steel in weldability',
 'B', 'Duplex stainless steels rely on a balanced ferrite-austenite microstructure. Too much heat promotes sigma and chi phases; too little heat results in excess ferrite and loss of toughness and corrosion resistance. Interpass temperature limits are critical.', 'AWS WHB Vol 4 / ASME IX', 'hard'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=1 LIMIT 1), 'CWI', 'metallurgy',
 'When specifying PWHT for Cr-Mo steels (e.g., 2-1/4 Cr-1 Mo), the minimum holding temperature is typically:',
 '800°F', '1100°F', '1350°F', '1550°F',
 'C', 'Cr-Mo steels such as 2-1/4 Cr-1 Mo (P-5A) require higher PWHT temperatures (typically 1300-1400°F) than carbon steel to adequately temper the alloy martensite and bainite and reduce hardness below acceptable limits.', 'ASME BPVC VIII Table UCS-56', 'hard'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=1 LIMIT 1), 'CWI', 'metallurgy',
 'Reheat cracking (stress-relief cracking) is most commonly associated with:',
 'Mild steel welds', 'Cr-Mo-V steels and certain stainless steels during PWHT', 'Aluminum alloys', 'Copper-nickel alloys',
 'B', 'Reheat cracking occurs during PWHT when carbides of Cr, Mo, and V precipitate within the grains, strengthening them while grain boundaries remain weak. The relaxation strain is concentrated at grain boundaries, causing intergranular cracking.', 'AWS WHB Vol 1', 'hard'),

-- ============================================================
-- CWI Module 2: NDE Methods (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CWI' AND module_number=2 LIMIT 1), 'CWI', 'nde',
 'Visual testing (VT) per AWS D1.1 requires the inspector to have a minimum near-distance visual acuity of:',
 'J1 at 12 inches (Jaeger eye chart)', 'J2 at 12 inches (Jaeger eye chart)', '20/20 at 20 feet (Snellen chart)', '20/50 at 20 feet (Snellen chart)',
 'B', 'AWS QC1 requires CWI candidates to demonstrate near-vision acuity of J2 on the Jaeger eye chart at a distance of not less than 12 inches, with or without corrective lenses. This must be verified every 3 years.', 'AWS QC1 §5.2', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=2 LIMIT 1), 'CWI', 'nde',
 'Liquid penetrant testing (PT) can detect:',
 'Subsurface discontinuities only', 'Surface-breaking discontinuities on any nonporous material', 'Only discontinuities in ferromagnetic materials', 'Internal porosity',
 'B', 'PT detects surface-breaking (open-to-surface) discontinuities such as cracks, porosity, and laps. It works on any nonporous material (metals, ceramics, plastics) regardless of magnetic properties.', 'ASTM E165 / ASME V Art. 6', 'easy'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=2 LIMIT 1), 'CWI', 'nde',
 'Magnetic particle testing (MT) is limited to:',
 'All materials', 'Ferromagnetic materials only (carbon steel, low-alloy steel, ferritic stainless)', 'Nonferrous metals only', 'Only materials above 1 inch thick',
 'B', 'MT requires the test material to be ferromagnetic so it can be magnetized. Austenitic stainless steels, aluminum, copper, and other nonferromagnetic materials cannot be tested with MT.', 'ASTM E709 / ASME V Art. 7', 'easy'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=2 LIMIT 1), 'CWI', 'nde',
 'In radiographic testing (RT), the image quality indicator (IQI/penetrameter) is used to:',
 'Identify the weld', 'Verify the radiographic technique has adequate sensitivity to detect discontinuities', 'Measure film density', 'Calculate exposure time',
 'B', 'The IQI (penetrameter) demonstrates that the radiographic technique has sufficient sensitivity. If the specified essential wire or hole is visible on the radiograph, the technique is adequate to detect discontinuities of concern.', 'ASTM E1032 / ASME V Art. 2', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=2 LIMIT 1), 'CWI', 'nde',
 'Ultrasonic testing (UT) of welds typically uses what type of sound wave?',
 'Longitudinal (compression) waves only', 'Shear (transverse) waves generated by an angle beam transducer', 'Surface (Rayleigh) waves only', 'Sound waves are not used in UT',
 'B', 'Weld inspection commonly uses shear waves generated by angle beam transducers (typically 45°, 60°, or 70° refracted angles). Shear waves allow the sound beam to intersect discontinuities oriented parallel to the weld axis.', 'ASTM E164 / ASME V Art. 4', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=2 LIMIT 1), 'CWI', 'nde',
 'The dwell time in liquid penetrant testing refers to:',
 'The time the developer is on the part', 'The time the penetrant remains on the surface to seep into discontinuities', 'The total inspection time', 'The time between cleaning and applying penetrant',
 'B', 'Dwell (penetration) time is the period during which the penetrant remains on the part surface, allowing it to enter surface-breaking discontinuities by capillary action. Minimum dwell times are specified by the procedure (typically 5-20 minutes).', 'ASTM E165', 'easy'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=2 LIMIT 1), 'CWI', 'nde',
 'In MT, indications running parallel to the magnetic field lines are:',
 'Easiest to detect', 'Difficult or impossible to detect because they do not interrupt the magnetic flux', 'Always relevant', 'Only found in nonferrous metals',
 'B', 'MT detects discontinuities that are perpendicular (or at an angle) to the magnetic field lines. Discontinuities parallel to the flux do not create significant flux leakage and may go undetected. Two magnetization directions (at least 90° apart) are required.', 'ASTM E709', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=2 LIMIT 1), 'CWI', 'nde',
 'Film density for an acceptable radiograph per AWS D1.1 must be within:',
 '0.5 to 1.5 H&D', '1.8 to 4.0 H&D through the body of the weld', '5.0 to 7.0 H&D', 'Any density is acceptable if the image is visible',
 'B', 'AWS D1.1 and ASME V require radiographic film density through the area of interest to be between 1.8 and 4.0 H&D (Hunter & Driffield) to ensure adequate contrast and sensitivity for interpretation.', 'AWS D1.1 §6.12', 'hard'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=2 LIMIT 1), 'CWI', 'nde',
 'NDE personnel qualification per ASNT SNT-TC-1A requires:',
 'No formal training', 'Documented training, experience, visual acuity, and examination (written, practical, and specific) for each level and method', 'Only manufacturer certification', 'A welding certification',
 'B', 'ASNT SNT-TC-1A requires NDE personnel to have documented training hours, experience, and pass written (general and specific) and practical examinations for each method and level. Recertification is required periodically.', 'ASNT SNT-TC-1A', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=2 LIMIT 1), 'CWI', 'nde',
 'Phased array ultrasonic testing (PAUT) differs from conventional UT in that it:',
 'Uses X-rays instead of sound', 'Uses multiple array elements that can be electronically steered and focused to create sectorial scans', 'Cannot detect planar defects', 'Requires ferromagnetic materials',
 'B', 'PAUT uses transducers with multiple small elements that can be individually pulsed with calculated time delays. This allows electronic beam steering, focusing, and scanning at multiple angles simultaneously, producing detailed cross-sectional images.', 'ASME V Art. 4 / ASTM E2491', 'hard'),

-- ============================================================
-- CWI Module 3: Code Application (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CWI' AND module_number=3 LIMIT 1), 'CWI', 'code_application',
 'Under AWS D1.1, a prequalified WPS may use which of the following processes?',
 'Any welding process', 'SMAW, SAW, GMAW (except short-circuit), and FCAW', 'GTAW only', 'Electroslag welding only',
 'B', 'AWS D1.1 §3.2 limits prequalified WPSs to SMAW, SAW, GMAW (excluding short-circuit transfer), and FCAW. Other processes require WPS qualification by testing per §4.', 'AWS D1.1 §3.2', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=3 LIMIT 1), 'CWI', 'code_application',
 'AWS D1.1 classifies welds as either:',
 'Good or bad', 'Prequalified or nonprequalified', 'Statically loaded or cyclically loaded for determining acceptance criteria', 'Structural or nonstructural',
 'B', 'D1.1 distinguishes between statically loaded and cyclically loaded structures. Cyclically loaded structures have more stringent acceptance criteria (Table 6.1) because fatigue is a greater concern.', 'AWS D1.1 §6.12', 'easy'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=3 LIMIT 1), 'CWI', 'code_application',
 'Per AWS D1.1, the minimum preheat for SMAW on ASTM A572 Grade 50 steel at 1 inch thickness is:',
 'None required', '50°F', '150°F', '300°F',
 'C', 'AWS D1.1 Table 3.2 requires minimum preheat of 150°F for Group II steels (A572 Gr 50) over 3/4 inch thick when welded with low-hydrogen processes. The preheat reduces the risk of hydrogen cracking.', 'AWS D1.1 Table 3.2', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=3 LIMIT 1), 'CWI', 'code_application',
 'Under D1.1, when a nonprequalified joint detail is used, the contractor must:',
 'Use it without any additional action', 'Qualify the WPS by testing per AWS D1.1 §4', 'Get verbal approval from the owner', 'Only perform visual inspection',
 'B', 'Non-prequalified joint configurations, processes, or conditions require WPS qualification by testing in accordance with D1.1 §4. This involves welding a test coupon and performing the required mechanical tests.', 'AWS D1.1 §4.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=3 LIMIT 1), 'CWI', 'code_application',
 'The Engineer of Record has the authority under AWS D1.1 to:',
 'Only review submittals', 'Approve or reject alternative acceptance criteria, base metals, and WPS parameters beyond the code scope', 'Waive all inspection requirements', 'Overrule OSHA regulations',
 'B', 'The Engineer (defined in D1.1 as the authority responsible for design) can approve unlisted base metals, alternative acceptance criteria, and WPS parameters outside prequalified limits. These approvals must be documented.', 'AWS D1.1 §1.4', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=3 LIMIT 1), 'CWI', 'code_application',
 'AWS D1.1 Table 6.1 acceptance criteria for statically loaded structures allows undercut depth of:',
 'No undercut is ever permitted', '1/32 inch for material less than 1 inch thick; 1/16 inch for 1 inch and greater', '1/8 inch regardless of thickness', '1/4 inch maximum',
 'B', 'D1.1 Table 6.1 allows undercut up to 1/32 inch depth for material less than 1 inch thick. For material 1 inch and over, undercut may be up to 1/16 inch deep for statically loaded structures.', 'AWS D1.1 Table 6.1', 'hard'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=3 LIMIT 1), 'CWI', 'code_application',
 'Under D1.1, a welder qualified in the 3G and 4G positions is qualified to weld in which production positions?',
 'Flat only', 'All positions (flat, horizontal, vertical, overhead)', 'Vertical up only', 'Horizontal and flat only',
 'B', 'Per D1.1 Table 4.10, a welder qualified in 3G (vertical) and 4G (overhead) plate positions is qualified for all production positions: 1G (flat), 2G (horizontal), 3G (vertical), and 4G (overhead) on plate.', 'AWS D1.1 Table 4.10', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=3 LIMIT 1), 'CWI', 'code_application',
 'The maximum interpass temperature for quenched and tempered steels under AWS D1.1 is:',
 'No limit', '400°F (200°C)', '600°F (315°C)', '800°F (425°C)',
 'B', 'AWS D1.1 limits interpass temperature to 400°F for quenched and tempered steels (e.g., A514, A517) to prevent softening of the base metal HAZ and loss of the Q&T mechanical properties.', 'AWS D1.1 §5.6', 'hard'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=3 LIMIT 1), 'CWI', 'code_application',
 'Per D1.1, repairs to base metal by welding require:',
 'No special procedures', 'A written repair procedure approved by the Engineer, using a qualified WPS', 'Only visual inspection after repair', 'Replacing the entire piece',
 'B', 'AWS D1.1 §5.14 requires that base metal repairs be made using qualified WPSs with the approval of the Engineer. The repair area must be inspected to the same acceptance criteria as the original weld.', 'AWS D1.1 §5.14', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=3 LIMIT 1), 'CWI', 'code_application',
 'AWS D1.1 requires that all groove welds in tension members of cyclically loaded structures receive:',
 'Visual inspection only', 'Visual inspection plus RT or UT (100% volumetric examination)', 'No NDE beyond visual', 'Only magnetic particle testing',
 'B', 'Cyclically loaded structures require 100% volumetric NDE (RT or UT) on all CJP groove welds in tension members to detect internal discontinuities that could initiate fatigue cracking. This is in addition to VT.', 'AWS D1.1 §6.11', 'hard'),

-- ============================================================
-- CWI Module 4: Quality Systems & Ethics (10 questions)
-- ============================================================
((SELECT id FROM m WHERE cert_level='CWI' AND module_number=4 LIMIT 1), 'CWI', 'quality',
 'A quality assurance (QA) program focuses on:',
 'Finding defects after welding', 'Preventing defects by establishing systematic processes, procedures, and verification activities', 'Purchasing cheaper materials', 'Reducing inspection staff',
 'B', 'QA is a proactive, systematic approach to quality that establishes procedures, training, and oversight to prevent defects. QC (quality control) is the reactive component that detects defects through inspection and testing.', 'AWS B5.1', 'easy'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=4 LIMIT 1), 'CWI', 'quality',
 'The primary responsibility of a CWI as defined by AWS QC1 is to:',
 'Perform welding on critical joints', 'Determine the acceptability of welds based on applicable codes and specifications', 'Design welded structures', 'Sell welding equipment',
 'B', 'Per AWS QC1, the CWI is responsible for performing visual inspection and determining the acceptability of welds and welding operations in accordance with the applicable code, standard, or specification.', 'AWS QC1 §6', 'easy'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=4 LIMIT 1), 'CWI', 'quality',
 'AWS QC1 Standard for Qualification and Certification of Welding Inspectors requires the CWI to demonstrate:',
 'Welding ability only', 'Visual acuity, education/experience, and passing a three-part examination', 'Only code knowledge', 'Management experience',
 'B', 'CWI certification per AWS QC1 requires: (1) documented visual acuity (J2 at 12 inches), (2) minimum education and experience per Table 1, and (3) passing Parts A, B, and C of the examination.', 'AWS QC1 §5', 'easy'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=4 LIMIT 1), 'CWI', 'ethics',
 'If a CWI discovers a relative or close friend is the contractor on a project they are inspecting, the CWI must:',
 'Proceed normally', 'Disclose the conflict of interest and recuse themselves from the inspection', 'Give favorable treatment', 'Inspect more strictly to compensate',
 'B', 'AWS Code of Ethics requires CWIs to avoid conflicts of interest and disclose any relationships that could compromise impartiality. The CWI must recuse themselves or obtain written acknowledgment from all parties.', 'AWS QC1 Code of Ethics', 'easy'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=4 LIMIT 1), 'CWI', 'ethics',
 'A CWI observes a welder using an electrode not specified on the WPS. The CWI should:',
 'Ignore it if the weld looks acceptable', 'Stop the welding, document the nonconformance, and require corrective action per the applicable code', 'Replace the electrode personally', 'Wait until the weld is finished to check',
 'B', 'Using materials not specified on the WPS is a code violation. The CWI must stop the operation, document the nonconformance, and ensure corrective action. Accepting the deviation would violate the inspectors professional responsibilities.', 'AWS D1.1 §6.3 / QC1', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=4 LIMIT 1), 'CWI', 'quality',
 'Document control in a welding quality system ensures:',
 'All documents are handwritten', 'Current revisions of WPSs, drawings, codes, and procedures are available at the point of use and obsolete versions are removed', 'Documents are kept only in the main office', 'Only the project manager has access',
 'B', 'Document control ensures that only current, approved versions of procedures, codes, and drawings are in use. Obsolete documents must be removed from circulation to prevent work being performed to outdated requirements.', 'AWS B5.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=4 LIMIT 1), 'CWI', 'quality',
 'A corrective action report (CAR) differs from a nonconformance report (NCR) in that:',
 'They are the same thing', 'A CAR identifies and addresses the root cause to prevent recurrence, while an NCR documents the specific nonconforming condition', 'A CAR is less formal', 'An NCR requires root cause analysis but a CAR does not',
 'B', 'An NCR documents a specific deficiency. A CAR goes further by requiring root cause analysis and implementing systemic changes to prevent the same type of nonconformance from recurring. Both are essential quality system tools.', 'AWS B5.1', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=4 LIMIT 1), 'CWI', 'ethics',
 'AWS Code of Ethics requires the CWI to:',
 'Accept gifts from contractors for favorable inspections', 'Act with integrity, objectivity, and professional competence in all inspection activities', 'Apply different standards based on the contractors reputation', 'Disclose proprietary information freely',
 'B', 'The AWS Code of Ethics mandates that CWIs conduct themselves with integrity, remain objective and impartial, maintain professional competence through continued education, and not accept anything that could compromise their judgment.', 'AWS QC1 Annex B', 'easy'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=4 LIMIT 1), 'CWI', 'quality',
 'Calibration of welding inspection equipment (fillet gauges, thermometers, UT instruments) must be:',
 'Performed only when equipment appears damaged', 'Performed at defined intervals with records traceable to national standards', 'Done once at purchase', 'Not required for visual inspection tools',
 'B', 'Inspection equipment must be calibrated at defined intervals per the quality system procedures. Calibration must be traceable to NIST or equivalent national standards, and records must document dates, results, and due dates.', 'AWS B5.1 / ISO 17025', 'medium'),

((SELECT id FROM m WHERE cert_level='CWI' AND module_number=4 LIMIT 1), 'CWI', 'ethics',
 'If a CWI is pressured by a contractor to accept a weld that does not meet code requirements, the CWI should:',
 'Accept it to maintain the project schedule', 'Reject the weld, document the nonconformance, and report any undue pressure through proper channels', 'Negotiate a compromise acceptance standard', 'Ignore the situation and let someone else decide',
 'B', 'The CWI has a professional and ethical obligation to enforce the applicable code impartially. Pressure to accept substandard work must be resisted and reported. The CWI should document everything and escalate through proper channels.', 'AWS QC1 Code of Ethics', 'medium');
