-- ==========================================
-- Adaptado a schema techlab v5 — NO correr contra el schema canónico.
-- Fuente de ids: datos/mapeo_slug_id_v5.json
-- Generado: 2026-07-17 por Data. Tablas reales del dump: `espacios`, `reportes` (plural).
-- ==========================================

-- ==========================================
-- BLOQUE A: accesible en espacios (criterio de practicabilidad, ver analisis/RECONCILIACION_V5.md)
-- Los 5 pasillos internos (ids 36-40) y el resto de espacios ya vienen accesible=1 en el seed v5;
-- coinciden con el criterio de practicabilidad (ancho_m >= 0.90) y NO se tocan.
-- Unica excepcion: s1_bano_chico (id 6).
-- ==========================================
UPDATE espacios SET accesible = 0 WHERE id = 6; -- slug: s1_bano_chico (espacio de maniobra interior insuficiente para giro de silla, no ancho de paso)

-- ==========================================
-- BLOQUE B: reportes de campo (traducidos de sql/02_seed_reportes.sql)
-- La v5 ya tiene los 5 pasillos seedeados como espacios (ids 36-40); no se recrean (Parte A del
-- script original queda sin traducir a proposito).
-- NOTA: reportes.atendido_por es NOT NULL en v5 y no tiene equivalente en el canonico. Se usa el
-- usuario SYSTEM (id 1, ya seedeado en techlab.sql) porque estos reportes se cargan por Data desde
-- el relevamiento de campo, no fueron atendidos por un usuario real. CONFIRMAR con Back/Ian-Lilia
-- si corresponde otro valor.
-- ==========================================
INSERT INTO reportes (descripcion, estado, fecha_creacion, tipo, atendido_por, espacio_id) VALUES ('Relevamiento de campo: ancho 1.67 m, bajo el minimo de 2.00 m para corredores educativos (Ley 962 CABA art. 7.6.1.1). Largo 21.0 m.', 'PENDIENTE', '2026-06-12 10:00:00', 'BARRERA_FISICA', 1, 36); -- slug: p_s1
INSERT INTO reportes (descripcion, estado, fecha_creacion, tipo, atendido_por, espacio_id) VALUES ('Relevamiento de campo: ancho 1.50 m, bajo el minimo de 2.00 m para corredores educativos (Ley 962 CABA art. 7.6.1.1). Largo 24.0 m.', 'PENDIENTE', '2026-06-12 10:00:00', 'BARRERA_FISICA', 1, 37); -- slug: p_s3_principal
INSERT INTO reportes (descripcion, estado, fecha_creacion, tipo, atendido_por, espacio_id) VALUES ('Relevamiento de campo: ancho 1.47 m, bajo el minimo de 2.00 m para corredores educativos (Ley 962 CABA art. 7.6.1.1). Largo 6.14 m.', 'PENDIENTE', '2026-06-12 10:00:00', 'BARRERA_FISICA', 1, 38); -- slug: p_s3_lateral
INSERT INTO reportes (descripcion, estado, fecha_creacion, tipo, atendido_por, espacio_id) VALUES ('Relevamiento de campo: ancho 1.58 m, bajo el minimo de 2.00 m para corredores educativos (Ley 962 CABA art. 7.6.1.1). Largo 31.78 m.', 'PENDIENTE', '2026-06-12 10:00:00', 'BARRERA_FISICA', 1, 39); -- slug: p_s4_principal
INSERT INTO reportes (descripcion, estado, fecha_creacion, tipo, atendido_por, espacio_id) VALUES ('Relevamiento de campo: ancho 1.08 m, bajo el minimo de 2.00 m para corredores educativos (Ley 962 CABA art. 7.6.1.1). Largo 6.0 m.', 'PENDIENTE', '2026-06-12 10:00:00', 'BARRERA_FISICA', 1, 40); -- slug: p_s4_lockers
INSERT INTO reportes (descripcion, estado, fecha_creacion, tipo, atendido_por, espacio_id) VALUES ('Relevamiento de campo: bano no accesible (confirmado en 2do relevamiento).', 'PENDIENTE', '2026-06-12 10:00:00', 'BARRERA_FISICA', 1, 6); -- slug: s1_bano_chico
