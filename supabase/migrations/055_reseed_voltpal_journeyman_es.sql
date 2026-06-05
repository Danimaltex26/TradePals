-- 055_reseed_voltpal_journeyman_es.sql
-- Re-seed Spanish translations for the VoltPal Journeyman public quiz.
--
-- WHY THIS EXISTS: migration 051 seeded content_es on 10 Journeyman questions by
-- hardcoded UUID. Migration 053 (full REPLACE) then deleted and regenerated every
-- VoltPal question with fresh UUIDs AND different question wording, orphaning 051's
-- updates — content_es ended up 0 rows live and the original English questions no
-- longer exist. This migration translates 10 CURRENT Journeyman questions (verified
-- present, flagged_quality = false on 2026-06-05) so /api/public-quiz/journeyman?lang=es
-- has real, matching content again.
--
-- IMPORTANT: All translations are Claude-drafted Mexican Spanish and require
-- native-speaker review before broad launch. Source + review log: c:/tmp/spanish-translations.json
--
-- Translation conventions (per VoltPal Spanish brief):
--   - Cert names stay English: Journeyman, NEC, IBEW, OSHA, UL
--   - Code references stay English: §250.28, Table 250.102(C)(1), Article 376, §392.10
--   - AWG sizes, kcmil, ampere/mA values, percentages stay English/numeric
--   - Mexican Spanish dialect (US trades audience)
--   - Term choices: "puesta a tierra" = grounding; "puente de unión" = bonding jumper;
--     "conductor puesto a tierra (neutro)" = grounded conductor (neutral);
--     "canalización" = raceway; "charola portacables" = cable tray;
--     "busway" and "wireway" kept (with a Spanish descriptor on first use)
--
-- Idempotent: UPDATE ... WHERE id (+ cert_level guard). A post-check asserts exactly
-- 10 Journeyman rows carry content_es so a future regression fails LOUDLY, not silently.

-- 1) continuous load definition — NEC 100
update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Una carga continua se define en el Artículo 100 del NEC como una carga:',
  'option_a', 'Que consume corriente en cualquier momento',
  'option_b', 'Mayor de 50 amperios',
  'option_c', 'Que consume corriente las 24 horas, los 7 días',
  'option_d', 'Donde se espera que la corriente máxima se mantenga durante 3 horas o más',
  'explanation', 'Definición del Artículo 100 del NEC: carga continua = corriente máxima que se mantiene durante 3 horas o más. Este es el detonante de la regla de dimensionamiento al 125% en §210.19/210.20/215.2/230.42. Las demás opciones usan umbrales que no están en la definición.'
) where id = 'cb7d411b-4256-4098-90f7-955ac476a6d4' and cert_level = 'JOURNEYMAN';

-- 2) branch-circuit conductor sizing for continuous loads — NEC 210.19
update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', '¿Cuál es la ampacidad mínima requerida para los conductores de circuito ramal que alimentan cargas continuas según el NEC 2026 §210.19(A)?',
  'option_a', '100% de la carga continua',
  'option_b', '150% de la carga continua',
  'option_c', '80% de la carga continua',
  'option_d', '125% de la carga continua más 100% de cualquier carga no continua',
  'explanation', 'NEC 2026 §210.19(A)(1): los conductores de circuito ramal deben dimensionarse al 125% de la carga continua más 100% de la carga no continua. El factor de 125% considera los efectos térmicos de la corriente sostenida. La opción A subdimensiona; la opción C sobredimensiona (se usa en algunas aplicaciones especiales); la opción D invierte la regla.'
) where id = 'b0becd1e-76f0-46da-b1fe-ec1d3204080c' and cert_level = 'JOURNEYMAN';

-- 3) Class A GFCI trip threshold — NEC 210.8
update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Según el NEC 2026 §210.8, ¿cuál es el umbral de disparo de un dispositivo GFCI Clase A?',
  'option_a', '20–30 miliamperios',
  'option_b', '50–100 miliamperios',
  'option_c', '4–6 miliamperios',
  'option_d', '1 amperio',
  'explanation', 'El disparo de un GFCI Clase A es de 4–6 mA, muy por debajo del umbral de fibrilación ventricular. Es un estándar de UL 943 referenciado por el NEC. La opción A corresponde a la Clase B (la Clase A es mucho más sensible). Las opciones B y D son demasiado altas para proteger a las personas.'
) where id = '4558f00e-b4e3-48a5-b187-8cdc45337a45' and cert_level = 'JOURNEYMAN';

-- 4) main bonding jumper function — NEC 250.28
update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Según el NEC §250.28, el puente principal de unión (main bonding jumper):',
  'option_a', 'Conecta el conductor puesto a tierra (neutro) al sistema de puesta a tierra del equipo en el medio de desconexión del servicio, estableciendo el punto de conexión que fija la referencia del sistema a tierra',
  'option_b', 'Conecta el tablero al armazón del equipo únicamente',
  'option_c', 'Es opcional',
  'option_d', 'Está en el medidor',
  'explanation', '§250.28: el puente principal de unión va en el medio de desconexión del servicio. Esta es LA única conexión entre el neutro y la tierra en un sistema típico de instalación eléctrica de un inmueble.'
) where id = '1fe535fa-a3bb-4c3d-8280-4e31772a3457' and cert_level = 'JOURNEYMAN';

