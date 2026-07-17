# Reconciliacion v5 (Back) vs canonico (Data)
Registro de que tomo la v5 de nuestro trabajo, que diferencias quedan registradas sin corregir (decision de equipo: la v5 queda como esta, el canonico no se toca) y el impacto practico. Fuente v5: recibidos/v5/techlab.sql + los 2 PDF de API (recibidos/v5/). Fecha: 2026-07-16.

## a) Lo que la v5 incorpora de nuestro trabajo
- **Nombres y sectores canonicos**: los 29 nombres de `espacios` (Electricidad, Herreria, ..., Bano Sector 4 (mediano)) y su `sector` (SECTOR_1..4, ENTRADAS) coinciden con `datos/espacios_cfp7.json`. Fuente compartida: doc oficial "Sectores para senaletica".
- **Pasillos como entidad**: los 5 pasillos (`Pasillo Principal Sector 1/3/4`, `Pasillo Lateral Sector 3`, `Pasillo Lockers Sector 4`) quedaron seedeados como espacios `PUNTO_DE_PASO`, tal como pedia `espacios_cfp7.json._meta.regla_seed_pasillos`.
- **Anchos reales por conexion**: `conexiones.ancho` matchea los anchos oficiales del canonico: S1 1.67 m, S3 principal 1.50 m, S3 lateral 1.47 m, S4 principal 1.58 m, S4 lockers 1.08 m (peor caso, con lockers puestos - igual que anoto `pasillos[p_s4_lockers]`).
- **cumple_ley962 correcto por tramo**: `conexiones.cumple_ley962` esta en `false` para los 5 pasillos internos (todos bajo el minimo de 2.00 m de `analisis_ley962.md`) y en `true` para los tramos exteriores mas anchos. Coincide con el hallazgo central del canonico.
- **OTROS** se agrego al enum `reportes.tipo` (ACCESO_BLOQUEADO, BARRERA_FISICA, DIFICULTAD_ORIENTACION, OTROS, PROBLEMA_SENALETICA).
- **RIPIO** se agrego al enum `conexiones.tipo_transito` (EXTERIOR, PASILLO, RAMPA, RIPIO) - era el pedido explicito de `PENDIENTES.md` punto 5.

## b) Divergencias registradas, no corregidas (decision de acople)
No se le pide a Back que las corrija en esta pasada. Quedan documentadas para no perderlas.

1. **`accesible = true` global.** Tanto en `espacios` como en `conexiones`, el bit `accesible` esta en `true` en absolutamente todas las filas del seed v5. Esto incluye casos que el canonico marca como no viables:
   - `s1_bano_chico` (id v5 6): medido 1.62 x 1.88 m, `accesible_viable: false` en el canonico ("sin radio de giro"). En v5 figura accesible.
   - El pasillo de lockers Sector 4 (id v5 40 / conexion id 41, 1.08 m): es el peor caso de ancho de todo el relevamiento, muy por debajo de Ley 962. En v5 tanto el espacio como la conexion figuran accesible.
   - En rigor, ninguno de los 5 pasillos internos deberia ser `accesible=true` (todos incumplen Ley 962 por ancho), pero el seed los marca a todos como accesibles.
   - **Riesgo practico:** cualquier feature de front/dashboard que confie en el campo `accesible` de la API (badges, filtros "solo accesible" fuera del algoritmo de recorridos) va a mostrar informacion optimista e incorrecta hasta que Back lo pueble con la clasificacion real.
2. **Distancias redondeadas.** `conexiones.distancia` en v5 son todos numeros enteros (ej. 8, 5, 3). El doc oficial de medidas y `conexiones_cfp7.json.tramos_interiores` tienen precision decimal (ej. 10.73, 5.96, 0.8, 3.07, 8.67). Se perdio precision en la carga; no afecta el orden de magnitud pero si el detalle metrico si en algun momento se muestra distancia exacta en UI.
3. **ESCALERA fuera del enum `tipo_transito`.** El canonico documenta un desnivel entre Sector 1 y Sectores 2/3/4 con dos rutas: `rampa` (accesible) y `escalon` (no accesible). El enum v5 (`EXTERIOR, PASILLO, RAMPA, RIPIO`) no tiene un valor para escalon, y en el grafo de conexiones no existe ningun tramo directo interior entre el pasillo de Sector 1 (id 36) y los demas sectores - la unica ruta modelada vuelve a salir por la Entrada Principal CFP7 y entra por el patio (ruta exterior/rampa). **Lectura:** el escalon nunca esta modelado porque el grafo de v5, igual que el canonico, solo representa caminos transitables (rutas por las que se puede circular a pie, con o sin restriccion de accesibilidad) - no todas las conexiones fisicas del edificio. Es consistente, no es un bug; solo hay que tenerlo claro para no buscar un tramo "S1 -> S4 directo" que no va a aparecer.

