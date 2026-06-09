# Contratos de Datos (JSON Schemas) - Single Source of Truth

Este documento define la estructura estricta que deben cumplir los DTOs del Backend, los mocks de QA y el consumo del Frontend.

## 1. Espacio / Sector

```json
{
  "id": "string (UUID o slug)",
  "nombre": "string",
  "tipo": "enum [aula, oficina, espacio_comun, acceso, servicio]",
  "descripcion": "string",
  "accesible": "boolean"
}
```

## 2. Recorrido

```json
{
  "id": "string",
  "origen_id": "string (ID del espacio)",
  "destino_id": "string (ID del espacio)",
  "accesible": "boolean",
  "tramos": [
    {
      "instruccion": "string",
      "referencia_visual_url": "string (opcional)"
    }
  ]
}
```

## 3. Reporte

```json
{
  "espacio_id": "string",
  "tipo_incidencia": "enum [acceso_bloqueado, senaletica, barrera_fisica, orientacion]",
  "descripcion": "string",
  "imagen_evidencia_url": "string (opcional)"
}
```
