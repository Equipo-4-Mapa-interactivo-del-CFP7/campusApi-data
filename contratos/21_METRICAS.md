# KPIs de Negocio — Dashboard Sprint 5

Este documento define los indicadores que el Dashboard del Sprint 5 debe exponer. Cada KPI declara su fuente (evento de telemetría definido en `31_EVENTOS.md` o tabla del Backend), la lógica de cálculo y el formato de salida esperado para el Frontend.

---

## KPI 1 — Top 5 Sectores más buscados

**Objetivo de negocio:** identificar qué sectores del CFP N.º 7 concentran el mayor interés de los usuarios para priorizar señalética, mantenimiento y comunicación.

- **Fuente:** evento `espacio_buscado` (ver `31_EVENTOS.md`).
- **Cálculo:** agrupar por `payload.espacio_id`, hacer `JOIN` contra la tabla de Espacios para resolver el Sector asociado, contar ocurrencias, ordenar descendente y limitar a 5.
- **Ventana temporal:** últimos 30 días (configurable).
- **Formato esperado:**

```json
{
  "kpi": "top_sectores_buscados",
  "ventana_dias": 30,
  "resultados": [
    { "sector_id": "string", "nombre": "string", "busquedas": "integer" }
  ]
}
```

---

## KPI 2 — Porcentaje de recorridos que requieren accesibilidad física

**Objetivo de negocio:** dimensionar la demanda real de rutas accesibles para justificar inversión en infraestructura y validar que la app cubre una necesidad crítica.

- **Fuente:** evento `recorrido_iniciado` (ver `31_EVENTOS.md`).
- **Cálculo:** `(COUNT(*) WHERE payload.requiere_accesibilidad = true) / COUNT(*) * 100`.
- **Ventana temporal:** últimos 30 días (configurable).
- **Formato esperado:**

```json
{
  "kpi": "porcentaje_recorridos_accesibles",
  "ventana_dias": 30,
  "porcentaje": "number (0-100, dos decimales)",
  "total_recorridos": "integer",
  "recorridos_accesibles": "integer"
}
```

---

## KPI 3 — Volumen de reportes de barreras arquitectónicas por Sector

**Objetivo de negocio:** detectar sectores con barreras físicas recurrentes para escalar a mantenimiento/dirección del CFP.

- **Fuente:** tabla de Reportes (schema en `32_ESTRUCTURA.md`), filtrando por `tipo_incidencia = "barrera_fisica"`.
- **Cálculo:** `JOIN` Reportes → Espacios → Sector, agrupar por `sector_id` y contar.
- **Ventana temporal:** acumulado histórico, con corte filtrable por mes.
- **Formato esperado:**

```json
{
  "kpi": "reportes_barreras_por_sector",
  "resultados": [
    { "sector_id": "string", "nombre": "string", "reportes": "integer" }
  ]
}
```

---

## Convenciones del Dashboard

- Todos los KPIs se exponen vía `GET /api/metricas/kpis/{nombre_kpi}`.
- Los campos `ventana_dias` se aceptan como query param (`?ventana=30`).
- El Frontend renderiza KPI 1 y KPI 3 como ranking/bar chart y KPI 2 como métrica destacada (porcentaje).
