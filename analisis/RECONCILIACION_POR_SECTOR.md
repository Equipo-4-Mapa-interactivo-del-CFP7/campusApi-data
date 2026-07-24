# Reconciliación `data.sql` (Back) — Vista por Sector

> Vista por sector de `RECONCILIACION_DATASQL_BACK.md`. Misma información reagrupada para aplicación sectorizada. Fuente de verdad: el documento de reconciliación y el canónico. Este documento no agrega diagnóstico nuevo — cada corrección referencia el número `#N` que tiene en el documento original.

**Generado por:** Data. **Fecha:** 2026-07-24. **Audiencia:** equipo de Back (Jonathan, Ian, Lilia).

---

## Sector 1

### Espacios afectados
**#1 — [ALTA] Sector 1 desconectado del grafo**
- **Qué corregir:** falta conectividad de todo Sector 1 en `conexiones`.
- **Cómo está en `data.sql`:** ninguna fila de `conexiones` referencia los ids 1–6 (Electricidad, Herrería, Climatización, Serigrafía, Baño S1 grande, Baño S1 chico). Sector 1 es una isla.
- **Cómo debe estar:** el pasillo de Sector 1 (`p_s1`, 1,67 m) conecta 6 tramos (`t_s1_01`…`t_s1_06`): entrada → Climatización → baño grande → baño chico, y entrada → Electricidad → Herrería → fondo.
- **Fuente canónica:** `conexiones_cfp7.json`, array `tramos_interiores`, tramos `t_s1_01` a `t_s1_06`.
- **Acción sugerida:** agregar las 6 aristas faltantes entre los ids de Sector 1, replicando la topología de esos 6 tramos.

