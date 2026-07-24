# Pendientes - Data CFP7
Estado de deuda tecnica del equipo de Data. Actualizado: 2026-07-24 (mapeo fino genero/rol de banos confirmado en vivo).

## No se medirá (3er relevamiento cancelado — 2026-07-17)
1. Anclas GPS faltantes en `anclas_sectores.json`: Patio comunicante 2-3, Exterior entre sector 1 y 2, Cpf7 frente. → Quedan 2 anclas confirmadas (Sector 1; Sector 2 y 3). Las 3 faltantes quedan sin ancla GPS: fuera de alcance MVP (no bloquea el mapa indoor, que usa `sector_id`, no coordenada GPS).
2. Medidas Ley 962 para confirmar `analisis_ley962.md`: → Derivadas del documento oficial ya relevado; no se remediran. Ver "Criterio de practicabilidad" en `RECONCILIACION_V5.md`.
   - Ancho real de pasillos angostos (Sector 1 ~1,75 m y Sector 3 ~1,62 m) medido en varios puntos. → Se toma el ancho oficial del documento institucional como definitivo; MagicPlan queda como cross-check, no se vuelve a medir.
   - Luz util de paso de puertas principales (minimo 0,80 m). → No se remide puerta por puerta; ya hay 3 puertas de Sector 4 detectadas bajo el minimo (0,64 / 0,65 / 0,68 m), se toma ese relevamiento como definitivo.
   - Superficie de maniobra en banos (circulo libre de 1,50 m). → No se remide; se usa la clasificacion ya disponible por area. `s1_bano_chico` (3,05 m² / 1,62 x 1,88 m) fue re-evaluado el 2026-07-21: radio de maniobra suficiente (corrige la evaluacion previa de insuficiente); el resto se toma como suficiente por area en `analisis_ley962.md`, sin verificar disposicion de artefactos.
   - Pendiente de rampas exteriores (rampa izquierda y central de entrada al centro). → No se remide; se mantiene el dato ya relevado (`anclas_sectores.json`: rampa izquierda accesible, rampa central con ripio no accesible).
   - Altura de desniveles y escalones. → No se remide; sin dato de altura exacta, fuera de alcance MVP (no bloquea el grafo de recorridos, que no modela el escalon - ver `RECONCILIACION_V5.md` b.3).

## Curaduria de fotos de campo
3. Definir campo `cartel` (si/no/tipo) en `fotos_campo.geojson` - decision de equipo mirando las fotos.
4. Convertir HEIC -> JPG solo del subconjunto de fotos que se usen en la app (las que tengan cartel).

## Coordinacion con Backend
5. Proponer agregar valor `RIPIO` al enum `TipoTransito` (evidencia: rutas relevadas con barrera ripio).
6. Alinear modelo: exterior e interior son un continuo (patios comunicantes conectan sectores), no dos sistemas separados. Un solo grafo.
7. Pasarle a Back el UPDATE de accesible derivado (criterio ancho_m >= 0.90) — ver sql/03_update_accesible_v5.sql (a crear).

## Coordinacion con Frontend
8. Avisar que `anclas_sectores.json` esta disponible para montar los SVG indoor sobre el mapa.
9. Avisar que los SVG por sector (MagicPlan) son el material para el mapa interactivo indoor.

## Banos: genero y accesibilidad (cerrado 2026-07-21)
10. ~~Asignar genero a banos de S1/S4~~ CERRADO: generos cargados a nivel de SECTOR en `datos/espacios_cfp7.json` (nuevo bloque `generos_banos_por_sector`: sector 1 `[caballeros, damas]`, sector 4 `[caballeros, damas, profesoras, profesores]`). No se reparte por recinto: la asignacion posicional a un bano especifico no esta relevada, no se asume. Accesibilidad de Sector 1 corregida a `true` en `s1_bano_grande` y `s1_bano_chico` (radio de maniobra interior re-evaluado como suficiente).
11. ~~Mapeo fino genero/rol -> recinto en S1 y S4 sin confirmar~~ CERRADO (2026-07-24): confirmado en vivo por el equipo Front+Back+QA reunido armando el mapa. Sector 1 es por ROL (`s1_bano_grande`=docentes, `s1_bano_chico`=alumnos; el doc oficial mencionaba Caballeros/Damas pero el eje operativo real es rol). Sector 4 es por SEXO (`s4_bano_grande`=femenino, agrupa damas+profesoras; `s4_bano_mediano`=masculino, agrupa caballeros+profesores) — las 4 designaciones del doc oficial quedan resueltas en los 2 recintos, no falta ningun bano. Ver atributos `uso`/`genero` por recinto y `mapeo_genero_recinto_confirmado: true` en `espacios_cfp7.json`.

## Notas
- Las rutas de Dragones (izq/conexion) que figuraban "incompletas" en los nombres de archivo NO lo estaban: las entradas estan separadas por metros (garage grande) y se conectan via ruta de conexion CFP7. Ya corregido.
- Las 3 rutas de Echeverria son accesibles. Ya confirmado.