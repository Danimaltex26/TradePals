import ProductPage from '../../../components/ProductPage'

// Spanish (Mexican) version of the VoltPal product page.
// TODO[native-speaker review]: every Spanish string here is Claude-drafted.
// Have a native speaker review before public launch — Mexican Spanish dialect
// for US trades audience. Cert names (Journeyman, NEC, IBEW, OSHA), code
// references (Article 250, NEC 250.28(A)), AWG sizes, and BLS SOC codes stay
// in English per the VoltPal Spanish brief.

export default function VoltPalProductEs() {
  return (
    <ProductPage
      app="voltpal"
      lang="es"
      languageToggle={{ enPath: '/voltpal', esPath: '/voltpal/es', currentLang: 'es' }}
      metaTitle="VoltPal — Asistente AI para Electricistas + NEC 2026 + Preparación Journeyman"
      metaDescription="Pasa Journeyman a la primera. Gana el boom de los data centers. VoltPal es el asistente AI de campo para electricistas — diagnóstico de tableros, troubleshooting de motores y preparación para el examen de licencia, todo en una sola app."
      pathOverride="/voltpal/es"
      // Cert-first hero — Mexican Spanish translation of the English Option-A hook
      certPrepLink={{ path: '/voltpal/journeyman', label: 'Ver la página completa de preparación Journeyman' }}
      certHook="Pasa Journeyman a la primera. Gana el boom de los data centers."
      certSubhook="Journeyman paga $25K+ más al año que aprendiz. VoltPal te lleva ahí."
      description="Asistente AI para electricistas + NEC 2026 + preparación para el examen Journeyman. Hecho para aprendices, journeymen y master electricians. Diagnostica tableros, soluciona motores y VFDs, consulta código, y estudia para el examen — todo desde tu teléfono."
      quizUrl="https://voltpal.tradepals.net/es/journeyman-practice"
      stats={[
        { value: '81,000/año', label: 'Vacantes de electricista hasta 2034', source: 'BLS Occupational Outlook (SOC 47-2111)' },
        { value: '+$25K/año', label: 'Diferencia de pago Journeyman vs aprendiz', source: 'BLS 2024 mediana + encuestas de la industria' },
        { value: '45–70%', label: 'Del costo de un data center es eléctrico', source: 'CBRE / encuestas de la industria' },
        { value: '+$10/hora', label: 'Premio salarial IBEW (sindicato)', source: 'Datos de PTTI / NEIEP' },
      ]}
      salaryBlock={{
        uncertifiedRange: '$30K–$55K',
        certifiedRange: '$55K–$75K',
        sourceLabel: 'BLS SOC 47-2111 (mediana 2024: $62,350) + encuestas salariales de IBEW/NECA',
        note: 'La licencia Journeyman es el mayor multiplicador de pago en el oficio — +$25K/año sobre aprendiz. Los master electricians ganan $75K–$100K+, especialmente en energía renovable e industrial. Los electricistas sindicalizados (IBEW) ganan ~$10/hora más que los no sindicalizados, con paquetes totales de compensación 30–40% más altos en mercados grandes. Con 81,000 vacantes al año hasta 2034 y un crecimiento del 9%, los electricistas con licencia están en un mercado de vendedor.',
      }}
      certTrustLine="Basado en NEC 2026 · Aprendiz · Journeyman · Master Electrician · NFPA 70E"
      validationNote="Cada pregunta del examen y referencia de código está validada con la edición 2026 del Código Eléctrico Nacional (NEC) — la edición vigente."
      longDescription={`El oficio eléctrico va desde el cambio de un tablero residencial hasta la puesta en marcha de un VFD industrial — y el NEC se hace más grueso con cada ciclo. Un aprendiz que cablea su primer sub-tablero necesita conocer el dimensionamiento de conductores, la coordinación de interruptores y los requisitos de puesta a tierra. Un journeyman diagnosticando una falla a tierra de un VFD necesita saber si meggear el motor o revisar el cable antes de reiniciar. El conocimiento requerido es enorme, y las consecuencias de equivocarse son serias.

VoltPal cubre todo el espectro. Fotografía un tablero, un contactor quemado, una placa de motor o un display de VFD disparado y obtén un diagnóstico instantáneo con referencias al código NEC y rangos de severidad. El asistente de troubleshooting cubre 27 tipos de equipos — desde tomacorrientes residenciales GFCI y ventiladores de techo hasta PLCs industriales y desconexiones de media tensión — con guía específica para Allen-Bradley, Siemens, ABB, Eaton, Square D y docenas más.

La calculadora de calibre de conductor toma en cuenta tanto la ampacidad (NEC 310.16) como la caída de tensión — mostrándote cuándo un tramo largo requiere subir de calibre más allá del mínimo del código. La calculadora de llenado de conducto maneja las tablas del Capítulo 9 del NEC para que no tengas que hacerlo tú. Las tablas de FLA de motores cubren monofásico y trifásico con las reglas de dimensionamiento del NEC 430 que confunden incluso a electricistas con experiencia.

Desde un aprendiz de primer año estudiando para su examen estatal hasta un master electrician cotizando una actualización de servicio, VoltPal es el libro de código, la tarjeta de referencia y el técnico senior — todo en una sola aplicación.`}
      features={[
        'Preparación para examen Aprendiz, Journeyman, Master, NFPA 70E — simulacros cronometrados, ejercicios enfocados, puntaje de preparación',
        'Diagnóstico de tableros y fallas por foto — violaciones de código, marcas de quemadura, cableado incorrecto',
        'Troubleshooting — 27 tipos de equipo, 200+ marcas/modelos',
        'Calculadora de calibre de conductor — ampacidad + caída de tensión, cobre y aluminio',
        'Calculadora de llenado de conducto — NEC Capítulo 9, EMT/IMC/RMC',
        'Tablas de FLA de motores — monofásico y trifásico, reglas del NEC 430',
        'Referencia del código NEC — GFCI, AFCI, puesta a tierra, sobrecorriente, circuitos de motores',
        'Referencia de seguridad de arco eléctrico / LOTO — categorías de PPE del NFPA 70E',
        'Cola de fotos sin conexión — capturas en sitio, se procesan al conectarse',
      ]}
      screenshots={[
        { label: 'Análisis de Tablero / Falla', beforeTitle: 'Foto del tablero o falla', afterTitle: 'Violaciones de código + rango de severidad' },
        { label: 'Troubleshooting VFD / Motor', beforeTitle: 'Captura código de falla y equipo', afterTitle: 'Causa raíz + pasos de reparación' },
      ]}
    />
  )
}