### Conexiones/pasillos de este sector
El pasillo de Sector 1 no existe todavía como conexión (ver #1 arriba). Ancho oficial **1,67 m** — cuando Back agregue las aristas, deben quedar con `cumple_ley962 = FALSE` (bajo el mínimo de 2,00 m), igual que el resto de los pasillos del edificio.

### Baños de este sector
Sin inconsistencias — ver "Baños de Sector 1" en la sección **Verificado, sin acción** más abajo.

### Otras correcciones de este sector
Ninguna otra, además de #1.

---

## Sector 2

Sin correcciones puntuales en el documento original: ningún hallazgo de `RECONCILIACION_DATASQL_BACK.md` afecta espacios, baños o pasillos específicos de Sector 2 (Carpintería, Taller de bicicletas). Le aplican los criterios transversales de la sección **Global / Transversal** (accesible, ids, slug) igual que al resto del esquema.

---

## Sector 3

### Espacios afectados
**#9 — [MEDIA] "Informes - Regencia" separado en dos espacios**
- **Qué corregir:** un espacio combinado quedó partido en dos.
- **Cómo está en `data.sql`:** separa id 9 "Informes" + id 10 "Regencia".
- **Cómo debe estar:** el canónico los trata como **un solo espacio combinado**: `s3_informes_regencia`, nombre "Informes - Regencia".
- **Fuente canónica:** `espacios_cfp7.json`, recinto `s3_informes_regencia`; `mapeo_slug_id_v5.json` id_v5=9.
- **Acción sugerida:** confirmar con Data si conviene unificarlos en un solo espacio o si la separación es una decisión de Back a documentar como divergencia aceptada.

### Conexiones/pasillos de este sector

**#4 — [ALTA] Ancho y `cumple_ley962` en Pasillo Principal Sector 3**
- **Qué corregir:** ancho equivocado (de otro sector) y flag inconsistente en el mismo pasillo.
- **Cómo está en `data.sql`:** conexión id 13 (`50 → 39`, Frente CFP7 → Pasillo Secretaria/Informes) usa `1.67` en el campo `distancia` — el ancho de **Sector 1**, no de Sector 3 — y marca `cumple_ley962 = TRUE`. Las filas 14–17 (mismo pasillo) sí marcan `FALSE`.
- **Cómo debe estar:** ancho oficial Sector 3 principal = **1,50 m** → `cumple_ley962 = FALSE` en los 9 tramos.
- **Fuente canónica:** `analisis_ley962.md`, fila "Pasillo principal Sector 3"; `conexiones_cfp7.json` tramos `t_s3_01`…`t_s3_09`.
- **Acción sugerida:** corregir el ancho de la conexión id 13 a 1,50 m y su `cumple_ley962` a `FALSE`, para que sea consistente con las filas 14–17 del mismo pasillo.

**#12 — [MEDIA, sin confirmar] Pasillo lateral Sector 3 no identificado con certeza**
- **Qué corregir:** no está claro qué conexión representa este tramo.
- **Cómo está en `data.sql`:** no se pudo identificar con certeza qué conexión representa este pasillo. El candidato más probable (id 45 "Pasillo Secundario Sector 3" / conexión id 29, ancho 4,00) no trae el ancho oficial.
- **Cómo debe estar:** `p_s3_lateral`, ancho oficial **1,47 m**, `cumple_ley962 = FALSE`.
- **Fuente canónica:** `analisis_ley962.md`, fila "Pasillo lateral Sector 3 (al patio)"; `conexiones_cfp7.json` tramo `t_s3_10`.
- **Acción sugerida:** confirmar con Back cuál conexión representa este tramo antes de corregir su ancho/flag — evitar asumir sin la confirmación.

### Baños de este sector
No aplica — Sector 3 no tiene baños en el modelo canónico.

### Otras correcciones de este sector
Ninguna otra, además de #9, #4 y #12.

---

## Sector 4

### Espacios afectados
Ver "Baños de este sector" abajo (#6).

### Conexiones/pasillos de este sector

**#2 — [ALTA] `cumple_ley962` en Pasillo Principal Sector 4**
- **Qué corregir:** flag de Ley 962 en el pasillo principal de S4.
- **Cómo está en `data.sql`:** conexiones ids 32–39 (cadena `46→57→58→60→59/61→62→63`) usan `ancho` 3,00–4,00 m y `cumple_ley962 = TRUE`.
- **Cómo debe estar:** ancho oficial = **1,58 m** (falta 0,42 m para el mínimo de 2,00 m) → `cumple_ley962 = FALSE` en los 14 tramos.
- **Fuente canónica:** `analisis_ley962.md`, tabla "Hallazgos - Circulaciones", fila "Pasillo principal Sector 4"; `conexiones_cfp7.json` tramos `t_s4_01`…`t_s4_14`.
- **Acción sugerida:** cambiar `cumple_ley962` a `FALSE` en las conexiones tipo `PASILLO` del pasillo principal S4 (las que representan el tramo de 1,58 m). NO tocar las conexiones tipo `PUERTA` (ver #10 en Global).

**#3 — [ALTA] `cumple_ley962` en Pasillo Lockers Sector 4**
- **Qué corregir:** flag de Ley 962 en el peor caso de todo el relevamiento.
- **Cómo está en `data.sql`:** conexión id 36 (`59 → 47`, "Pasillo Sector 4 - Lockers" → "Pasillo Baño Sector 4") usa `ancho = 3,00` y `cumple_ley962 = TRUE`.
- **Cómo debe estar:** ancho oficial = **1,08 m con lockers puestos** — el peor caso de todo el edificio. `cumple_ley962 = FALSE`.
- **Fuente canónica:** `analisis_ley962.md`, fila "Pasillo lateral Sector 4 (lockers)", marcada "PEOR CASO"; `conexiones_cfp7.json` tramo `t_s4_15` (nota: "PEOR CASO: 1.08 m con lockers colocados").
- **Acción sugerida:** cambiar `cumple_ley962` a `FALSE` en la conexión id 36.

### Baños de este sector

**#6 — [ALTA] Género de baños Sector 4 horneado en el enum de tipo**
- **Qué corregir:** el género queda fijado en el tipo de dato, no como atributo.
- **Cómo está en `data.sql`:** `tipo = 'BANIO_FEMENINO'` (id 31, "Baño Sector 4 MUJERES") y `tipo = 'BANIO_MASCULINO'` (id 32, "Baño Sector 4 HOMBRES").
- **Cómo debe estar:** el género/rol por recinto **ya está confirmado en vivo (2026-07-24, reunión Front+Back+QA)**: `s4_bano_grande` = femenino (agrupa damas + profesoras), `s4_bano_mediano` = masculino (agrupa caballeros + profesores). El dato en sí coincide con lo que Back cargó — el problema es la representación: debe ir como dato (columna/atributo), no como tipo, para no cerrar el modelo a un binario en el schema. Además, sin columna `slug`, no hay forma de confirmar si el id 31/32 de Back corresponde a `s4_bano_grande` o `s4_bano_mediano`.
- **Fuente canónica:** `espacios_cfp7.json`, recintos `s4_bano_grande`/`s4_bano_mediano` (atributo `genero`, `mapeo_genero_recinto_confirmado: true`).
- **Acción sugerida:** mantener `tipo = BANIO_MIXTO` y cargar el género como atributo aparte (columna nueva o tabla de metadatos), no como valor de tipo. Ver también #7/#8 en Global para el mapeo de ids.

### Otras correcciones de este sector
Ninguna otra, además de #2, #3 y #6.

---

## Global / Transversal

Correcciones que no son de un sector puntual — afectan todo el esquema o varios sectores por igual.

**#5 — [ALTA] `accesible` en 100% de las filas**
- **Qué corregir:** el flag `accesible` no distingue nada, está todo en `TRUE`.
- **Cómo está en `data.sql`:** `accesible = TRUE` en las 63 filas de `espacios` y las 55 de `conexiones`. Cero `FALSE`, cero `NULL`.
- **Cómo debe estar:** solo `s1_bano_grande` y `s1_bano_chico` están confirmados `TRUE` por relevamiento. El resto de espacios debe ser `NULL` (pendiente, no asumir). Los espacios tipo pasillo/punto de paso deben ser `accesible = FALSE` (ninguno cumple Ley 962).
- **Fuente canónica:** `espacios_cfp7.json` `_meta.regla_seed_pasillos`; precedente ya cargado en `01_seed_espacios.sql` / `mocks/db.json`.
- **Acción sugerida:** revisar `accesible` fila por fila: `NULL` para lo no confirmado, `FALSE` para los espacios tipo `PUNTO_DE_PASO`, `TRUE` solo para los 2 baños de Sector 1.

**#7 — [ALTA] IDs no coinciden con `mapeo_slug_id_v5.json` a partir del id 9**
- **Qué corregir:** el mapeo de ids viejo quedó desincronizado con este seed.
- **Cómo está en `data.sql`:** la inserción de "Regencia" (id 10), "Orientación" (id 12) y "Buffet" (id 25) corre todos los ids siguientes respecto del seed v5 anterior. Ejemplo concreto: `id_v5 = 28` = `s4_bano_grande` en el mapeo vigente, pero en este `data.sql` el `id = 28` es **"Gastronomia C"** — una entidad completamente distinta.
- **Cómo debe estar:** `mapeo_slug_id_v5.json` advierte explícitamente: *"IDs validos SOLO para el seed v5; si Back re-seedea, regenerar."* Este re-seed ocurrió.
- **Fuente canónica:** `mapeo_slug_id_v5.json`, `_meta.advertencia`.
- **Acción sugerida:** avisar a Data cuando se re-seedea para regenerar el mapeo, o (mejor) resolver esto agregando columna `slug` — ver #8.

**#8 — [ALTA] Falta columna `slug`** (afecta todo el esquema)
- **Qué corregir:** no hay identificador estable entre re-seeds.
- **Cómo está en `data.sql`:** la tabla `espacios` de este seed no tiene columna `slug` (columnas: `id, nombre, descripcion, tipo, sector, coordenadax, coordenaday, accesible, estado`).
- **Cómo debe estar:** el modelo canónico espera una columna `slug VARCHAR(50) UNIQUE` como identificador estable entre re-seeds, independiente del id autoincremental.
- **Fuente canónica:** `sql/01_seed_espacios.sql` (línea `ALTER TABLE espacio ADD COLUMN IF NOT EXISTS slug VARCHAR(50) UNIQUE`) — precedente ya en uso del lado de Data.
- **Acción sugerida:** agregar columna `slug` estable (ej. `s1_bano_chico`, `s4_bano_grande`) a la tabla `espacios`. Resuelve de raíz los puntos #6 (Sector 4) y #7.

**#10 — [MEDIA] `cumple_ley962` aplicado a conexiones tipo `PUERTA`** (afecta puertas de Sector 3 y Sector 4)
- **Qué corregir:** se está aplicando un umbral de circulación a puertas.
- **Cómo está en `data.sql`:** conexiones tipo `PUERTA` (ids 18–26, 28, 30, 31, 40–51, etc.) llevan `cumple_ley962 = TRUE` con anchos de 2 a 4 m.
- **Cómo debe estar:** el umbral de 2,00 m de Ley 962 (art. 7.6.1.1/7.6.2.1) aplica a **circulaciones**, no a la luz de paso de puertas (art. 4.6.3.10, umbral distinto: 0,80 m). Son dos artículos distintos bajo un mismo flag.
- **Fuente canónica:** `analisis_ley962.md`, sección "Marco normativo aplicable".
- **Acción sugerida:** evaluar si `cumple_ley962` debería aplicar solo a conexiones tipo `PASILLO`/`EXTERIOR`, dejando las `PUERTA` fuera de ese chequeo (o migrar a un flag separado para luz de paso de 0,80 m).

**#11 — [MEDIA] Nodos de grafo cargados como espacios de primer nivel** (afecta Sector 2, 3 y 4)
- **Qué corregir:** divergencia de modelado, no necesariamente un error.
- **Cómo está en `data.sql`:** agrega ~20 espacios que son patios y segmentos de pasillo (7 solo en Sector 3) con id propio en la tabla `espacios`.
- **Cómo debe estar:** el canónico modela esos mismos puntos (`cruce_pasillo_lockers`, `fondo_s1`, `entrada_s3`, `patio_s3`, etc.) solo como **etiquetas de origen/destino** dentro de `tramos_interiores`, no como espacios completos.
- **Fuente canónica:** `conexiones_cfp7.json`, campos `origen`/`destino` de `tramos_interiores`.
- **Acción sugerida:** confirmar si el modelo más granular es intencional (ventaja para el grafo de Back) o si conviene alinearlo al modelo de nodos de tramo del canónico. No bloqueante si es a propósito.

### Criterio de baños (política transversal, afecta S1 y S4)
Género/rol de baños se carga como **atributo**, nunca como valor de **tipo** — mismo criterio en ambos sectores con baños. En Sector 1 este criterio ya se cumple (ver "Verificado, sin acción"). En Sector 4 no se cumple todavía (ver #6 en la sección Sector 4).

---

## Verificado — sin acción necesaria

Dos puntos que evaluamos y **no son inconsistencias**, para que no se toquen sin necesidad:

- **"Orientación" (id 12, Sector 3) y "Buffet" (id 25, Sector 4):** ambos ya existen en el canónico (`s3_orientacion`, `s4_buffet`), agregados por Data el 2026-07-20. No hay divergencia.
- **Baños de Sector 1 (ids 5, 6):** `tipo = BANIO_MIXTO` para ambos, sin género asignado al recinto vía tipo — coincide con el criterio del canónico. `accesible = TRUE` en los dos también coincide con la corrección de accesibilidad confirmada por Data.

---

## Verificación de cobertura

12 hallazgos del documento original (8 ALTA + 4 MEDIA), cada uno en exactamente un lugar de esta vista:

| Sector | Hallazgos |
|---|---|
| Sector 1 | #1 |
| Sector 2 | (ninguno puntual) |
| Sector 3 | #4, #9, #12 |
| Sector 4 | #2, #3, #6 |
| Global | #5, #7, #8, #10, #11 |

Total: 1 + 0 + 3 + 3 + 5 = **12/12**. Ninguno duplicado, ninguno perdido.
