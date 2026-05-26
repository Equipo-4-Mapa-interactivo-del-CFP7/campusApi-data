# [S1-S1] Definir métricas relevantes #21

## Descripción
Definir 15 KPIs de éxito para CampusMap que conecten necesidades UX reales (Paola, Camilo, María, Federico) con objetivos técnicos de Backend/QA.

---

## 🧠 CONTEXTO UX (4 PERSONAS REALES)

### Necesidades Críticas:
- **PAOLA (Estudiante):** Buscar aula sin perder tiempo (clase en 5 min)
- **CAMILO (Docente):** No saturarse de información
- **MARÍA (IREP):** CERTEZA de poder acceder (sin incertidumbre)
- **FEDERICO (Dificultad cognitiva):** Pasos claros SIN ambigüedad

---

## 📊 15 KPIs PRIORIZADAS

### Métrica 1: Tiempo de Búsqueda (Para PAOLA)
- **Definición:** Promedio ms desde search_initiated → resultado_visible
- **Target:** <2000ms (debe ser rápido)
- **Por qué:** Paola no tolera demora (pierde clase a las 8:30)
- **Medición:** SELECT AVG(response_time_ms) FROM eventos_tracking WHERE evento='search_aula'
- **Endpoint:** POST /api/v1/espacios/search
- **Aceptación:** response_time <= 2000ms en 95% de casos

### Métrica 2: Claridad de Instrucciones (Para FEDERICO)
- **Definición:** % pasos SIN ambigüedad + con referencia visual
- **Target:** 100% (crítica para discapacidad cognitiva)
- **Validación:**
  - ✅ Contiene lado explícito: IZQUIERDA o DERECHA
  - ✅ Contiene número de aula/pasillo
  - ✅ Contiene referencia visual (color, piso, característica)
  - ❌ NO contiene: "tal vez", "aproximadamente", "cerca"
- **Medición:** SELECT * FROM pasos_recorrido WHERE ambiguedad_score = 0
- **Aceptación:** 100% pasos con ambiguedad_score = 0

### Métrica 3: Completitud de Accesibilidad (Para MARÍA)
- **Definición:** % espacios con 100% campos a11y documentados
- **Target:** 100% (NO NEGOCIABLE - derecho de María)
- **Campos obligatorios:**
  - rampa_entrada (boolean)
  - baño_adaptado_cercano (boolean)
  - distancia_baño_adaptado_metros (number)
  - ancho_pasillo_minimo_cm (number) → ¿entra silla de ruedas (80cm)?
  - tiene_escaleras (boolean)
  - escaleras_tienen_rampa_alternativa (boolean)
  - validado_accesibilidad (boolean)
  - garantia_acceso_total (boolean)
- **Aceptación:** 0 espacios sin datos a11y

### Métrica 4: Sobrecarga Cognitiva (Para CAMILO)
- **Definición:** % respuestas que NO requieren scroll
- **Target:** >80%
- **Límite:** Max 5 líneas de contenido por respuesta
- **Medición:** SELECT COUNT(*) WHERE requiere_scroll = false
- **Endpoint:** GET /api/v1/espacios/{id}?perfil=docente
- **Aceptación:** Max 5 campos por respuesta, cabe en pantalla

### Métrica 5: Tasa de Certeza de Acceso (Para MARÍA)
- **Definición:** (usuarios que consultan a11y Y logran navegar / total consultas) × 100
- **Target:** 95%
- **Por qué:** Si María consulta accesibilidad, debe poder acceder
- **Medición:** Track evento accesibilidad_consultada → navegacion_completada
- **Aceptación:** 95% de usuarios que consultan a11y logran completar recorrido

### Métrica 6: Navegación entre Pabellones
- **Definición:** % recorridos inter-pabellón exitosos vs tiempo estimado
- **Target:** >80%
- **Por qué:** Distancia 10m + rampa = complejidad extra
- **Medición:** Comparar tiempo_real vs duracion_estimada_segundos
- **Endpoint:** GET /api/v1/recorridos?entre_pabellones=true

### Métrica 7: Señalización Digital en Pasillos
- **Definición:** % aulas con ubicación CLARA (lado + número + posición)
- **Target:** 100%
- **Campos:** lado_pasillo, numero_aula, posicion_en_pasillo, referencia_visual_puerta
- **Por qué:** Pasillos largos enfrentados = máxima confusión
- **Aceptación:** Cada aula tiene: lado (IZQ/DER), número, posición