## c) Impacto

**En la 3ra visita:** no cambia el listado de pendientes de `PENDIENTES.md` punto 2 (ancho real en varios puntos, luz de paso de puertas, superficie de maniobra en banos, pendiente de rampas, altura de desniveles). Lo que si cambia es el destino de esos datos: antes se pensaba escribirlos directo sobre el slug canonico; ahora, si se quiere que la API los refleje, hay que pasarlos por Back contra los `id` de v5 (via `datos/mapeo_slug_id_v5.json`) porque el `accesible` real de banos y pasillos no esta en el seed actual.

**Post-MVP:** el filtro "solo accesible" del algoritmo de recorridos (`POST /api/recorridos/calcular`) no usa el bit `accesible`, penaliza por `tipoTransito` (RAMPA < PASILLO < EXTERIOR < RIPIO), asi que el problema de (b.1) no rompe ese endpoint puntual. Si el dashboard llega a mostrar accesibilidad por espacio/conexion (badge, filtro de buscador) tomando el campo `accesible` de `GET /api/espacios` o `/api/conexiones` tal cual viene, va a mostrar mal el bano chico de S1 y el pasillo de lockers. Anotarlo como bloqueante de esa feature especifica, no del MVP entero.

## Endpoints GET relevantes para el futuro switch mock -> API real
Extraidos de los PDF `API Espacios, Conexiones y Recorridos.pdf` y `Cambios API v5.pdf`. El dashboard del demo sigue contra `mocks/db.json` en esta pasada; esto queda como referencia para cuando se haga el switch.

| Metodo | Ruta | Rol requerido | Notas |
|---|---|---|---|
| GET | `/api/espacios` | OWNER, ADMIN | Todos los espacios. |
| GET | `/api/espacios/{id}` | No hace falta rol | Detalle de un espacio. |
| GET | `/api/espacios/mapa` | No hace falta rol | Solo espacios ACTIVO, para el mapa. Parametro opcional `tipo=` (ej. `LABORATORIO`). |
| GET | `/api/espacios/buscar` | No hace falta rol | Mencionado en la tabla de roles de `Cambios API v5.pdf`; sin detalle de parametros/response en el PDF de API - confirmar con Jonathan. |
| GET | `/api/conexiones` | No hace falta rol | Conexiones en estado ACTIVA. |
| GET | `/api/conexiones/{id}` | OWNER, ADMIN | Detalle de una conexion. |
| GET | `/api/conexiones/mapa` | No hace falta rol | Mencionado en la tabla de roles; sin detalle de response en el PDF de API - confirmar con Jonathan (posible duplicado o superset de `GET /api/conexiones`). |
| POST | `/api/recorridos/calcular` | No hace falta rol | Body `{origenId, destinoId, soloAccesible}`. Devuelve espacios + conexiones del tramo + `distanciaTotal`. Nota de Back: caso pendiente - recorrido totalmente bloqueado devuelve 500 (se esta corrigiendo). Sin auditoria todavia. |

**Reportes:** los PDF confirman que existen endpoints bajo `/api/reportes` (dominio de Ian/Lilia, no de Jonathan/mapa) pero no detallan rutas ni responses - no incluidos en `API Espacios, Conexiones y Recorridos.pdf`. Pedir el PDF/doc especifico de reportes cuando se planifique ese switch.

