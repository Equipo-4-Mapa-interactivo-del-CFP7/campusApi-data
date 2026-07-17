# campusApi-data

Fuente canonica de datos del proyecto CampusMap CFP N7 (Equipo 4, Innova Lab).

## Estructura
- **contratos/** - Contratos de datos entre equipos: estructura (32), eventos de telemetria (31), KPIs (21), ingesta (33). Cambios aca requieren broadcast a Back/Front/QA.
- **datos/** - Datos canonicos: espacios_cfp7.json (fuente de verdad de espacios), conexiones_cfp7.json (grafo de circulacion), anclas GPS, capas geo (GPX relevados y fotos de campo).
- **sql/** - Schema, seeds (espacios y reportes reales de campo) y queries de telemetria/dashboard para la MySQL del back.
- **mocks/** - db.json canonico para json-server (puerto 3001). Unica fuente de mocks del proyecto.
- **dashboard/** - Dashboard de uso y accesibilidad (HTML standalone). Correr: npx json-server@0.17.4 --watch mocks/db.json --port 3001 --static dashboard
- **analisis/** - Analisis Ley 962 y pendientes de relevamiento.
- **herramientas/** - Pipeline GPX -> GeoJSON.

## Regla de oro
Ningun dato de accesibilidad se asume: se releva o se marca pendiente (NULL).
