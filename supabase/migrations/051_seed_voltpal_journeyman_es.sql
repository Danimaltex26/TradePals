-- Seed Spanish translations for 10 Journeyman diagnostic questions.
-- These are the questions surfaced by /api/public-quiz/journeyman?lang=es (Phase 1).
--
-- IMPORTANT: All translations are Claude-drafted Mexican Spanish and require
-- native-speaker review before public launch. See c:/tmp/spanish-translations.json
-- for the source and the per-string review log.
--
-- Translation conventions (per VoltPal Spanish brief):
--   - Cert names stay in English: Journeyman, NEC, IBEW, OSHA
--   - Code references stay in English: Article 250, NEC 250.28(A), Table 250.66
--   - AWG sizes, kcmil values, ampere ratings stay English/numeric
--   - Mexican Spanish dialect (US trades audience)
--   - Term choices: "puesta a tierra" for grounding; "puente de unión" for bonding jumper

update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Según el Artículo 250, ¿cuál es el propósito principal de la puesta a tierra de los sistemas eléctricos?',
  'option_a', 'Proporcionar una trayectoria para la corriente de falla y limitar la tensión a tierra',
  'option_b', 'Reducir el ruido eléctrico y la interferencia',
  'option_c', 'Aumentar la eficiencia del sistema y reducir las pérdidas de potencia',
  'option_d', 'Evitar la acumulación de electricidad estática',
  'explanation', 'El Artículo 250.4(A)(1) establece que la puesta a tierra de los sistemas eléctricos sirve para limitar la tensión a tierra durante la operación normal y proporcionar una trayectoria para la corriente de falla. La opción B es incorrecta porque la reducción de ruido no es la función principal de la puesta a tierra. La opción C es incorrecta — la puesta a tierra no afecta directamente la eficiencia del sistema. La opción D, aunque relacionada con la seguridad eléctrica, no es el propósito principal según el NEC.'
) where id = '1a405ab7-d8a9-4a7c-8446-e853e81daf15';

update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', '¿Cuál es el requisito mínimo de tamaño para los puentes principales de unión (main bonding jumpers) en el equipo de servicio?',
  'option_a', 'Basado en el tamaño del conductor de entrada de servicio más grande',
  'option_b', 'Siempre 6 AWG como mínimo',
  'option_c', 'Basado en la Tabla 250.122',
  'option_d', 'Del mismo tamaño que el conductor del electrodo de puesta a tierra',
  'explanation', 'La Sección 250.28(A) requiere que los puentes principales de unión se dimensionen según la Tabla 250.66, la cual se correlaciona con el tamaño del conductor de entrada de servicio (sin puesta a tierra) más grande. La opción B es incorrecta porque, aunque 6 AWG puede ser el tamaño mínimo en algunos casos, no aplica universalmente. La opción C se refiere a conductores de puesta a tierra del equipo, no a los puentes principales de unión. La opción D confunde dos requisitos distintos.'
) where id = '37c0a99c-3d79-4446-ba38-6169b14112b3';

update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Un electricista está instalando un puente principal de unión para un servicio de 400 amperios con tres juegos de conductores de entrada de servicio de cobre 500 kcmil en paralelo. ¿Cuál es el tamaño mínimo de puente principal de unión de cobre requerido?',
  'option_a', '2/0 AWG',
  'option_b', '3/0 AWG',
  'option_c', '350 kcmil',
  'option_d', '500 kcmil',
  'explanation', 'Según NEC 250.28(D) y la Tabla 250.102(C)(1), el puente principal de unión debe dimensionarse en función del área del conductor de entrada de servicio más grande del lado de línea del medio de desconexión del servicio. Con tres juegos de 500 kcmil en paralelo, el área total es 1500 kcmil. La tabla requiere un puente de cobre de 350 kcmil para esa área.'
) where id = '7924cd1f-3fa4-46bd-8cf6-6fc8b844cae8';

update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Está diagnosticando una instalación donde equipos electrónicos sensibles experimentan apagones frecuentes durante tormentas eléctricas. El edificio tiene un electrodo embebido en concreto, varillas de tierra y electrodo de tubería de agua, todos correctamente unidos entre sí. Las pruebas de corriente de falla a tierra muestran operación correcta, pero las lecturas de impedancia entre los distintos electrodos varían de manera significativa. ¿Cuál es la causa más probable de los problemas con el equipo?',
  'option_a', 'El electrodo embebido en concreto se ha deteriorado y necesita reemplazo',
  'option_b', 'El tamaño insuficiente de los puentes de unión entre electrodos distintos está causando diferencias de potencial',
  'option_c', 'El espaciamiento de las varillas de tierra es incorrecto y crea patrones de interferencia',
  'option_d', 'El electrodo de tubería de agua está creando corrosión galvánica con los demás electrodos',
  'explanation', 'Los distintos electrodos de puesta a tierra naturalmente tienen impedancias variables a tierra debido a las condiciones del suelo, el tipo de electrodo y los factores de instalación. Cuando los puentes de unión entre electrodos están subdimensionados respecto a los requisitos del NEC, pueden surgir diferencias de potencial significativas — especialmente durante eventos transitorios como rayos. Esto crea problemas para equipos electrónicos sensibles aunque las pruebas básicas de continuidad de falla salgan bien.'
) where id = 'e364f2f0-dddb-4218-9e26-2b3e6d835b76';

