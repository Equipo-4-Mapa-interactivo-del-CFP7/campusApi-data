-- ==========================================
-- SEED CANONICO: espacios CFP7
-- Fuente: espacios_cfp7.json (relevamiento 2026-06-12, doc oficial SECTORES PARA SENALETICA)
-- Generado: 2026-07-14 por Data. NO editar a mano: regenerar desde el JSON.
-- Requiere: columna slug VARCHAR(50) UNIQUE NOT NULL en tabla espacio.
-- accesible = NULL: pendiente 3er relevamiento (#169). NO asumir true.
-- Banos como BANIO_MIXTO provisorio: tipo NO se cambia a BANIO_FEMENINO/MASCULINO (decision de
-- contrato con Back pendiente); el genero/rol confirmado se carga como DATO, no como tipo (ver
-- columnas uso/genero mas abajo y correccion 2026-07-24).
-- Correccion 2026-07-21: s1_bano_grande y s1_bano_chico -> accesible TRUE (radio de maniobra
-- interior re-evaluado como suficiente; no habra otra visita). Sector 4 sin cambios (accesible NULL).
-- Correccion 2026-07-24: mapeo fino de asignacion por recinto CONFIRMADO EN VIVO (equipo
-- Front+Back+QA reunido armando el mapa). Sector 1 es por ROL (columna uso); Sector 4 es por
-- GENERO (columna genero). Pendiente residual no bloqueante: si profesoras/profesores del doc
-- oficial tienen sub-espacio propio en S4 (ver espacios_cfp7.json _meta.pendiente).
-- ==========================================
ALTER TABLE espacio ADD COLUMN IF NOT EXISTS slug VARCHAR(50) UNIQUE;
ALTER TABLE espacio ADD COLUMN IF NOT EXISTS sector INT;
ALTER TABLE espacio ADD COLUMN IF NOT EXISTS uso VARCHAR(20);
ALTER TABLE espacio ADD COLUMN IF NOT EXISTS genero VARCHAR(20);

INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s1_electricidad', 'Electricidad', 'TALLER', 1, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s1_herreria', 'Herreria', 'TALLER', 1, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s1_climatizacion', 'Climatizacion', 'TALLER', 1, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s1_serigrafia', 'Serigrafia', 'TALLER', 1, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s1_bano_grande', 'Bano Sector 1 (grande)', 'BANIO_MIXTO', 1, TRUE, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s1_bano_chico', 'Bano Sector 1 (chico)', 'BANIO_MIXTO', 1, TRUE, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s2_carpinteria', 'Carpinteria', 'TALLER', 2, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s2_taller_bicicletas', 'Taller de bicicleteria', 'TALLER', 2, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s3_informes_regencia', 'Informes - Regencia', 'OFICINA', 3, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s3_secretaria_direccion', 'Secretaria - Direccion', 'OFICINA', 3, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s3_oficina_estudiantes', 'Oficina de estudiantes', 'OFICINA', 3, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s3_sala_personal', 'Sala de personal', 'OFICINA', 3, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s3_talleres_dinamicos', 'Area de talleres dinamicos', 'TALLER', 3, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s3_lab_informatica_a', 'Laboratorio de Informatica A', 'LABORATORIO', 3, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s3_lab_informatica_b', 'Laboratorio de Informatica B', 'LABORATORIO', 3, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s3_archivo_institucional', 'Archivo institucional', 'OFICINA', 3, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s3_espacio_tecnologico', 'Espacio tecnologico multidisciplinar', 'TALLER', 3, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s4_aula_1', 'Aula 1', 'AULA', 4, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s4_aula_2', 'Aula 2', 'AULA', 4, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s4_aula_3_sum', 'Aula 3 - SUM', 'AULA', 4, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s4_aula_4', 'Aula 4', 'AULA', 4, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s4_aula_5', 'Aula 5', 'AULA', 4, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s4_gastronomia_a', 'Gastronomia A', 'TALLER', 4, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s4_gastronomia_b', 'Gastronomia B', 'TALLER', 4, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s4_gastronomia_c', 'Gastronomia C', 'TALLER', 4, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s4_preceptoria_eps', 'Preceptoria EPS', 'OFICINA', 4, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s4_eps_ifts', 'EPS - IFTS N5', 'OFICINA', 4, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s4_bano_grande', 'Bano Sector 4 (grande)', 'BANIO_MIXTO', 4, NULL, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('s4_bano_mediano', 'Bano Sector 4 (mediano)', 'BANIO_MIXTO', 4, NULL, TRUE);

-- ==========================================
-- Mapeo fino de asignacion por recinto (CONFIRMADO EN VIVO 2026-07-24, equipo Front+Back+QA).
-- Se carga como dato (uso/genero), NO se cambia el tipo BANIO_MIXTO: mismo criterio marcado a
-- Back sobre no hornear el binario de genero en el enum (ver diagnostico data.sql).
-- ==========================================
UPDATE espacio SET uso = 'docentes' WHERE slug = 's1_bano_grande';
UPDATE espacio SET uso = 'alumnos' WHERE slug = 's1_bano_chico';
UPDATE espacio SET genero = 'femenino' WHERE slug = 's4_bano_grande';
UPDATE espacio SET genero = 'masculino' WHERE slug = 's4_bano_mediano';
