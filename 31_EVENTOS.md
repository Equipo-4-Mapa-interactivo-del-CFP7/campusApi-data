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

```json
{
  "evento": "ficha_consultada",
  "timestamp": "ISO-8601",
  "payload": {
    "espacio_id": "string"
  }
}
```