update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Los sistemas de busway (barras prefabricadas) se utilizan principalmente en aplicaciones comerciales e industriales porque ofrecen:',
  'option_a', 'Costos de instalación más bajos que el conducto',
  'option_b', 'Flexibilidad para modificaciones futuras',
  'option_c', 'Mejor regulación de tensión',
  'option_d', 'Corrección de factor de potencia mejorada',
  'explanation', 'Los sistemas de busway se valoran principalmente por su flexibilidad, ya que permiten reconfiguraciones sencillas y la adición de puntos de derivación (tap-off) conforme cambian las necesidades de la instalación. La opción A es a menudo incorrecta porque el busway típicamente tiene mayor costo inicial que el conducto. Las opciones C y D no son ventajas inherentes del busway sobre otros métodos de distribución.'
) where id = 'ae5de6cd-216b-4b29-bad8-4c8bcc1a36cc';

update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Un contratista está instalando una conexión de derivación (tap) de alimentador a un sistema de busway existente de 800 amperios en una bodega. Los conductores de derivación tienen 25 pies de longitud y alimentarán un tablero de 200 amperios. ¿Cuál es la ampacidad mínima requerida para los conductores de derivación?',
  'option_a', '160 amperios',
  'option_b', '200 amperios',
  'option_c', '240 amperios',
  'option_d', '267 amperios',
  'explanation', 'Según NEC 368.17(C), los conductores de derivación de busway deben tener una ampacidad no menor a un tercio de la capacidad del dispositivo de sobrecorriente que protege el busway, o no menor a la ampacidad del conductor del lado de carga, lo que sea mayor. Un tercio de 800 A equivale a 267 A, lo cual rige sobre los 200 A del tablero de carga.'
) where id = 'da3e11e6-0d4d-4282-a12f-911ce4a333ab';

update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Un electricista necesita determinar el llenado máximo para una canalización tipo wireway de 6" × 6" que contendrá conductores 12 AWG THWN y 10 AWG THWN. Si hay 15 conductores de cada calibre (12 AWG y 10 AWG), ¿cuál es el área total de sección transversal de los conductores?',
  'option_a', '1.89 pulgadas cuadradas',
  'option_b', '2.16 pulgadas cuadradas',
  'option_c', '2.43 pulgadas cuadradas',
  'option_d', '2.70 pulgadas cuadradas',
  'explanation', 'Del NEC Capítulo 9, Tabla 5: 12 AWG THWN = 0.0133 pulg², 10 AWG THWN = 0.0211 pulg². El área total = (15 × 0.0133) + (15 × 0.0211) = 0.1995 + 0.3165. Consulte la Tabla 4 del NEC y los factores de llenado del Artículo 376.22 para los wireways.'
) where id = 'e673fc28-8552-41e5-a7cc-9c8959690923';

update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Una instalación industrial está montando un nuevo sistema de busway de 800A para alimentar varias máquinas. El tramo de busway tiene 200 pies con cajas de derivación cada 25 pies. Durante la puesta en marcha, el electricista observa una caída de tensión significativa y calentamiento en las juntas. Las lecturas de temperatura muestran que las juntas están 40°C sobre el ambiente, mientras que los tramos rectos permanecen fríos. ¿Cuál debe ser la acción correctiva principal?',
  'option_a', 'Aumentar la capacidad del busway a 1000A',
  'option_b', 'Instalar ventilación adicional alrededor de todo el tramo de busway',
  'option_c', 'Desarmar y aplicar el torque correcto a todas las conexiones empernadas',
  'option_d', 'Reducir la carga a 640A (80% de la capacidad)',
  'explanation', 'El calentamiento localizado en las juntas mientras los tramos rectos permanecen fríos indica conexiones de alta resistencia debido a torque incorrecto en los pernos o superficies de contacto contaminadas. Este es un síntoma clásico de mala calidad de conexión y es el punto de falla más común en sistemas de busway. La solución correcta es desarmar las juntas, limpiar las superficies de contacto y volver a apretar al torque especificado por el fabricante.'
) where id = 'cbeb26ca-6c17-44e2-b91a-1dba4e7e67b7';

update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Según el Artículo 392 del NEC, ¿cuál es la deflexión (sag) máxima permitida para tramos de charola portacables (cable tray) entre soportes?',
  'option_a', '1 pulgada en 8 pies',
  'option_b', '1 pulgada en 10 pies',
  'option_c', '1 pulgada en 12 pies',
  'option_d', '1 pulgada en 15 pies',
  'explanation', 'El Artículo 392 del NEC especifica que las charolas portacables no deben tener una deflexión que exceda 1 pulgada en 12 pies entre soportes. Este requisito asegura la integridad estructural y el soporte adecuado de los cables. Una deflexión excesiva puede causar estrés en los cables y dañar el sistema con el tiempo.'
) where id = 'c7131d93-05f4-4e2d-a62e-ac92eb1219de';

update voltpal.training_questions set content_es = jsonb_build_object(
  'question_text', 'Según el Artículo 392 del NEC, los sistemas de charola portacables (cable tray) tienen permitido soportar ¿cuál de las siguientes opciones?',
  'option_a', 'Solo cables de potencia',
  'option_b', 'Solo cables de control',
  'option_c', 'Cables, canalizaciones (raceways) y cajas',
  'option_d', 'Solo conductores individuales',
  'explanation', 'El Artículo 392 del NEC permite que los sistemas de charola portacables soporten cables, canalizaciones y cajas según lo especificado en el artículo. La opción A es demasiado restrictiva porque las charolas pueden soportar más que solo cables de potencia. La opción B es incorrecta por la misma razón. La opción D excluye conductores tipo cable multiconductor, los cuales sí están permitidos.'
) where id = '299bd403-dcb3-4376-8a97-4e03430fa323';