### Métrica 8: Reportes de Cambios de Aula
- **Definición:** % aulas reportadas como "cambió de ubicación"
- **Target:** Registrar (información valiosa)
- **Por qué:** CFP tiene cambios frecuentes
- **Medición:** SELECT COUNT(*) FROM reportes WHERE categoria='CAMBIO_AULA' / mes
- **Aceptación:** Registrar y notificar a otros usuarios

### Métrica 9: Reportes de Barreras Inter-Pabellón
- **Definición:** # reportes de problemas entre pabellones por mes
- **Target:** <2 por mes (si >5 = acción inmediata)
- **Por qué:** Rampa rota, 10m barro = barrera crítica
- **Medición:** SELECT COUNT(*) FROM reportes WHERE categoria='BARRERA_INTER_PABELLON'
- **Aceptación:** <2 reportes/mes (escalado si >5)

### Métrica 10: Adopción por Turno
- **Definición:** % usuarios activos por turno
- **Target:** >20% mañana, >20% tarde, >15% vespertino
- **Por qué:** Asegurar acceso para TODOS los turnos
- **Medición:** DAU per turno
- **Aceptación:** Cada turno >target%

### Métrica 11: Adopción por Modalidad
- **Definición:** % usuarios activos por modalidad
- **Target:** >15% EPS, >20% FP, >10% SecundarT
- **Medición:** DAU per modalidad
- **Aceptación:** Cada modalidad >target%

### Métrica 12: Disponibilidad API
- **Definición:** Uptime de API
- **Target:** >99.5%
- **Medición:** GET /api/v1/health (check cada minuto)
- **Aceptación:** Uptime >99.5%

### Métrica 13: Tiempo Respuesta API
- **Definición:** Promedio ms para endpoints críticos
- **Target:** <500ms búsqueda, <1000ms recorridos
- **Medición:** Log response_time en cada request
- **Aceptación:** 95th percentile <500ms

### Métrica 14: Tasa Error API
- **Definición:** % requests que retornan 5xx
- **Target:** <2%
- **Medición:** SELECT COUNT(*) WHERE http_status >= 500
- **Aceptación:** <2% error rate

### Métrica 15: Rutas Accesibles Documentadas
- **Definición:** % pares pabellón_A → pabellón_B con ruta accesible
- **Target:** 100%
- **Por qué:** Debe haber alternativa sin escaleras para TODO
- **Medición:** SELECT COUNT(tipo_ruta='ACCESIBLE') / total
- **Aceptación:** 100% pares tienen ruta accesible documentada

---

## 📋 CHECKLIST MÉTRICAS

### Dashboard & Tracking:
- [ ] Crear tabla eventos_tracking (evento_nombre, usuario_id, parametros, response_time_ms, http_status, timestamp)
- [ ] Implementar logger en cada endpoint
- [ ] Crear queries para cada KPI
- [ ] Crear dashboard Grafana/Kibana con 15 gráficos

### Validación de Datos:
- [ ] Auditar 100% espacios = tienen datos a11y
- [ ] Validar 100% pasos = sin ambigüedad
- [ ] Documentar 100% rutas accesibles

### Alertas:
- [ ] Si <2000ms búsqueda: OK ✅
- [ ] Si >2000ms: Alert ⚠️
- [ ] Si acceso_certeza < 95%: Alert ⚠️
- [ ] Si barrera_inter_pabellon > 5/mes: Alert 🔴

---

## 🎯 DEFINICIÓN DE HECHO

✅ Los 15 KPIs están:
1. Conectados con 4 personas UX reales
2. Tienen target claro
3. Tienen query SQL o medición clara
4. Tienen aceptación explícita
5. Están en dashboard (Sprint 2)

---

## 🔗 REFERENCIAS
- UX Research: CFP N°7 — UX Research · Personas, Empatía & User Journey
- Arquitectura: CampusMap API Spring Boot
- Contexto: Complejo 3 pabellones, pasillos largos, aulas enfrentadas

---

**Tiempo estimado:** 8 horas (Sprint 1)
**Dueño:** angelgabrieldaq (Data Team)
**Status:** In Progress ▶️
