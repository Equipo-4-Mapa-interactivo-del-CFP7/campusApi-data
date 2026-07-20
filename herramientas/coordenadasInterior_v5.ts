// Generado por Data desde el seed v5 — ids oficiales de la base.
// Reemplaza mocks con ids re-numerados: un espacio referenciado por este id
// coincide con lo que devuelve la API real.
//
// Fuente: recibidos/v5/techlab.sql (tabla `espacios`, columnas coordenadax/coordenaday).
// Solo se listan los espacios que tienen coordenadas cargadas en el seed v5 (14 de 43).
// slug: desde datos/mapeo_slug_id_v5.json; null para ids sin slug (30-35, 41-43 - no
// modelados como espacio en el canonico).
// coords: [coordenaday, coordenadax] (orden Y,X - el mismo que usa el mock de Front).
// accesible: fix de s1_bano_chico (id 6) = false no aplica a este archivo porque ese
// espacio no tiene coordenadas en el seed v5 (no aparece en esta lista). El resto
// coincide con el criterio de practicabilidad (ver analisis/RECONCILIACION_V5.md).

export interface EspacioCoordenadaV5 {
  id: number;
  nombre: string;
  slug: string | null;
  coords: [number, number];
  sector: string;
  accesible: boolean;
}

export const coordenadasInteriorV5: EspacioCoordenadaV5[] = [
  { id: 7, nombre: "Carpinteria", slug: "s2_carpinteria", coords: [725, 1925], sector: "SECTOR_2", accesible: true },
  { id: 10, nombre: "Secretaria - Direccion", slug: "s3_secretaria_direccion", coords: [385, 2545], sector: "SECTOR_3", accesible: true },
  { id: 11, nombre: "Oficina de estudiantes", slug: "s3_oficina_estudiantes", coords: [580, 2530], sector: "SECTOR_3", accesible: true },
  { id: 12, nombre: "Sala de personal", slug: "s3_sala_personal", coords: [525, 2310], sector: "SECTOR_3", accesible: true },
  { id: 13, nombre: "Área de talleres dinamicos", slug: "s3_talleres_dinamicos", coords: [650, 2290], sector: "SECTOR_3", accesible: true },
  { id: 14, nombre: "Laboratorio de Informatica A", slug: "s3_lab_informatica_a", coords: [430, 2300], sector: "SECTOR_3", accesible: true },
  { id: 15, nombre: "Laboratorio de Informatica B", slug: "s3_lab_informatica_b", coords: [730, 2505], sector: "SECTOR_3", accesible: true },
  { id: 17, nombre: "Espacio tecnologico multidisciplinar", slug: "s3_espacio_tecnologico", coords: [735, 2405], sector: "SECTOR_3", accesible: true },
  { id: 18, nombre: "Aula 1", slug: "s4_aula_1", coords: [835, 2715], sector: "SECTOR_4", accesible: true },
  { id: 19, nombre: "Aula 2", slug: "s4_aula_2", coords: [835, 2815], sector: "SECTOR_4", accesible: true },
  { id: 20, nombre: "Aula 3 - SUM", slug: "s4_aula_3_sum", coords: [835, 2925], sector: "SECTOR_4", accesible: true },
  { id: 26, nombre: "Preceptoria EPS", slug: "s4_preceptoria_eps", coords: [620, 2905], sector: "SECTOR_4", accesible: true },
  { id: 30, nombre: "Entrada Principal CFP7", slug: null, coords: [200, 2455], sector: "ENTRADAS", accesible: true },
  { id: 43, nombre: "Frente CFP7", slug: null, coords: [200, 2455], sector: "ENTRADAS", accesible: true },
];

// Pendientes de posicionar sobre el plano: sin coordenadax/coordenaday en el seed v5.
// Los ids son igualmente los oficiales — al asignarles coordenadas, conservar estos ids.
export interface EspacioSinCoordenadaV5 {
  id: number;
  nombre: string;
  slug: string | null;
  sector: string;
  coords: null;
}

