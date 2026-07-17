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
    "accesible": "boolean (true=apto silla de ruedas, false=barrera fisica)",
    "barrera": "string | null (tipo de barrera: escalon, desnivel, ripio; null si no hay)",
    "incompleto": "boolean (track parcial: sin completar; sin relevamiento adicional previsto)",
    "puntos": "int (cantidad de vertices)"
  },
  "geometry": { "type": "LineString", "coordinates": [[lon, lat], ...] }
}
```
Convencion de pintado sugerida para Front:
- `accesible: true`  -> verde (ruta apta silla de ruedas)
- `accesible: false` -> rojo/naranja (barrera fisica; ver campo `barrera` para el tipo)
- `incompleto: true` -> linea punteada (independiente del color)
- ripio: `accesible: true` + `barrera: ripio` -> pintar verde (es transitable) pero mostrar aviso de ripio

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
    "accesible": "boolean (true=apto silla de ruedas, false=barrera fisica)",
    "barrera": "string | null (tipo de barrera: escalon, desnivel, ripio; null si no hay)",
    "incompleto": "boolean (track parcial: sin completar; sin relevamiento adicional previsto)",
    "puntos": "int (cantidad de vertices)"
  },
  "geometry": { "type": "LineString", "coordinates": [[lon, lat], ...] }
}
```
Convencion de pintado sugerida para Front:
- `accesible: true`  -> verde (ruta apta silla de ruedas)
- `accesible: false` -> rojo/naranja (barrera fisica; ver campo `barrera` para el tipo)
- `incompleto: true` -> linea punteada (independiente del color)
- ripio: `accesible: true` + `barrera: ripio` -> pintar verde (es transitable) pero mostrar aviso de ripio

## 5. Foto de Campo (capa de relevamiento - asset estatico)
Fotos georreferenciadas tomadas en relevamiento de campo, usadas por el equipo para decidir donde insertar carteles e informacion referencial. NO es contenido final de la app: es materia prima de trabajo interno. Asset estatico, sin FK. Fuente: 34 fotos con GPS (visita 12-06-2026). Imagenes en formato HEIC (convertir a JPG solo el subconjunto que se use en la app).

Archivo: `fotos_campo.geojson` (FeatureCollection de Point, EPSG:4326 lon/lat).

Cada Feature:
```json
{
  "type": "Feature",
  "properties": {
    "archivo": "string (nombre del archivo HEIC original)",
    "rumbo": "int | null (0-360, hacia donde apuntaba la camara; el cartel/objeto esta en esa direccion)",
    "fecha": "string ISO8601 | null",
    "sector_id": "string | null (FK logica a espacios_cfp7.json; se completa manualmente)",
    "cartel": "string | null (decision de curaduria del equipo: si/no/tipo de cartel)",
    "nota": "string (observacion libre del relevamiento)"
  },
  "geometry": { "type": "Point", "coordinates": [lon, lat] }
}
```
Nota: el GPS marca donde estaba el fotografo, no el objeto. El campo `rumbo` indica la direccion de la camara: el cartel o referencia esta a unos metros en ese sentido. Indoor el GPS no es fiable; para fotos interiores usar `sector_id`, no la coordenada.
