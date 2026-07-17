# 33 ? Contrato de Ingesta de Telemetr?a

**Estado:** PROPUESTO ? pendiente de implementaci?n en Back (S10/S11)
**Owner:** Data (?ngel) ? **Implementa:** Back ? **Consume:** Front
**Referencias:** 31_EVENTOS.md (payloads), sql/02_telemetria_y_dashboard.sql (tabla destino)

## Endpoint

`POST /api/eventos`

### Request
```json
{
  "tipo_evento": "espacio_buscado",
  "entidad_id": "s4_aula_1",
  "requiere_accesibilidad": false
}
```

| Campo | Tipo | Reglas |
|---|---|---|
| tipo_evento | string | Uno de: `espacio_buscado`, `recorrido_iniciado`, `ficha_consultada`. Otro valor ? 400. |
| entidad_id | string | Slug del espacio. En `recorrido_iniciado` es el **destino_id** (el origen no se persiste; ning?n KPI lo usa). |
| requiere_accesibilidad | boolean | Opcional, default `false`. Refleja si el filtro de accesibilidad estaba activo al momento del evento. |

### Response
- `201 Created` ? sin body necesario.
- `400 Bad Request` ? payload inv?lido. **Nunca 500 por payload malo.**

### Reglas de dise?o (no negociables)
1. **Sin autenticaci?n.** El evento es an?nimo por dise?o: NO enviar DNI, user_id, ni ning?n identificador de persona. La telemetr?a mide uso del espacio, no personas (privacy-first, decisi?n de Sprint 3).
2. **Fire-and-forget en Front:** el `fetch` NO debe bloquear la UI ni mostrar error al usuario si falla. Si la ingesta se cae, la app sigue funcionando.
3. **INSERT directo** en `evento_telemetria` (DDL ya entregado en sql/02_telemetria_y_dashboard.sql). `fecha_creacion` la pone la DB (`CURRENT_TIMESTAMP`), no el cliente.
4. Sin GET, sin UPDATE, sin DELETE. La lectura es v?a queries del dashboard, no v?a API p?blica.

## Puntos de disparo en Front

| Evento | Momento exacto |
|---|---|
| espacio_buscado | Al seleccionar un resultado del buscador (no por tecla presionada) |
| ficha_consultada | Al abrir la ficha de un espacio |
| recorrido_iniciado | Al iniciar la visualizaci?n de un recorrido |

Ejemplo (no bloqueante):
```js
fetch(`${API}/api/eventos`, {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ tipo_evento: "ficha_consultada", entidad_id: espacio.id, requiere_accesibilidad: modoAccesible })
}).catch(() => {}); // nunca romper la UX por telemetr?a
```

## Pregunta abierta a Back
La tabla usa `entidad_id VARCHAR(50)` (slug, ej. `s4_aula_1`) y los KPIs joinean contra `espacio.id`. **Confirmar que la PK de `espacio` es el slug** (string) y no un `Long` autoincremental ? si es Long, hay que acordar cu?l de los dos ajusta.