-- 5) main bonding jumper sizing — NEC 250.28(D)
update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Según §250.28(D), el tamaño del puente principal de unión (main bonding jumper) se determina a partir de:',
  'option_a', 'Siempre 6 AWG',
  'option_b', 'El amperaje del servicio',
  'option_c', 'El tamaño de la varilla de tierra',
  'option_d', 'La misma Tabla 250.102(C)(1) que se usa para los puentes de unión del lado de línea — con base en el tamaño del conductor de servicio sin puesta a tierra más grande (o el área combinada en juegos en paralelo)',
  'explanation', '§250.28(D) / Tabla 250.102(C)(1): el main bonding jumper se dimensiona igual que el puente de unión del lado de línea. Conductores de entrada de servicio más grandes requieren un puente principal de unión más grande.'
) where id = 'f7408c3a-63dc-409e-9644-8b6764d65d91' and cert_level = 'JOURNEYMAN';

-- 6) supply-side bonding jumper — NEC 250.102
update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Un puente de unión del lado de línea (supply-side bonding jumper) conecta el lado de tierra del equipo a:',
  'option_a', 'Solo al equipo de servicio',
  'option_b', 'Solo al lado de carga',
  'option_c', 'Solo a las varillas de tierra',
  'option_d', 'El conductor puesto a tierra en el lado de línea del medio de desconexión del servicio, dimensionado según la Tabla 250.102(C)(1)',
  'explanation', '§250.102(C): el puente de unión del lado de línea va del lado de línea del medio de desconexión del servicio. Conecta los gabinetes metálicos, el conducto, etc., al conductor puesto a tierra antes del puente principal de unión (main bonding jumper).'
) where id = '7c0b8f70-b03b-4bae-a495-f588edb355be' and cert_level = 'JOURNEYMAN';

-- 7) busway permitted locations — NEC 368.10
update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', '¿En qué ubicaciones se permite el busway (barras prefabricadas) según §368.10?',
  'option_a', 'Solo en exteriores',
  'option_b', 'En ubicaciones expuestas y oculto en espacios de manejo de aire bajo condiciones limitadas; no en ubicaciones húmedas o mojadas a menos que esté identificado para ese uso',
  'option_c', 'Solo en residencias',
  'option_d', 'En cualquier lugar sin restricciones',
  'explanation', '§368.10/368.12: el busway se instala principalmente expuesto; algunos tipos permiten ocultarse. Las ubicaciones mojadas/húmedas requieren una identificación (listado) especial.'
) where id = 'eddd2d1e-18be-4fc6-8a6a-091880db88ae' and cert_level = 'JOURNEYMAN';

-- 8) busway tap conductors of unlimited length — NEC 368.17
update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Según §368.17, los conductores de derivación (tap) de busway de longitud ilimitada se permiten cuando:',
  'option_a', 'Los conductores de derivación tienen una ampacidad igual a la del busway y terminan en un solo dispositivo de sobrecorriente (OCPD) que limita la carga de la derivación a su ampacidad',
  'option_b', 'En cualquier condición',
  'option_c', 'Solo en residencias',
  'option_d', 'Nunca se permite',
  'explanation', '§368.17: derivación ilimitada si la ampacidad del conductor ≥ la ampacidad del busway Y termina en un solo OCPD que limita la carga a la ampacidad de la derivación. Las derivaciones más cortas tienen condiciones diferentes.'
) where id = '81908b30-4ca1-4b6b-a4bc-bb1f37ca8fd2' and cert_level = 'JOURNEYMAN';

-- 9) metal wireway fill percentage — NEC 376.22
update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Las canalizaciones metálicas tipo wireway del Artículo 376 se permiten contener conductores que llenen no más de qué porcentaje de la sección transversal del wireway?',
  'option_a', '20%',
  'option_b', '30%',
  'option_c', '40%',
  'option_d', '53%',
  'explanation', '§376.22(A): el llenado máximo de un wireway metálico es 20% (menor que el llenado típico de un conducto, porque los wireways son canalizaciones grandes y abiertas que contienen muchos circuitos). Las demás opciones describen el conducto u otras reglas.'
) where id = '8e4bc89b-3926-4929-aab9-f50260b12b6e' and cert_level = 'JOURNEYMAN';

-- 10) cable tray as a support system — NEC 392.10
update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Según §392.10, la charola portacables (cable tray) puede usarse como un sistema de soporte para:',
  'option_a', 'Solo cable Tipo MC',
  'option_b', 'Cables y canalizaciones de entrada de servicio, alimentadores, circuitos ramales, comunicación, control, señalización y otros cables y canalizaciones listados',
  'option_c', 'Solo cables de datos',
  'option_d', 'Solo dentro de muros terminados',
  'explanation', '§392.10: la charola portacables soporta una amplia variedad de tipos de cable permitidos.'
) where id = '54966455-ea9d-4afa-8c6d-2322c880dd16' and cert_level = 'JOURNEYMAN';

-- Post-check: fail loudly if the expected 10 Journeyman translations are not present
-- (e.g., if a future full-replace seed re-UUIDs the bank again, as 053 did).
do $$
declare
  n integer;
begin
  select count(*) into n
  from voltpal.training_questions
  where cert_level = 'JOURNEYMAN' and content_es is not null;
  if n <> 10 then
    raise exception 'Expected 10 Journeyman content_es rows after 055, found %. The target question UUIDs may have changed (re-seed regression). Re-map against current rows.', n;
  end if;
end $$;
