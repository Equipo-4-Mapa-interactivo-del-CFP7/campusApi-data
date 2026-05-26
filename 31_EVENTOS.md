# [S1-S2] Definir eventos a trackear #31

## Descripción
Definir 10 eventos core que capturen las acciones críticas de usuarios en CampusMap, conectando cada evento con necesidades UX específicas (Paola, Camilo, María, Federico).

---

## 🧠 PROPÓSITO DE CADA EVENTO

Cada evento captura un **momento crítico** donde un usuario interactúa con CampusMap y validamos si estamos cumpliendo su necesidad:
- **PAOLA:** ¿Busca y encuentra en <2seg?
- **CAMILO:** ¿Recibe respuesta minimalista?
- **MARÍA:** ¿Consulta accesibilidad y puede acceder?
- **FEDERICO:** ¿Ve instrucción clara sin confusión?

---

## 🎬 10 EVENTOS CORE

### Event 1: `user_login` (Todas las personas)
```json
{
  "evento": "user_login",
  "descripcion": "Usuario inicia sesión",
  "parametros": {
    "user_id": "UUID",
    "turno": "enum[MANANA, TARDE, VESPERTINO]",
    "modalidad": "enum[EPS, FP, SecundarT]",
    "rol": "enum[estudiante, docente, admin]",
    "timestamp": "ISO8601"
  },
  "endpoint": "POST /api/v1/auth/login",
  "http_status_esperado": 200,
  "por_que": "Registrar turno+modalidad = contexto para personalizar respuestas",
  "sql_query": "INSERT INTO eventos_tracking (evento_nombre, user_id, turno, modalidad, timestamp)"
}
```

### Event 2: `search_aula_paola` (Para PAOLA - eficiencia)
```json
{
  "evento": "search_aula_paola",
  "descripcion": "Usuario busca aula - Registrar velocidad",
  "parametros": {
    "query": "string (ej: 'Aula 301')",
    "numero_pabellon": "number (1, 2, 3)",
    "resultado_encontrado": "boolean",
    "tiempo_busqueda_ms": "number",
    "user_id": "UUID",
    "timestamp": "ISO8601"
  },
  "endpoint": "POST /api/v1/espacios/search",
  "http_status_esperado": 200,
  "por_que": "PAOLA necesita <2seg. Si >2seg = fracaso de su UX",
  "aceptacion": "response_time <= 2000ms",
  "gherkin": "Scenario: Paola busca aula antes de clase\n  Given: Paola es ESTUDIANTE EPS turno MANANA\n  When: Paola busca 'Aula 301'\n  Then: Respuesta en <2000ms\n  And: Contiene 'Pabellón 1, Lado Derecho, Pasillo 3'\n  And: Paola NO hace scroll",
  "sql_query": "INSERT INTO eventos_tracking (evento_nombre='search_aula_paola', user_id, query, tiempo_ms, resultado)"
}
```

### Event 3: `consulta_accesibilidad_maria` (Para MARÍA - certeza)
```json
{
  "evento": "consulta_accesibilidad_maria",
  "descripcion": "Usuario consulta accesibilidad = ¿PUEDO acceder?",
  "parametros": {
    "espacio_id": "UUID",
    "user_id": "UUID",
    "necesidades": "[rampa, baño, ancho_pasillo, escaleras]",
    "garantia_acceso": "boolean",
    "timestamp": "ISO8601"
  },
  "endpoint": "GET /api/v1/espacios/{id}/accesibilidad",
  "http_status_esperado": 200,
  "por_que": "MARÍA necesita CERTEZA. Si no hay garantía = no confía",
  "respuesta_maria_acceso": {\n    \"puede_acceder\": true,\n    \"confirmacion\": \"GARANTIZADO\",\n    \"rampa_entrada\": true,\n    \"pasillo_ancho_cm\": 772,\n    \"bano_adaptado_distancia_m\": 30\n  },\n  \"respuesta_maria_no_acceso\": {\n    \"puede_acceder\": false,\n    \"confirmacion\": \"NO ACCESIBLE\",\n    \"motivo\": \"Escaleras sin rampa alternativa\"\n  },\n  \"aceptacion\": \"respuesta.confirmacion EN ['GARANTIZADO', 'NO ACCESIBLE']\",\n  \"gherkin\": \"Scenario: María verifica acceso\n  Given: María es VISITANTE con movilidad reducida\n  When: Consulta 'Puedo acceder a Aula 301?'\n  Then: Respuesta = 'GARANTIZADO' o 'NO ACCESIBLE' (nunca 'tal vez')\n  And: Muestra ruta sin escaleras\n  And: Muestra baños adaptados cercanos\",\n  \"sql_query\": \"INSERT INTO eventos_tracking (evento_nombre='consulta_accesibilidad_maria', espacio_id, garantia_acceso, timestamp)\"\n}
```

