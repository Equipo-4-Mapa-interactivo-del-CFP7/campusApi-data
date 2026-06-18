# Analisis de Accesibilidad - Ley 962 CABA (Codigo de Edificacion)
Relevamiento de dimensiones del CFP N7 (Ramsay 2250) cruzado con la normativa vigente. Fuente de medidas: documento oficial de la institucion (medicion con cinta) como canonica, escaneo MagicPlan "PLANOS CFP7" (12-06-2026) como cross-check. Este documento es insumo de Data para el equipo; NO es un dictamen legal.
## Marco normativo aplicable
El CFP N7 es un establecimiento educativo. Aplica el umbral especifico de educacion, mas exigente que el general:
- Circulaciones que vinculan aulas: **2,00 m de ancho minimo** (Art. 7.6.1.1 / 7.6.2.1). Este valor pisa al generico de 1,50 m de pasajes (Art. 4.6.3.3).
- Puertas - luz util de paso: **0,80 m minimo** (Art. 4.6.3.10).
- Banos accesibles - superficie de maniobra: area libre que permita inscribir un **circulo de 1,50 m** de diametro para giro de silla (Art. 4.8.2.5).
- Rampas exteriores: ancho libre **0,90 m minimo**, pendiente segun altura a salvar (Art. 4.6.3.8). Rampa que supere 1,40 m de altura requiere medios alternativos de elevacion.
## Matiz: edificio existente
El CFP funciona en un edificio existente. La Ley 962 distingue obra nueva de adaptacion. Para edificios existentes con concurrencia masiva, cuando no es posible el cumplimiento total, se admite un proyecto "practicable" (Art. 4.11.2.1) y hay excepciones cuando no se pueden modificar las circulaciones (Art. 4.11.2.5). Por eso los hallazgos se expresan como "ancho bajo el minimo de obra nueva", no como infraccion.
## Hallazgos - Circulaciones
Sector 1 = talleres (Electricidad, Herreria, Climatizacion, Serigrafia). Sector 3 = administrativo. Sector 4 = aulas y gastronomia.
| Espacio | Ancho oficial | MagicPlan | Minimo educativo | Estado |
|---------|--------------|-----------|------------------|--------|
| Pasillo principal Sector 1 (talleres, 21 m) | 1,67 m | 1,75 m | 2,00 m | Bajo norma (faltan 0,33 m) |
| Pasillo principal Sector 3 (admin, 24 m) | 1,50 m | - | 2,00 m | Bajo norma (faltan 0,50 m) |
| Pasillo lateral Sector 3 (al patio, 6,14 m) | 1,47 m | - | 2,00 m | Bajo norma (faltan 0,53 m) |
| Pasillo principal Sector 4 (aulas, 31,78 m) | 1,58 m | 1,61 m | 2,00 m | Bajo norma (faltan 0,42 m) |
| Pasillo lateral Sector 4 (lockers, 6 m) | 1,08 m | - | 2,00 m | Bajo norma - PEOR CASO (con lockers colocados; 1,58 m sin lockers) |
| Pasillo corto Sector 1 | - | 4,14 m | 2,00 m | Cumple (conector ancho) |
| Pasillo corto Sector 4 | - | 5,94 m | 2,00 m | Cumple (conector ancho) |
| Hall / patio cubierto Sector 3 | - | 7,69 m | 2,00 m | Cumple (circulacion ancha) |
**Hallazgo critico:** los cinco ejes de circulacion principales y laterales (Sectores 1, 3 y 4) estan bajo el minimo educativo. Toda la red de circulacion interna es no conforme a obra nueva. El peor caso es el pasillo de lockers del Sector 4 con 1,08 m efectivos. El dato oficial de la institucion confirma y agrava lo relevado por MagicPlan (que no habia capturado los pasillos del Sector 3 ni el de lockers).
## Hallazgos - Banos
| Bano | Area | Lado | Observacion |
|------|------|------|-------------|
| Sector 1 (grande) | 16,58 m2 | 4,64 x 3,95 | Area suficiente; verificar circulo de maniobra de 1,50 m libre de artefactos |
| Sector 1 (chico) | 3,05 m2 | 1,62 x 1,88 | Demasiado chico para giro de silla |
| Sector 4 (grande) | 23,47 m2 | 5,93 x 4,46 | Area amplia; verificar disposicion de artefactos |
| Sector 4 (mediano) | 15,90 m2 | 5,93 x 3,48 | Area suficiente; verificar maniobra |
Nota: el documento oficial lista 2 banos en Sector 1 (Caballeros/Damas) y 4 en Sector 4 (Caballeros/Damas/Profesoras/Profesores). MagicPlan solo midio 2 de Sector 4; la asignacion de cual area corresponde a cual bano queda pendiente. Un area grande NO garantiza accesibilidad: la norma exige el circulo de maniobra de 1,50 m libre Y la disposicion de artefactos (barras, alturas), que se mide in situ.
## Pendiente para el tercer relevamiento
Medir en sitio con cinta metrica (no estimar del plano):
1. Confirmar ancho de los pasillos en varios puntos (ya hay medida oficial de 5 pasillos; validar consistencia).
2. Luz util de paso de las puertas principales (minimo 0,80 m). Revisar puertas Sector 4 ya detectadas bajo 0,80 m (0,64 / 0,65 / 0,68 m).
3. Superficie de maniobra real en banos (circulo libre de 1,50 m) y asignacion Caballeros/Damas/Profesoras/Profesores.
4. Pendiente de las rampas exteriores relevadas (rampa izquierda y central de la entrada al centro).
5. Altura de los desniveles y escalones (entrada porche, conexion Sector 1 con nivel elevado 2/3/4).
6. Confirmar la barrera del track 13 (rampa central con ripio no transitable sin asistencia).
## Trazabilidad
Medidas oficiales: documento de la institucion "Medidas Sectores CFP N7". Cross-check dimensional: reporte MagicPlan "PLANOS CFP7" (PDF, 12-06-2026). Membresia y nombres de sector: documento oficial "Sectores para senaletica". Rutas exteriores y barreras en rutas_exterior.geojson. Espacios en espacios_cfp7.json. Normativa: Ley 962 CABA, Anexo I (modificacion al Codigo de Edificacion).
