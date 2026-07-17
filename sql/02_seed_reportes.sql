-- ==========================================
-- SEED REPORTES: incidencias REALES del relevamiento de campo
-- Fuente: espacios_cfp7.json (pasillos + barreras confirmadas). Generado 2026-07-14 por Data.
-- Parte A: pasillos como espacios PUNTO_DE_PASO (los reportes necesitan FK a espacio).
-- Parte B: reportes con FK resuelta por slug (subquery), robustos ante orden de insercion.
-- ==========================================

-- A) Pasillos como espacios
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('p_s1', 'Pasillo principal Sector 1', 'PUNTO_DE_PASO', 1, FALSE, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('p_s3_principal', 'Pasillo principal Sector 3', 'PUNTO_DE_PASO', 3, FALSE, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('p_s3_lateral', 'Pasillo lateral Sector 3 (al patio)', 'PUNTO_DE_PASO', 3, FALSE, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('p_s4_principal', 'Pasillo principal Sector 4', 'PUNTO_DE_PASO', 4, FALSE, TRUE);
INSERT INTO espacio (slug, nombre, tipo, sector, accesible, activo) VALUES ('p_s4_lockers', 'Pasillo lateral Sector 4 (lockers)', 'PUNTO_DE_PASO', 4, FALSE, TRUE);

-- B) Reportes de campo
INSERT INTO reporte (espacio_id, tipo, descripcion, estado, fecha_creacion) VALUES ((SELECT id FROM espacio WHERE slug = 'p_s1'), 'BARRERA_FISICA', 'Relevamiento de campo: ancho 1.67 m, bajo el minimo de 2.00 m para corredores educativos (Ley 962 CABA art. 7.6.1.1). Largo 21.0 m.', 'PENDIENTE', '2026-06-12 10:00:00');
INSERT INTO reporte (espacio_id, tipo, descripcion, estado, fecha_creacion) VALUES ((SELECT id FROM espacio WHERE slug = 'p_s3_principal'), 'BARRERA_FISICA', 'Relevamiento de campo: ancho 1.50 m, bajo el minimo de 2.00 m para corredores educativos (Ley 962 CABA art. 7.6.1.1). Largo 24.0 m.', 'PENDIENTE', '2026-06-12 10:00:00');
INSERT INTO reporte (espacio_id, tipo, descripcion, estado, fecha_creacion) VALUES ((SELECT id FROM espacio WHERE slug = 'p_s3_lateral'), 'BARRERA_FISICA', 'Relevamiento de campo: ancho 1.47 m, bajo el minimo de 2.00 m para corredores educativos (Ley 962 CABA art. 7.6.1.1). Largo 6.14 m.', 'PENDIENTE', '2026-06-12 10:00:00');
INSERT INTO reporte (espacio_id, tipo, descripcion, estado, fecha_creacion) VALUES ((SELECT id FROM espacio WHERE slug = 'p_s4_principal'), 'BARRERA_FISICA', 'Relevamiento de campo: ancho 1.58 m, bajo el minimo de 2.00 m para corredores educativos (Ley 962 CABA art. 7.6.1.1). Largo 31.78 m.', 'PENDIENTE', '2026-06-12 10:00:00');
INSERT INTO reporte (espacio_id, tipo, descripcion, estado, fecha_creacion) VALUES ((SELECT id FROM espacio WHERE slug = 'p_s4_lockers'), 'BARRERA_FISICA', 'Relevamiento de campo: ancho 1.08 m, bajo el minimo de 2.00 m para corredores educativos (Ley 962 CABA art. 7.6.1.1). Largo 6.0 m.', 'PENDIENTE', '2026-06-12 10:00:00');
INSERT INTO reporte (espacio_id, tipo, descripcion, estado, fecha_creacion) VALUES ((SELECT id FROM espacio WHERE slug = 's1_bano_chico'), 'BARRERA_FISICA', 'Relevamiento de campo: bano no accesible (confirmado en 2do relevamiento).', 'PENDIENTE', '2026-06-12 10:00:00');
