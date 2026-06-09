# Telemetría y Eventos de Usuario

Para cumplir con el requerimiento del Dashboard (Sprint 5), el Frontend debe disparar los siguientes payloads hacia el Backend (ej. `POST /api/metricas/eventos`) para trackear el flujo de los usuarios sin recolectar datos sensibles.

## Evento: Búsqueda de Espacio

```json
{
  "evento": "espacio_buscado",
  "timestamp": "ISO-8601",
  "payload": {
    "espacio_id": "string",
    "filtro_utilizado": "string (ej. aulas, baños)"
  }
}
```

## Evento: Recorrido Iniciado

```json
{
  "evento": "recorrido_iniciado",
  "timestamp": "ISO-8601",
  "payload": {
    "origen_id": "string",
    "destino_id": "string",
    "requiere_accesibilidad": "boolean"
  }
}
```