### Event 4: `paso_claro_federico` (Para FEDERICO - claridad)
```json
{
  "evento": "paso_claro_federico",
  "descripcion": "Federico ve instrucción de paso SIN ambigüedad",
  "parametros": {
    "recorrido_id": "UUID",
    "numero_paso": "number",
    "instruccion": "text",
    "ambiguedad_score": "number (0=claro, 100=ambiguo)",
    "tiene_lado_explicito": "boolean (IZQUIERDA o DERECHA)",
    "tiene_numero_referencia": "boolean",
    "tiene_referencia_visual": "boolean",
    "user_id": "UUID",
    "timestamp": "ISO8601"
  },
  "endpoint": "GET /api/v1/recorridos/{id}/pasos",
  "http_status_esperado": 200,\n  \"por_que\": \"FEDERICO necesita 0 ambigüedad. Si confunde izquierda/derecha = se pierde\",\n  \"ejemplo_correcto\": \"Camina 30m recto. Verás 4 aulas a la IZQUIERDA (301-304). Tu aula es 302, puerta DERECHA con número azul.\",\n  \"ejemplo_incorrecto\": \"Camina por el pasillo\",\n  \"aceptacion\": \"ambiguedad_score = 0 AND tiene_lado_explicito=true AND tiene_numero_referencia=true AND tiene_referencia_visual=true\",\n  \"gherkin\": \"Scenario: Federico ve paso claro\n  Given: Federico es ESTUDIANTE con dificultad cognitiva\n  When: Lee paso 2 del recorrido\n  Then: No ve 'tal vez', 'aproximadamente'\n  And: Ve lado explícito: 'IZQUIERDA' o 'DERECHA'\n  And: Ve número aula\n  And: Ve referencia visual (color puerta)\",\n  \"sql_query\": \"INSERT INTO eventos_tracking (evento_nombre='paso_claro_federico', recorrido_id, ambiguedad_score, timestamp)\"\n}
```

### Event 5: `respuesta_minimalista_camilo` (Para CAMILO - no saturar)
```json
{
  \"evento\": \"respuesta_minimalista_camilo\",\n  \"descripcion\": \"Camilo (docente) recibe respuesta sin sobrecarga\",\n  \"parametros\": {\n    \"endpoint_original\": \"GET /api/v1/espacios/{id}\",\n    \"perfil_usuario\": \"DOCENTE\",\n    \"campos_respuesta\": \"number\",\n    \"requiere_scroll\": \"boolean\",\n    \"response_time_ms\": \"number\",\n    \"user_id\": \"UUID\",\n    \"timestamp\": \"ISO8601\"\n  },\n  \"endpoint\": \"GET /api/v1/espacios/{id}?perfil=docente\",\n  \"http_status_esperado\": 200,\n  \"por_que\": \"CAMILO se satura fácilmente. Max 5 campos = no abruma\",\n  \"respuesta_ejemplo_camilo\": {\n    \"nombre\": \"Aula 301\",\n    \"ubicacion\": \"Pabellón 1, Lado Derecho, Pasillo 3\",\n    \"disponibilidad_hoy\": \"09:00-12:00 Gastronomía\",\n    \"baño_cercano\": \"15m patio\",\n    \"acceso\": \"Rampa disponible\"\n  },\n  \"aceptacion\": \"campos_respuesta <= 5 AND requiere_scroll=false AND response_time<500ms\",\n  \"gherkin\": \"Scenario: Camilo consulta aula\n  Given: Camilo abre app como DOCENTE\n  When: Busca 'Aula 301'\n  Then: Ve MAX 5 campos\n  And: Cabe en pantalla (sin scroll)\n  And: Tiempo respuesta <500ms\",\n  \"sql_query\": \"INSERT INTO eventos_tracking (evento_nombre='respuesta_minimalista_camilo', campos_count, requiere_scroll, response_time_ms, timestamp)\"\n}
```