Endpoints de escritura (fuera del alcance de esta reconciliacion, documentados en el PDF por si hacen falta mas adelante): `POST /api/espacios`, `PUT /api/espacios/{id}` (segun tabla de roles; el PDF de detalle solo muestra POST para alta), `PATCH /api/espacios/{id}/estado`, `POST /api/conexiones`, `PUT /api/conexiones/{id}` (idem), `PATCH /api/conexiones/{id}/estado`. La discrepancia POST/PUT entre el PDF de detalle y la tabla de roles de "Cambios API v5" no se resolvio - anotar para preguntar a Jonathan si hace falta tocar estos endpoints.

## Adenda: API_DOC.md (rama jhon-2, build 2026-07-15)

Fuente: `API_DOC.md` de la rama `origin/jhon-2` de `campusApi-backend`, commit `9b667b0` ("Se agregó el manejo de estados en espacios y conexiones para el cálculo de recorridos", 2026-07-15). Este documento llegó a la vista indirectamente: alguien del equipo agregó a `campusApi-backend/` un `backend-api.jar` (fat jar Spring Boot, sin trackear en git) cuyo `application.properties` embebido matchea la config de esa rama, lo que permitió ubicar el commit de origen y leer el `API_DOC.md` correspondiente vía `git show`. No se corrió el jar (faltan JDK 25, MySQL local y variables de entorno).

### 1. Contrato de Reportes (llena el hueco marcado en la seccion de Endpoints de arriba)

Formato de respuesta de `Reporte`:
```json
{
  "id": Long,
  "espacioId": Long,
  "nombreEspacio": String,
  "descripcion": String,
  "estadoReporte": String,
  "tipoReporte": String,
  "minutosEstimados": Integer,
  "fechaVencimiento": String,
  "fechaCreacion": String
}
```

| Metodo | Ruta | Rol requerido | Notas |
|---|---|---|---|
| POST | `/api/reportes` | OWNER, ADMIN, PERSONAL | Crea reporte. No permite mas de un reporte activo del mismo `tipoReporte` por espacio. |
| POST | `/api/reportes/{id}/atender` | OWNER, ADMIN, PERSONAL | Marca atendido y/o edita `minutosEstimados`/`descripcion`. |
| POST | `/api/reportes/{id}/resolver` | OWNER, ADMIN, PERSONAL | Marca `RESUELTO`. |
| GET | `/api/reportes/{id}` | OWNER, ADMIN, PERSONAL | Detalle. |
| GET | `/api/reportes` | OWNER, ADMIN, PERSONAL | Lista paginada (formato Page de Spring), filtros `espacioId`, `estado`, `tipoReporte`, `page`, `size`. |

`estadoReporte` (3 valores segun API_DOC): `PENDIENTE`, `EN_REVISION`, `RESUELTO`.

### 2. Decisión sobre tipoReporte

Decisión (2026-07-17): el contrato de datos usa los 4 tipos de API_DOC (ACCESO_BLOQUEADO, PROBLEMA_SENALETICA, BARRERA_FISICA, DIFICULTAD_ORIENTACION). OTROS queda fuera del contrato aunque exista en el enum de la base v5 — no se consulta a Back, no se expone en formularios.

### 3. Nota de gobernanza

El build del jar corresponde a la rama `jhon-2`, que esta **188 archivos y +6053/-616 lineas adelante de `main`** (incluye `AuditoriaController`, `ReporteController` y el manejo de estados de espacios/conexiones para recorridos, nada de lo cual esta en `main` todavia) y **no esta mergeada**.

**Decision:** el switch del dashboard mock -> API real no se construye contra builds de ramas WIP (por mas que ya circule un jar corriendolas). Se retoma el trabajo de switch cuando `jhon-2` (o el trabajo que contiene) este mergeado a `main`.

### 4. Nota de diseño pendiente

`GET /api/reportes` requiere rol `OWNER`, `ADMIN` o `PERSONAL` (ningun endpoint de reportes es de acceso publico). Un dashboard estatico que hoy consume `mocks/db.json` sin autenticacion no puede consumir este endpoint tal cual: hace falta resolver como el dashboard obtiene y renueva un JWT (login propio, token de servicio, proxy con credenciales fijas, etc.) antes de que el switch de la card de reportes sea viable. Queda como decision de diseño pendiente, no bloqueante para las cards que sí pegan a endpoints publicos (`/api/espacios/mapa`, `/api/conexiones`).
