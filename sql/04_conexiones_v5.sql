-- ==========================================
-- Adaptado a schema techlab v5 — NO correr contra el schema canónico.
-- Fuente de ids: datos/mapeo_slug_id_v5.json
-- Generado: 2026-07-20 por Data. Tabla real del dump: `conexiones`.
--
-- La v5 ya trae conexiones seedeadas — decidir con Back si este archivo REEMPLAZA
-- (DELETE previo) o complementa. Por defecto incluye el DELETE comentado.
--
-- Grafo contraído a la granularidad de la v5 (un pasillo = un nodo). Las distancias
-- de tramos internos de pasillo no son representables en este modelo; las distancias
-- habitación↔pasillo son las medidas reales. El grafo fino original queda en
-- datos/conexiones_cfp7.json.
--
-- Nodos sintéticos de datos/conexiones_cfp7.json contraídos al id v5 del pasillo:
--   entrada_s1, fondo_s1              -> 36 (p_s1)
--   entrada_s3                        -> 37 (p_s3_principal)
--   cruce_pasillo_lateral_s3           -> 38 (p_s3_lateral)
--   entrada_s4, fondo_s4              -> 39 (p_s4_principal)
--   cruce_pasillo_lockers             -> 40 (p_s4_lockers)
--   patio_s3                          -> 42 (Patio comunicante Sector 3 y 4, confirmado 2026-07-20)
--
-- 31/31 tramos de datos/conexiones_cfp7.json.tramos_interiores traducidos. Contracción
-- verificada sin self-loops ni pares origen-destino duplicados.
--
-- NOTA: `estado` es NOT NULL en v5 y no tiene campo equivalente en el canonico; se usa
-- 'ACTIVA' para los 31 (coincide con el estado de las conexiones ya seedeadas en v5).
-- ==========================================

-- Descomentar si Back confirma que este archivo REEMPLAZA el seed de conexiones existente:
-- DELETE FROM conexiones;

INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.67, 0, 10.73, 'ACTIVA', 'PASILLO', 3, 36); -- entrada_s1 -> s1_climatizacion
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.67, 0, 5.96, 'ACTIVA', 'PASILLO', 5, 3); -- s1_climatizacion -> s1_bano_grande
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.67, 0, 0.8, 'ACTIVA', 'PASILLO', 6, 5); -- s1_bano_grande -> s1_bano_chico
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.67, 0, 2.16, 'ACTIVA', 'PASILLO', 1, 36); -- entrada_s1 -> s1_electricidad
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.67, 0, 9.2, 'ACTIVA', 'PASILLO', 2, 1); -- s1_electricidad -> s1_herreria
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.67, 0, 7.0, 'ACTIVA', 'PASILLO', 36, 2); -- s1_herreria -> fondo_s1
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.5, 0, 1.5, 'ACTIVA', 'PASILLO', 10, 37); -- entrada_s3 -> s3_secretaria_direccion
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.5, 0, 4.87, 'ACTIVA', 'PASILLO', 11, 10); -- s3_secretaria_direccion -> s3_oficina_estudiantes
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.5, 0, 5.7, 'ACTIVA', 'PASILLO', 38, 11); -- s3_oficina_estudiantes -> cruce_pasillo_lateral_s3
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.5, 0, 5.3, 'ACTIVA', 'PASILLO', 16, 15); -- s3_lab_informatica_b -> s3_archivo_institucional
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.5, 0, 1.5, 'ACTIVA', 'PASILLO', 9, 37); -- entrada_s3 -> s3_informes_regencia
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.5, 0, 1.8, 'ACTIVA', 'PASILLO', 14, 9); -- s3_informes_regencia -> s3_lab_informatica_a
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.5, 0, 3.07, 'ACTIVA', 'PASILLO', 12, 14); -- s3_lab_informatica_a -> s3_sala_personal
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.5, 0, 3.0, 'ACTIVA', 'PASILLO', 13, 12); -- s3_sala_personal -> s3_talleres_dinamicos
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.5, 0, 10.8, 'ACTIVA', 'PASILLO', 16, 13); -- s3_talleres_dinamicos -> s3_archivo_institucional
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.47, 0, 6.14, 'ACTIVA', 'PASILLO', 42, 38); -- cruce_pasillo_lateral_s3 -> patio_comunicante_s3_s4
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 5.6, 'ACTIVA', 'PASILLO', 27, 39); -- entrada_s4 -> s4_eps_ifts
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 3.3, 'ACTIVA', 'PASILLO', 26, 27); -- s4_eps_ifts -> s4_preceptoria_eps
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 1.6, 'ACTIVA', 'PASILLO', 40, 26); -- s4_preceptoria_eps -> cruce_pasillo_lockers
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 3.76, 'ACTIVA', 'PASILLO', 29, 40); -- cruce_pasillo_lockers -> s4_bano_mediano
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 6.32, 'ACTIVA', 'PASILLO', 25, 29); -- s4_bano_mediano -> s4_gastronomia_c
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 4.0, 'ACTIVA', 'PASILLO', 24, 25); -- s4_gastronomia_c -> s4_gastronomia_b
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 1.5, 'ACTIVA', 'PASILLO', 39, 24); -- s4_gastronomia_b -> fondo_s4
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 1.5, 'ACTIVA', 'PASILLO', 18, 39); -- entrada_s4 -> s4_aula_1
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 3.96, 'ACTIVA', 'PASILLO', 19, 18); -- s4_aula_1 -> s4_aula_2
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 2.4, 'ACTIVA', 'PASILLO', 20, 19); -- s4_aula_2 -> s4_aula_3_sum
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 5.7, 'ACTIVA', 'PASILLO', 21, 20); -- s4_aula_3_sum -> s4_aula_4
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 3.2, 'ACTIVA', 'PASILLO', 22, 21); -- s4_aula_4 -> s4_aula_5
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 8.67, 'ACTIVA', 'PASILLO', 23, 22); -- s4_aula_5 -> s4_gastronomia_a
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.58, 0, 1.5, 'ACTIVA', 'PASILLO', 39, 23); -- s4_gastronomia_a -> fondo_s4
INSERT INTO conexiones (accesible, ancho, cumple_ley962, distancia, estado, tipo_transito, espacio_destino_id, espacio_origen_id) VALUES (1, 1.08, 0, 2.0, 'ACTIVA', 'PASILLO', 28, 40); -- cruce_pasillo_lockers -> s4_bano_grande