### Event 6: `navegacion_entre_pabellones` (Todas - contexto CFP)
```json
{
  \"evento\": \"navegacion_entre_pabellones\",\n  \"descripcion\": \"Usuario navega ENTRE pabellones (distancia 10m + rampa)\",\n  \"parametros\": {\n    \"pabellon_origen\": \"number (1, 2, 3)\",\n    \"pabellon_destino\": \"number\",\n    \"espacio_origen\": \"UUID\",\n    \"espacio_destino\": \"UUID\",\n    \"tipo_ruta\": \"enum[estandar, accesible]\",\n    \"distancia_exterior_m\": 10,\n    \"requiere_rampa\": \"boolean\",\n    \"user_id\": \"UUID\",\n    \"timestamp\": \"ISO8601\"\n  },\n  \"endpoint\": \"GET /api/v1/recorridos?entre_pabellones=true\",\n  \"http_status_esperado\": 200,\n  \"por_que\": \"Transición entre edificios = complejidad máxima\",\n  \"aceptacion\": \"respuesta muestra rampa ubicación y distancia exacta\",\n  \"gherkin\": \"Scenario: Usuario cruza entre pabellones\n  Given: Usuario está en Pabellón 1, Aula 301\n  When: Solicita recorrido a Pabellón 2, Aula 410\n  Then: Ve 'Salir pabellon 1 → 10m exterior → Rampa entrada Pab2 → Entra Aula 410'\",\n  \"sql_query\": \"INSERT INTO eventos_tracking (evento_nombre='navegacion_entre_pabellones', pab_origen, pab_destino, tipo_ruta, timestamp)\"\n}
```

### Event 7: `reporte_cambio_aula` (Crowdsourcing)
```json
{
  \"evento\": \"reporte_cambio_aula\",\n  \"descripcion\": \"Usuario reporta que aula cambió de ubicación\",\n  \"parametros\": {\n    \"espacio_id\": \"UUID\",\n    \"numero_aula\": \"string (ej: '301')\",\n    \"ubicacion_anterior\": \"string\",\n    \"ubicacion_nueva\": \"string\",\n    \"descripcion\": \"text\",\n    \"user_id\": \"UUID\",\n    \"timestamp\": \"ISO8601\"\n  },\n  \"endpoint\": \"POST /api/v1/reportes?categoria=cambio_aula\",\n  \"http_status_esperado\": 201,\n  \"por_que\": \"CFP cambia aulas frecuentemente. Sistema colaborativo = actualización rápida\",\n  \"aceptacion\": \"Reporte registrado Y notifica otros usuarios del cambio\",\n  \"gherkin\": \"Scenario: Paola reporta cambio de aula\n  Given: Paola intenta ir a Aula 301 pero encuentra vacío\n  When: Reporta 'Aula 301 se mudó a Pabellón 2'\n  Then: Reporte se registra\n  And: Otros usuarios ven notificación del cambio\",\n  \"sql_query\": \"INSERT INTO reportes (espacio_id, categoria='CAMBIO_AULA', descripcion, user_id, timestamp)\"\n}
```

### Event 8: `reporte_barrera_inter_pabellon` (María-critical)
```json
{
  \"evento\": \"reporte_barrera_inter_pabellon\",\n  \"descripcion\": \"Usuario reporta problema de acceso entre pabellones\",\n  \"parametros\": {\n    \"pabellon_desde\": \"number\",\n    \"pabellon_hacia\": \"number\",\n    \"tipo_barrera\": \"enum[rampa_rota, barro, escalera, otro]\",\n    \"descripcion\": \"text\",\n    \"user_id\": \"UUID\",\n    \"timestamp\": \"ISO8601\"\n  },\n  \"endpoint\": \"POST /api/v1/reportes?categoria=barrera_inter_pabellon\",\n  \"http_status_esperado\": 201,\n  \"por_que\": \"Rampa rota = BARRERA CRÍTICA para María. Requiere acción inmediata\",\n  \"aceptacion\": \"Reporte registrado Y alertado a ADMIN inmediatamente\",\n  \"gherkin\": \"Scenario: María reporta rampa rota\n  Given: María intenta cruzar de Pab1 a Pab2\n  When: Reporta 'Rampa de acceso está rota'\n  Then: Reporte se registra\n  And: Admin recibe alert inmediato (no espera Sprint siguiente)\",\n  \"sql_query\": \"INSERT INTO reportes (pabellon_desde, pabellon_hacia, tipo_barrera, user_id, timestamp); TRIGGER ALERT TO ADMIN\"\n}
```

