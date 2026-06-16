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

## 4. Ruta Exterior (capa de mapa - asset estatico)
Las rutas del campus relevadas por GPS. NO es una tabla relacional: es un GeoJSON estatico que el Frontend carga como overlay del mapa y pinta por accesibilidad. Sin FK con `sector` ni `recorrido`. Fuente: 13 tracks GPX relevados en campo (visita 12-06-2026).

Archivo: `rutas_exterior.geojson` (FeatureCollection de LineString, EPSG:4326 lon/lat).

Cada Feature:
```json
{
  "type": "Feature",
  "properties": {
    "name": "string (nombre humano del track)",
    "seg": "int | null (numero de segmento si el track tenia varios)",
    "accesible": "boolean | null (true=apto silla, false=barrera, null=ruta general sin clasificar)",
    "incompleto": "boolean (track parcial, completar en proxima visita)",
    "puntos": "int (cantidad de vertices)"
  },
  "geometry": { "type": "LineString", "coordinates": [[lon, lat], ...] }
}
```
Convencion de pintado sugerida para Front:
- `accesible: true`  -> verde (ruta apta silla de ruedas)
- `accesible: false` -> rojo/naranja (barrera fisica documentada)
- `accesible: null`  -> gris (ruta general, no clasificada para silla)
- `incompleto: true` -> linea punteada (independiente del color)

## 4. Ruta Exterior (capa de mapa - asset estatico)
Las rutas del campus relevadas por GPS. NO es una tabla relacional: es un GeoJSON estatico que el Frontend carga como overlay del mapa y pinta por accesibilidad. Sin FK con `sector` ni `recorrido`. Fuente: 13 tracks GPX relevados en campo (visita 12-06-2026).

Archivo: `rutas_exterior.geojson` (FeatureCollection de LineString, EPSG:4326 lon/lat).

Cada Feature:
```json
{
  "type": "Feature",
  "properties": {
    "name": "string (nombre humano del track)",
    "seg": "int | null (numero de segmento si el track tenia varios)",
    "accesible": "boolean | null (true=apto silla, false=barrera, null=ruta general sin clasificar)",
    "incompleto": "boolean (track parcial, completar en proxima visita)",
    "puntos": "int (cantidad de vertices)"
  },
  "geometry": { "type": "LineString", "coordinates": [[lon, lat], ...] }
}
```
Convencion de pintado sugerida para Front:
- `accesible: true`  -> verde (ruta apta silla de ruedas)
- `accesible: false` -> rojo/naranja (barrera fisica documentada)
- `accesible: null`  -> gris (ruta general, no clasificada para silla)
- `incompleto: true` -> linea punteada (independiente del color)
