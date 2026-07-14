-- ==========================================
-- TELEMETRIA Y DASHBOARD - CFP7
-- entidad_id guarda el espacio_id del evento (slug, ej. s4_aula_1).
-- Para recorrido_iniciado, entidad_id = destino_id (origen no se persiste; ningun KPI lo usa).
-- ==========================================

-- 1. TABLA DE TELEMETRIA
CREATE TABLE IF NOT EXISTS evento_telemetria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_evento VARCHAR(50) NOT NULL,   -- 'espacio_buscado' | 'recorrido_iniciado' | 'ficha_consultada'
    entidad_id VARCHAR(50) NOT NULL,    -- espacio_id (o destino_id en recorridos)
    requiere_accesibilidad BOOLEAN DEFAULT FALSE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 2. QUERIES DASHBOARD (Sprint 5)
-- ==========================================

-- KPI 1: Top 5 espacios mas buscados
SELECT esp.nombre, COUNT(e.id) AS total_busquedas
FROM evento_telemetria e
JOIN espacio esp ON e.entidad_id = esp.id
WHERE e.tipo_evento = 'espacio_buscado'
GROUP BY esp.id, esp.nombre
ORDER BY total_busquedas DESC
LIMIT 5;
-- Rollup por sector (requiere columna espacio.sector):
-- GROUP BY esp.sector ORDER BY total_busquedas DESC;

-- KPI 2: Porcentaje de recorridos que requirieron accesibilidad
SELECT
    (SUM(CASE WHEN requiere_accesibilidad = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS porcentaje_accesible
FROM evento_telemetria
WHERE tipo_evento = 'recorrido_iniciado';

-- KPI 3: Volumen de reportes por espacio (mapa de calor de incidencias)
SELECT esp.nombre, COUNT(r.id) AS cantidad_reportes
FROM reporte r
JOIN espacio esp ON r.espacio_id = esp.id
GROUP BY esp.id, esp.nombre
ORDER BY cantidad_reportes DESC;
-- Rollup por sector: GROUP BY esp.sector

-- KPI 4: Top 5 espacios mas visitados (fichas consultadas)
SELECT esp.nombre, COUNT(e.id) AS total_visitas
FROM evento_telemetria e
JOIN espacio esp ON e.entidad_id = esp.id
WHERE e.tipo_evento = 'ficha_consultada'
GROUP BY esp.id, esp.nombre
ORDER BY total_visitas DESC
LIMIT 5;
