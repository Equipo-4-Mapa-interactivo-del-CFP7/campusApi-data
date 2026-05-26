# Feature: paola_eficiencia.feature
# Paola (estudiante) necesita buscar aula en <2 segundos

Feature: Paola busca aula sin perder tiempo
  Background:
    Given Paola es ESTUDIANTE EPS
    And está en CFP N°7 a las 8:15 (clase en 5 minutos)

  Scenario: Búsqueda exitosa de aula
    When Paola abre la app
    And ingresa "Aula 301"
    And presiona buscar
    Then obtiene respuesta en menos de 2 segundos
    And ve texto claro: "Pabellón 1, Lado Derecho, Pasillo 3"
    And ve aula enfrentada: "302"
    And NO necesita hacer scroll
    And NO ve campos innecesarios

  Scenario: Búsqueda con resultado no encontrado
    When Paola busca "Aula 999"
    Then obtiene respuesta en menos de 2 segundos
    And ve "Aula no encontrada"
    And ve sugerencia: "¿Tal vez Aula 301?"

  Scenario: Cambio de aula reportado
    When Paola busca "Aula 301"
    And la aula cambió de ubicación
    Then ve notificación: "Esta aula se movió"
    And ve ubicación nueva
    And se actualiza automáticamente

---

# Feature: maria_certeza.feature
# María (IREP) necesita CERTEZA de poder acceder

Feature: María verifica accesibilidad (Certeza)
  Background:
    Given María es VISITANTE con movilidad reducida
    And usa silla de ruedas

  Scenario: Consulta accesibilidad = GARANTIZADO
    When María pregunta "¿Puedo acceder a Aula 301?"
    Then respuesta es CERTEZA: "GARANTIZADO" (nunca "probablemente")
    And ve: "✓ Rampa en entrada"
    And ve: "✓ Pasillo 7.72m (apto para silla)"
    And ve: "✓ Baño adaptado a 30m"
    And ve: "Ruta: Entrada rampa → Pasillo recto → Aula 301"
    And María CONFÍA en que puede ir

  Scenario: Consulta accesibilidad = NO ACCESIBLE
    Given María está en Pabellón 3
    When consulta "¿Puedo acceder a Aula 501?"
    Then respuesta es CERTEZA: "NO ACCESIBLE"
    And motivo: "Escaleras sin rampa alternativa"
    And ve aula ALTERNATIVA accesible
    And NO dice "tal vez" o "probablemente"

  Scenario: Consulta baño adaptado
    When María pregunta "¿Dónde baño adaptado?"
    Then ve ubicación exacta con distancia
    And ve ruta accesible hasta baño
    And ve que baño está VALIDADO (no asumir)

---

# Feature: federico_claridad.feature
# Federico (dificultad cognitiva) necesita instrucciones CLARAS

Feature: Federico navega sin confusión
  Background:
    Given Federico es ESTUDIANTE con dificultad cognitiva
    And está buscando Aula 302

  Scenario: Instrucción clara sin ambigüedad
    When Federico solicita recorrido a Aula 302
    Then Paso 1: "Entra por puerta principal. Camina 30m recto."
    And Paso 2: "Verás 4 aulas a la IZQUIERDA (301, 303, 305, 307)."
    And Paso 3: "Tu aula es 302, puerta DERECHA (número azul)."
    And cada paso es MÁXIMO 1 frase
    And CADA paso tiene: lado explícito + número + referencia visual
    And NO ve: "tal vez", "aproximadamente", "por ahí"

  Scenario: Referencia visual clara
    When Federico ve Paso 2 del recorrido
    Then describe qué VER: "Puerta marrón con número azul"
    And NO dice "puerta normal" (es ambiguo)
    And NO dice "sigue al fondo" (es ambiguo)

  Scenario: Ambigüedad score = 0
    When se genera instrucción para Federico
    Then ambiguedad_score = 0 (perfecto)
    And tiene_lado_explicito = TRUE
    And tiene_numero_referencia = TRUE
    And tiene_referencia_visual = TRUE

---

# Feature: camilo_minimalismo.feature
# Camilo (docente) necesita info sin saturarse

Feature: Camilo no se satura de información
  Background:
    Given Camilo es DOCENTE
    And abre app desde su escritorio

  Scenario: Respuesta minimalista
    When Camilo busca "Aula 301"
    Then respuesta tiene MÁXIMO 5 campos:
      | Campo | Contenido |
      | Nombre | Aula 301 |
      | Ubicación | Pabellón 1, Lado Derecho, Pasillo 3 |
      | Disponibilidad | 09:00-12:00 Gastronomía |
      | Baño cercano | 15m, patio |
      | Acceso | Rampa disponible |
    And información CABE en pantalla (SIN scroll)
    And tiempo respuesta < 500ms

  Scenario: Sin sobrecarga
    When Camilo ve respuesta
    Then NO ve: horarios detallados
    And NO ve: lista de estudiantes
    And NO ve: documentos adjuntos
    And NO ve: más de 5 líneas

  Scenario: Campo perfecto para Camilo
    When busca aula
    Then disponibilidad está en formato claro: "09:00-12:00 Gastronomía"
    And NO ve: "MANANA_EPS_2024_201_GRUPO1"

