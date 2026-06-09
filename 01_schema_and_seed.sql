-- ==========================================
-- 1. CREACIÓN DE TABLAS (Esquema DER)
-- ==========================================

CREATE TABLE IF NOT EXISTS sector (
    id VARCHAR(50) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    tipo VARCHAR(50) NOT NULL, -- ej: 'aula', 'oficina', 'espacio_comun', 'acceso'
    accesible BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS recorrido (
    id VARCHAR(50) PRIMARY KEY,
    origen_id VARCHAR(50) NOT NULL,
    destino_id VARCHAR(50) NOT NULL,
    accesible BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (origen_id) REFERENCES sector(id),
    FOREIGN KEY (destino_id) REFERENCES sector(id)
);

CREATE TABLE IF NOT EXISTS tramo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recorrido_id VARCHAR(50) NOT NULL,
    orden INT NOT NULL,
    instruccion TEXT NOT NULL,
    referencia_visual_url VARCHAR(255),
    FOREIGN KEY (recorrido_id) REFERENCES recorrido(id)
);

CREATE TABLE IF NOT EXISTS reporte (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sector_id VARCHAR(50) NOT NULL,
    tipo_incidencia VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL,
    imagen_evidencia_url VARCHAR(255),
    estado VARCHAR(50) DEFAULT 'ABIERTO',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sector_id) REFERENCES sector(id)
);

-- ==========================================
-- 2. POBLACIÓN DE DATOS (Seeders)
-- Basado en los JSON de QA (Corrigiendo reglas de negocio)
-- ==========================================

-- Insertar Sectores (Se eliminó cualquier referencia a 'Pabellón')
INSERT INTO sector (id, nombre, descripcion, tipo, accesible) VALUES
('entrada_01', 'Acceso Dragones y Mendoza', 'Acceso desde calle Dragones y Mendoza hacia calle interna', 'acceso', TRUE),
('sector_01', 'Sector P', 'Primera vista al ingresar desde calle interna', 'sector', FALSE),
('sector_02', 'Patio General', 'Patio abierto con mástil', 'espacio_comun', TRUE),
('acceso_01', 'Rampa principal', 'Rampa en forma de retorno hacia puerta principal', 'acceso', TRUE),
('oficina_01', 'Secretaría y Dirección', 'Corredor principal - lado derecho', 'oficina', TRUE),
('oficina_02', 'Informes e Inscripciones', 'Corredor principal - lado izquierdo', 'oficina', TRUE),
('aula_01', 'Aula 1', 'Planta baja', 'aula', TRUE),
('aula_02', 'Aula 2', 'Planta baja', 'aula', TRUE),
('aula_03', 'Aula 3', 'Planta baja', 'aula', TRUE);

-- Insertar Recorridos Básicos
INSERT INTO recorrido (id, origen_id, destino_id, accesible) VALUES
('ruta_01', 'entrada_01', 'oficina_01', TRUE),
('ruta_02', 'entrada_01', 'aula_01', TRUE);

-- Insertar Tramos de ejemplo para la ruta_01
INSERT INTO tramo (recorrido_id, orden, instruccion, referencia_visual_url) VALUES
('ruta_01', 1, 'Ingresa por el portón principal de Dragones y Mendoza', NULL),
('ruta_01', 2, 'Avanza 20 metros por la calle interna hasta la rampa principal', NULL),
('ruta_01', 3, 'Sube la rampa y gira a la derecha en el corredor principal', NULL);
