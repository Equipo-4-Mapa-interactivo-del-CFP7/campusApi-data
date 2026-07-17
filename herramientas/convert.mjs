import { readFileSync, writeFileSync, readdirSync } from "fs";
import { DOMParser } from "@xmldom/xmldom";
import { gpx } from "@tmcw/togeojson";

const files = readdirSync(".").filter(f => f.toLowerCase().endsWith(".gpx"));
const features = [];

for (const file of files) {
  const xml = new DOMParser().parseFromString(readFileSync(file, "utf8"), "text/xml");
  const fc = gpx(xml);
  const base = file.replace(/\.gpx$/i, "").trim();

  for (const f of fc.features) {
    const g = f.geometry;
    if (!g) continue;
    const lines = g.type === "MultiLineString" ? g.coordinates
                : g.type === "LineString" ? [g.coordinates]
                : [];
    lines.forEach((coords, i) => {
      if (coords.length < 2) return;
      features.push({
        type: "Feature",
        properties: {
          name: base,
          seg: lines.length > 1 ? i + 1 : null,
          accesible: null,
          barrera: null,
          incompleto: false,
          puntos: coords.length
        },
        geometry: { type: "LineString", coordinates: coords }
      });
    });
  }
}

writeFileSync("combined_raw.geojson", JSON.stringify({ type: "FeatureCollection", features }));
console.log(`OK: ${features.length} LineStrings de ${files.length} archivos`);