### Event 9: `api_error` (QA critical)
```json
{
  \"evento\": \"api_error\",\n  \"descripcion\": \"Error en API - capturar para debugging\",\n  \"parametros\": {\n    \"endpoint\": \"string\",\n    \"http_status\": \"number (4xx, 5xx)\",\n    \"error_message\": \"text\",\n    \"user_id\": \"UUID (opcional)\",\n    \"timestamp\": \"ISO8601\"\n  },\n  \"endpoint\": \"Todos\",\n  \"por_que\": \"Monitorear errores = mejorar confiabilidad API\",\n  \"aceptacion\": \"Error registrado < 2% total requests\",\n  \"gherkin\": \"Scenario: API falla\n  Given: Usuario intenta buscar aula\n  When: API retorna 500\n  Then: Error se registra en eventos_tracking\n  And: Dashboard muestra error_rate < 2%\",\n  \"sql_query\": \"INSERT INTO eventos_tracking (evento_nombre='api_error', endpoint, http_status, error_message, timestamp)\"\n}
```

### Event 10: `navegacion_completada` (Confirmación)
```json
{
  \"evento\": \"navegacion_completada\",\n  \"descripcion\": \"Usuario completó recorrido exitosamente\",\n  \"parametros\": {\n    \"recorrido_id\": \"UUID\",\n    \"espacio_destino_id\": \"UUID\",\n    \"tiempo_real_segundos\": \"number\",\n    \"tiempo_estimado_segundos\": \"number\",\n    \"usuario_satisfecho\": \"boolean\",\n    \"user_id\": \"UUID\",\n    \"timestamp\": \"ISO8601\"\n  },\n  \"endpoint\": \"POST /api/v1/recorridos/{id}/completado\",\n  \"http_status_esperado\": 200,\n  \"por_que\": \"Validar que instrucciones + accesibilidad = usuario llegó a destino\",\n  \"aceptacion\": \"95% usuarios que consultan accesibilidad logran completar recorrido\",\n  \"gherkin\": \"Scenario: María completa recorrido accesible\n  Given: María consultó accesibilidad Y recibió 'GARANTIZADO'\n  When: Navega según instrucciones\n  Then: Llega a destino exitosamente\n  And: Eventos muestra navegacion_completada=true\",\n  \"sql_query\": \"INSERT INTO eventos_tracking (evento_nombre='navegacion_completada', recorrido_id, user_id, tiempo_real, tiempo_estimado, satisfecho, timestamp)\"\n}
```

---

## 📊 TABLA EVENTOS_TRACKING (Schema)

```sql
CREATE TABLE eventos_tracking (
  id UUID PRIMARY KEY,
  evento_nombre VARCHAR(100) NOT NULL,
  user_id UUID,
  parametros JSONB,
  endpoint VARCHAR(200),
  http_status INTEGER,
  response_time_ms INTEGER,
  timestamp TIMESTAMP DEFAULT NOW(),
  INDEX idx_evento (evento_nombre),
  INDEX idx_user (user_id),
  INDEX idx_timestamp (timestamp)
);
```

---

## 📋 CHECKLIST EVENTOS

- [ ] 10 eventos definidos
- [ ] Cada evento tiene: descripción, parámetros, endpoint, aceptación
- [ ] Cada evento conecta con persona UX (PAOLA, CAMILO, MARÍA, FEDERICO)
- [ ] Tabla eventos_tracking creada
- [ ] Logger implementado en cada endpoint
- [ ] Queries de análisis listas

---

## 🎯 DEFINICIÓN DE HECHO

✅ Los 10 eventos permiten:
1. Medir si PAOLA ve <2seg
2. Validar si CAMILO no se satura
3. Confirmar si MARÍA tiene certeza
4. Verificar si FEDERICO ve claro
5. Detectar barreras inter-pabellones
6. Monitorear adopción por turno/modalidad

---

**Tiempo estimado:** 8 horas (Sprint 1)
**Dueño:** angelgabrieldaq (Data Team) + Priscila/Jairo (QA Team)
**Status:** In Progress ▶️
