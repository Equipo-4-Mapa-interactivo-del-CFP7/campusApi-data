# 33 — Contrato de Ingesta de Telemetría

**Estado:** PROPUESTO — pendiente de implementación en Back (S10/S11)
**Owner:** Data (Ángel) · **Implementa:** Back · **Consume:** Front
**Referencias:** 31_EVENTOS.md (payloads), sql/02_telemetria_y_dashboard.sql (tabla destino), datos/mapeo_slug_id_v5.json (mapeo id v5 ↔ slug)

## Endpoint

`POST /api/eventos`

### Request
```json
{
  "tipo_evento": "espacio_buscado",
  "entidad_id": "18",
  "requiere_accesibilidad": false
}
```

| Campo | Tipo | Reglas |
|---|---|---|
| tipo_evento | string | Uno de: `espacio_buscado`, `recorrido_iniciado`, `ficha_consultada`. Otro valor → 400. |
| entidad_id | string | **Id numérico de la API v5** (ver nota de migración), como string. En `recorrido_iniciado` es el **destino_id** (el origen no se persiste; ningún KPI lo usa). |
| requiere_accesibilidad | boolean | Opcional, default `false`. Refleja si el filtro de accesibilidad estaba activo al momento del evento. |

### Nota de migración (v5)
Antes de la v5, `entidad_id` era el **slug** canónico de Data (ej. `s4_aula_1`), pensando en que `espacio.id` en Back fuera ese mismo string. Back liberó la v5 con `espacios.id` como **bigint autoincremental** (ver `recibidos/v5/techlab.sql`), y el equipo decidió acoplarse a esa realidad en vez de pedir un re-modelado: **`entidad_id` pasa a ser el id numérico de la API, como string** (ej. `"18"` para Aula 1). El slug sigue siendo la clave del canónico (`datos/espacios_cfp7.json`); la correspondencia id↔slug para el seed actual está en `datos/mapeo_slug_id_v5.json`. Si Back re-seedea la base, ese mapeo deja de ser válido y hay que regenerarlo.

### Response
- `201 Created` — sin body necesario.
- `400 Bad Request` — payload inválido. **Nunca 500 por payload malo.**

### Reglas de diseño (no negociables)
1. **Sin autenticación.** El evento es anónimo por diseño: NO enviar DNI, user_id, ni ningún identificador de persona. La telemetría mide uso del espacio, no personas (privacy-first, decisión de Sprint 3).
2. **Fire-and-forget en Front:** el `fetch` NO debe bloquear la UI ni mostrar error al usuario si falla. Si la ingesta se cae, la app sigue funcionando.
3. **INSERT directo** en `evento_telemetria` (DDL ya entregado en sql/02_telemetria_y_dashboard.sql). `fecha_creacion` la pone la DB (`CURRENT_TIMESTAMP`), no el cliente.
4. Sin GET, sin UPDATE, sin DELETE. La lectura es vía queries del dashboard, no vía API pública.

## Puntos de disparo en Front

| Evento | Momento exacto |
|---|---|
| espacio_buscado | Al seleccionar un resultado del buscador (no por tecla presionada) |
| ficha_consultada | Al abrir la ficha de un espacio |
| recorrido_iniciado | Al iniciar la visualización de un recorrido |

Ejemplo (no bloqueante):
```js
fetch(`${API}/api/eventos`, {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ tipo_evento: "ficha_consultada", entidad_id: espacio.id, requiere_accesibilidad: modoAccesible })
}).catch(() => {}); // nunca romper la UX por telemetría
```

## Resuelto (v5)
La PK de `espacios` es `id` bigint autoincremental, no el slug. Decisión de equipo: Data se acopla — ver "Nota de migración" arriba. El JOIN de los KPIs contra `espacios.id` requiere CAST porque `entidad_id` sigue siendo `VARCHAR` (ver sql/02_telemetria_y_dashboard.sql).