export const espaciosSinCoordenadas: EspacioSinCoordenadaV5[] = [
  { id: 1, nombre: "Electricidad", slug: "s1_electricidad", sector: "SECTOR_1", coords: null },
  { id: 2, nombre: "Herreria", slug: "s1_herreria", sector: "SECTOR_1", coords: null },
  { id: 3, nombre: "Climatizacion", slug: "s1_climatizacion", sector: "SECTOR_1", coords: null },
  { id: 4, nombre: "Serigrafia", slug: "s1_serigrafia", sector: "SECTOR_1", coords: null },
  { id: 5, nombre: "Bano Sector 1 (grande)", slug: "s1_bano_grande", sector: "SECTOR_1", coords: null },
  { id: 6, nombre: "Bano Sector 1 (chico)", slug: "s1_bano_chico", sector: "SECTOR_1", coords: null },
  { id: 8, nombre: "Taller de bicicleteria", slug: "s2_taller_bicicletas", sector: "SECTOR_2", coords: null },
  { id: 9, nombre: "Informes - Regencia", slug: "s3_informes_regencia", sector: "SECTOR_3", coords: null },
  { id: 16, nombre: "Archivo institucional", slug: "s3_archivo_institucional", sector: "SECTOR_3", coords: null },
  { id: 21, nombre: "Aula 4", slug: "s4_aula_4", sector: "SECTOR_4", coords: null },
  { id: 22, nombre: "Aula 5", slug: "s4_aula_5", sector: "SECTOR_4", coords: null },
  { id: 23, nombre: "Gastronomia A", slug: "s4_gastronomia_a", sector: "SECTOR_4", coords: null },
  { id: 24, nombre: "Gastronomia B", slug: "s4_gastronomia_b", sector: "SECTOR_4", coords: null },
  { id: 25, nombre: "Gastronomia C", slug: "s4_gastronomia_c", sector: "SECTOR_4", coords: null },
  { id: 27, nombre: "EPS - IFTS N5", slug: "s4_eps_ifts", sector: "SECTOR_4", coords: null },
  { id: 28, nombre: "Bano Sector 4 (grande)", slug: "s4_bano_grande", sector: "SECTOR_4", coords: null },
  { id: 29, nombre: "Bano Sector 4 (mediano)", slug: "s4_bano_mediano", sector: "SECTOR_4", coords: null },
  { id: 31, nombre: "Dragones", slug: null, sector: "ENTRADAS", coords: null },
  { id: 32, nombre: "Ramsay", slug: null, sector: "ENTRADAS", coords: null },
  { id: 33, nombre: "Juramento", slug: null, sector: "ENTRADAS", coords: null },
  { id: 34, nombre: "Echeverria", slug: null, sector: "ENTRADAS", coords: null },
  { id: 35, nombre: "Olazabal", slug: null, sector: "ENTRADAS", coords: null },
  { id: 36, nombre: "Pasillo Principal Sector 1", slug: "p_s1", sector: "SECTOR_1", coords: null },
  { id: 37, nombre: "Pasillo Principal Sector 3", slug: "p_s3_principal", sector: "SECTOR_3", coords: null },
  { id: 38, nombre: "Pasillo Lateral Sector 3", slug: "p_s3_lateral", sector: "SECTOR_3", coords: null },
  { id: 39, nombre: "Pasillo Principal Sector 4", slug: "p_s4_principal", sector: "SECTOR_4", coords: null },
  { id: 40, nombre: "Pasillo Lockers Sector 4", slug: "p_s4_lockers", sector: "SECTOR_4", coords: null },
  { id: 41, nombre: "Patio entre Sector 2 y 3", slug: null, sector: "SECTOR_2", coords: null },
  { id: 42, nombre: "Patio comunicante Sector 3 y 4", slug: null, sector: "SECTOR_3", coords: null },
];
