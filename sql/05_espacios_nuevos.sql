-- ==========================================
-- Adaptado a schema techlab v5 — NO correr contra el schema canónico.
-- Generado: 2026-07-20 por Data. Tabla real: `espacios`.
-- Sin coordenadas (coordenadax/coordenaday quedan NULL): las está armando Back.
-- ids se asignan al insertar — actualizar datos/mapeo_slug_id_v5.json con los ids
-- resultantes cuando Back confirme.
-- ==========================================

-- REQUIERE: agregar BUFFET al enum `tipo` de espacios (pedido a Back). No correr antes.
INSERT INTO espacios (nombre, tipo, sector, estado, accesible) VALUES ('Buffet', 'BUFFET', 'SECTOR_4', 'ACTIVO', 1); -- id se asigna al insertar

INSERT INTO espacios (nombre, tipo, sector, estado, accesible) VALUES ('Orientación', 'OFICINA', 'SECTOR_3', 'ACTIVO', 1); -- id se asigna al insertar
