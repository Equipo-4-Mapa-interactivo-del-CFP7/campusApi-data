-- ==========================================
-- 1. TABLA DE TELEMETRÍA (Para trackear uso)
-- ==========================================
CREATE TABLE IF NOT EXISTS evento_telemetria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_evento VARCHAR(50) NOT NULL, -- ej: 'espacio_buscado', 'recorrido_iniciado', 'ficha_consultada'
    entidad_id VARCHAR(50) NOT NULL,  -- el ID del sector buscado o del origen del recorrido
    requiere_accesibilidad BOOLEAN DEFAULT FALSE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 2. QUERIES PARA EL DASHBOARD (Sprint 5)
-- ==========================================

-- KPI 1: Top 5 Sectores más buscados (Wordcloud / Ranking)
SELECT s.nombre, COUNT(e.id) as total_busquedas
FROM evento_telemetria e
JOIN sector s ON e.entidad_id = s.id
WHERE e.tipo_evento = 'espacio_buscado'
GROUP BY s.id, s.nombre
ORDER BY total_busquedas DESC
LIMIT 5;

-- KPI 2: Porcentaje de recorridos que requirieron accesibilidad
SELECT
    (SUM(CASE WHEN requiere_accesibilidad = TRUE THEN 1 ELSE 0 END) / COUNT(*)) * 100 as porcentaje_accesible
FROM evento_telemetria
WHERE tipo_evento = 'recorrido_iniciado';

-- KPI 3: Volumen de reportes por Sector (Mapa de calor de incidencias)
SELECT s.nombre, COUNT(r.id) as cantidad_reportes
FROM reporte r
JOIN sector s ON r.sector_id = s.id
GROUP BY s.id, s.nombre
ORDER BY cantidad_reportes DESC;

-- KPI 4: Top 5 Sectores más visitados (fichas consultadas)
SELECT s.nombre, COUNT(e.id) as total_visitas
FROM evento_telemetria e
JOIN sector s ON e.entidad_id = s.id
WHERE e.tipo_evento = 'ficha_consultada'
GROUP BY s.id, s.nombre
ORDER BY total_visitas DESC
LIMIT 5;
