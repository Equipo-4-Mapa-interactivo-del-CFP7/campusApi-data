# Pendientes - Data CFP7
Estado de deuda tecnica del equipo de Data. Actualizado: 2026-06-17 (cierre Sprint 3).

## Tercer relevamiento de campo (medir in situ)
1. Anclas GPS faltantes en `anclas_sectores.json`: Patio comunicante 2-3, Exterior entre sector 1 y 2, Cpf7 frente.
2. Medidas Ley 962 para confirmar `analisis_ley962.md`:
   - Ancho real de pasillos angostos (Sector 1 ~1,75 m y Sector 3 ~1,62 m) medido en varios puntos.
   - Luz util de paso de puertas principales (minimo 0,80 m).
   - Superficie de maniobra en banos (circulo libre de 1,50 m).
   - Pendiente de rampas exteriores (rampa izquierda y central de entrada al centro).
   - Altura de desniveles y escalones.

## Curaduria de fotos de campo
3. Definir campo `cartel` (si/no/tipo) en `fotos_campo.geojson` - decision de equipo mirando las fotos.
4. Convertir HEIC -> JPG solo del subconjunto de fotos que se usen en la app (las que tengan cartel).

## Coordinacion con Backend
5. Proponer agregar valor `RIPIO` al enum `TipoTransito` (evidencia: rutas relevadas con barrera ripio).
6. Alinear modelo: exterior e interior son un continuo (patios comunicantes conectan sectores), no dos sistemas separados. Un solo grafo.
7. Poblar `Conexion.accesible` del Backend con la clasificacion de terreno (hoy esta vacio/por diseno).

## Coordinacion con Frontend
8. Avisar que `anclas_sectores.json` esta disponible para montar los SVG indoor sobre el mapa.
9. Avisar que los SVG por sector (MagicPlan) son el material para el mapa interactivo indoor.

## Notas
- Las rutas de Dragones (izq/conexion) que figuraban "incompletas" en los nombres de archivo NO lo estaban: las entradas estan separadas por metros (garage grande) y se conectan via ruta de conexion CFP7. Ya corregido.
- Las 3 rutas de Echeverria son accesibles. Ya confirmado.