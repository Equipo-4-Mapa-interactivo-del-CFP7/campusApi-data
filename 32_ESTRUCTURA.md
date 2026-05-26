# [S1-S2] Definir estructura de datos de espacios y recorridos #32

## Descripción
Definir Entities JPA completas para representar la estructura física del CFP N°7 (3 pabellones, pasillos longos, aulas enfrentadas) + capa de accesibilidad + personalización por perfil usuario.

---

## 🏗️ CONTEXTO FÍSICO CFP N°7

**Estructura:** 3 pabellones antiguos, planta baja
- Pabellón 1, 2, 3 con pasillos largos (~20-30m)
- Aulas enfrentadas en cada pasillo (lado izquierdo vs lado derecho)
- Distancia entre pabellones: ~10 metros
- Acceso: Requiere salir de un pabellón, cruzar exterior, entrar rampa al siguiente
- 3 baños (1 probable adaptado para María)
- Zona exterior/patios

**Datos de MagicPlan (60-70% pasillos):**
- Pasillo principal: 7.72m ancho × 24.03m largo = 42.45 m²
- Pasillo conexión: 1.64m ancho × 20.96m largo = 34.32 m²
- Patio: 7.05m × 21.21m = 94.16 m²

**Datos faltantes (pendientes escaneo):**
- Ubicación exacta de cada aula en pasillos
- 6 talleres (ubicación)
- Oficinas (ubicación)

---

## 📊 ENTITIES JPA - DISEÑO COMPLETO

### Entity 1: Pabellon (NUEVA - Contenedor)
```java
@Entity
@Table(name = "pabellones")
public class Pabellon {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    
    @Column(nullable = false)
    private Integer numero; // 1, 2, o 3
    
    @Column
    private String nombre; // "Pabellón 1 - Aulas EPS"
    
    @Column
    private String descripcion; // "Sector este del complejo"
    
    // Ubicación en CFP
    @Column
    private Double coordenada_x; // Para mapa general
    
    @Column
    private Double coordenada_y;
    
    // Accesibilidad pabellón
    @Column
    private Boolean tiene_rampa_entrada; // ¿Puede entrar silla de ruedas?
    
    @Column
    private Boolean tiene_baño_adaptado; // ¿Hay baño adaptado EN este pabellón?
    
    @Column
    private String notas_accesibilidad_pabellon; // "Rampa principal funciona, escaleras secundarias sin rampa"
    
    // Pasillos dentro pabellón
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "pabellon")
    private List<Pasillo> pasillos;
    
    @CreationTimestamp
    private LocalDateTime creado;
    
    @UpdateTimestamp
    private LocalDateTime actualizado;
}
```

### Entity 2: Pasillo (NUEVA - Estructura dentro pabellón)
```java
@Entity
@Table(name = "pasillos")
public class Pasillo {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    
    @Column(nullable = false)
    private Integer numero; // 1, 2, 3... dentro del pabellón
    
    @ManyToOne
    @JoinColumn(name = "pabellon_id", nullable = false)
    private Pabellon pabellon;
    
    // Dimensiones (de MagicPlan)
    @Column
    private Double largo_metros; // 24.03
    
    @Column
    private Double ancho_metros; // 7.72
    
    @Column
    private Integer altura_techo_cm; // 421 cm = 4.21m
    
    // Aulas en este pasillo
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "pasillo")
    @OrderBy("lado_pasillo ASC, posicion_en_pasillo ASC")
    private List<Espacio> aulas;
    
    @Column
    private String notas; // "Pasillo principal conecta entrada con zona de talleres"
    
    @CreationTimestamp
    private LocalDateTime creado;
}
```

### Entity 3: Espacio (CORE - Ampliada)
```java
@Entity
@Table(name = "espacios")
public class Espacio {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    
    @Column(nullable = false)
    private String nombre; // "Aula 301", "Taller Gastronomía"
    
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private CategoriaEspacio categoria; // AULA, TALLER, BAÑO, OFICINA, PATIO, PASILLO
    
    // UBICACIÓN EN PASILLO (Crítico para aulas)
    @ManyToOne
    @JoinColumn(name = "pabellon_id", nullable = false)
    private Pabellon pabellon;
    
    @ManyToOne
    @JoinColumn(name = "pasillo_id")
    private Pasillo pasillo;
    
    @Column
    private String numero_aula; // "301", "302", etc. (solo para AULA)
    
    @Column
    @Enumerated(EnumType.STRING)
    private LadoPasillo lado_pasillo; // IZQUIERDO, DERECHO
    
    @Column
    private Integer posicion_en_pasillo; // 1era puerta=1, 2da puerta=2
    
    @Column
    private Double distancia_desde_entrada_pasillo_metros; // 5m, 10m, etc.
    
    // Aula enfrentada (relación con otra aula)
    @Column
    private String aula_enfrentada_id; // ID de aula del lado opuesto
    
    // ACCESIBILIDAD (Crítico para MARÍA)
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "accesibilidad_metadata_id")
    private AccesibilidadMetadata accesibilidad;
    
    // Visualización en pasillo
    @Column
    private String color_numero_aula; // "Azul", "Rojo"
    
    @Column
    private String referencia_visual_puerta; // "Puerta marrón, número blanco"
    
    // Disponibilidad por turno/modalidad (MISMO ESPACIO, diferente HORARIO)
    @ElementCollection
    @CollectionTable(name = "disponibilidad_espacios", joinColumns = @JoinColumn(name = "espacio_id"))
    @MapKeyColumn(name = "turno_modalidad")
    @Column(name = "programa_nombre")
    private Map<String, String> disponibilidad; 
    // "MANANA_EPS" → "1er año Gastronomía"
    // "TARDE_FP" → "Operarios de Gastronomía"
    // "VESPERTINO_SecundarT" → "Matemática para adultos"
    
    // Validación
    @Column
    private Boolean validado_en_terreno;
    
    @Column
    private LocalDateTime fecha_validacion_terreno;
    
    @Column
    private String observaciones_terreno;
    
    @CreationTimestamp
    private LocalDateTime creado;
    
    @UpdateTimestamp
    private LocalDateTime actualizado;
}

public enum CategoriaEspacio {
    AULA, TALLER, BAÑO, OFICINA, PATIO, PASILLO, ESPACIO_COMUN
}

public enum LadoPasillo {
    IZQUIERDO, DERECHO
}
```

### Entity 4: AccesibilidadMetadata (NUEVA - Para MARÍA)
```java
@Entity
@Table(name = "accesibilidad_metadata")
public class AccesibilidadMetadata {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    
    @OneToOne(mappedBy = "accesibilidad")
    private Espacio espacio;
    
    // Validación crítica
    @Column(nullable = false)
    private Boolean validado_accesibilidad; // ¿Validado por IREP o especialista?
    
    @Column
    private LocalDateTime fecha_validacion_accesibilidad;
    
    // Datos críticos para María (IREP)
    @Column(nullable = false)
    private Boolean rampa_entrada; // ¿Hay rampa en entrada pabellón?
    
    @Column(nullable = false)
    private Integer ancho_pasillo_minimo_cm; // 772cm = 7.72m (¿entra silla de ruedas 80cm?)
    
    @Column(nullable = false)
    private Boolean baño_adaptado_cercano;
    
    @Column(nullable = false)
    private Integer distancia_baño_adaptado_metros;
    
    @Column(nullable = false)
    private Boolean tiene_escaleras;
    
    @Column(nullable = false)
    private Boolean escaleras_tienen_rampa_alternativa;
    
    @Column
    private String notas_accesibilidad;
    
    // GARANTÍA (Lo que María necesita)
    @Column(nullable = false)
    private Boolean garantia_acceso_total; // true = "GARANTIZADO", false = "NO ACCESIBLE"
    
    @Column
    private String motivo_no_accesible; // Si false: "Escaleras sin rampa en pabellón 3"
    
    @CreationTimestamp
    private LocalDateTime creado;
}
```

### Entity 5: PasoRecorrido (EXTENDIDA - Para FEDERICO)
```java
@Entity
@Table(name = "pasos_recorrido")
public class PasoRecorrido {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    
    @ManyToOne
    @JoinColumn(name = "recorrido_id", nullable = false)
    private Recorrido recorrido;
    
    @Column(nullable = false)
    private Integer numero;
    
    // PARA FEDERICO: Claridad progresiva
    @Column(nullable = false, columnDefinition = "TEXT")
    private String instruccion_simple;
    // "Camina 30m recto"
    
    @Column(columnDefinition = "TEXT")
    private String instruccion_clara;
    // "Camina 30m recto por pasillo. Verás 4 aulas a la IZQUIERDA (301, 303, 305, 307). Tu aula es 302, puerta DERECHA enfrentada."
    
    @Column(columnDefinition = "TEXT")
    private String referencia_visual;
    // "Puerta marrón, número azul, segundo piso"
    
    // VALIDACIÓN CLARIDAD
    @Column
    private Integer ambiguedad_score; // 0 = perfecto, 100 = muy ambiguo
    // Calcula: "tal vez"(+50), "aproximadamente"(+30), "cerca"(+20), sin IZQUIERDA/DERECHA(+25), sin número(+20)
    
    @Column
    private Boolean tiene_lado_explicito; // Contiene IZQUIERDA o DERECHA?
    
    @Column
    private Boolean tiene_numero_referencia; // Contiene número de aula/pasillo?
    
    @Column
    private Boolean tiene_referencia_visual; // Contiene color, piso, característica?
    
    @Column
    private Integer caracteres_instruccion;
    
    @CreationTimestamp
    private LocalDateTime creado;
}
```

### Entity 6: Recorrido (EXTENDIDA - Personalizable)
```java
@Entity
@Table(name = "recorridos")
public class Recorrido {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    
    @Column(nullable = false)
    private String nombre; // "De Aula 301 a Taller Gastronomía"
    
    @ManyToOne
    @JoinColumn(name = "espacio_origen_id", nullable = false)
    private Espacio espacioOrigen;
    
    @ManyToOne
    @JoinColumn(name = "espacio_destino_id", nullable = false)
    private Espacio espacioDestino;
    
    // Tipos de recorrido
    @Column
    @Enumerated(EnumType.STRING)
    private TipoRecorrido tipo_recorrido; // DENTRO_PASILLO, ENTRE_PABELLONES, OTRO
    
    @Column
    @Enumerated(EnumType.STRING)
    private TipoRuta tipo_ruta; // ESTÁNDAR, ACCESIBLE, RÁPIDA
    
    // Pasos
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "recorrido")
    @OrderBy("numero ASC")
    private List<PasoRecorrido> pasos;
    
    // Metadatos
    @Column
    private Integer distancia_metros;
    
    @Column
    private Integer duracion_estimada_segundos;
    
    @Column
    private Boolean requiere_rampa;
    
    @Column
    private Boolean requiere_salir_pabellon;
    
    @Column
    private Integer ambiguedad_promedio; // Promedio ambiguedad_score de pasos
    
    @Column
    private Boolean validado_accesibilidad;
    
    @CreationTimestamp
    private LocalDateTime creado;
}

public enum TipoRecorrido {
    DENTRO_PASILLO, ENTRE_PABELLONES, OTRO
}

public enum TipoRuta {
    ESTÁNDAR, ACCESIBLE, RÁPIDA
}
```

### Entity 7: PerfilUsuario (NUEVA - Personalización)
```java
@Entity
@Table(name = "perfiles_usuario")
public class PerfilUsuario {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    
    @OneToOne
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;
    
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private TipoPerfil tipo; // PAOLA_ESTUDIANTE, CAMILO_DOCENTE, MARIA_ACCESIBILIDAD, FEDERICO_COGNITIVA
    
    // PAOLA: Prioriza velocidad
    @Column
    private Boolean optimizar_velocidad = false;
    
    @Column
    private Integer timeout_maximo_ms = 2000;
    
    // CAMILO: Prioriza minimalismo
    @Column
    private Boolean modo_minimalista = false;
    
    @Column
    private Integer max_campos_respuesta = 5;
    
    // MARÍA: Prioriza accesibilidad
    @Column
    private Boolean requiere_accesibilidad_garantizada = false;
    
    @Column
    private Boolean requiere_sin_escaleras = false;
    
    @Column
    private Boolean requiere_baño_adaptado = false;
    
    // FEDERICO: Prioriza claridad
    @Column
    private Boolean requiere_sin_ambiguedad = false;
    
    @Column
    private Integer max_caracteres_instruccion = 200;
    
    @Column
    private Boolean mostrar_referencias_visuales = true;
    
    @CreationTimestamp
    private LocalDateTime creado;
}

public enum TipoPerfil {
    PAOLA_ESTUDIANTE("Eficiencia - No perder tiempo"),
    CAMILO_DOCENTE("Minimalismo - Solo lo esencial"),
    MARIA_ACCESIBILIDAD("Certeza - 100% datos a11y"),
    FEDERICO_COGNITIVA("Claridad - Sin ambigüedad");
    
    private final String descripcion;
}
```

### Entity 8: Usuario & Reporte (Existentes, citados para referencia)
```java
@Entity
@Table(name = "usuarios")
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    
    @Column(unique = true, nullable = false)
    private String email;
    
    @Column(nullable = false)
    private String passwordHash;
    
    @Column
    private String nombre;
    
    @Column(nullable = false)
    private String rol; // ESTUDIANTE, DOCENTE, ADMIN
    
    @Column
    private String turno; // MANANA, TARDE, VESPERTINO
    
    @Column
    private String modalidad; // EPS, FP, SecundarT
    
    @Column
    private Boolean necesita_soporte_accesibilidad;
    
    @CreationTimestamp
    private LocalDateTime creado;
}

@Entity
@Table(name = "reportes")
public class Reporte {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    
    @ManyToOne
    @JoinColumn(name = "espacio_id")
    private Espacio espacio;
    
    @ManyToOne
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;
    
    @Column(nullable = false)
    private String categoria; // CAMBIO_AULA, BARRERA_INTER_PABELLON, OTRO
    
    @Column(nullable = false)
    private String descripcion;
    
    @Column
    private String estado; // PENDIENTE, VALIDADO, RESUELTO
    
    @CreationTimestamp
    private LocalDateTime fecha_reporte;
}
```

---

## 🔌 SERVICE LAYER - Integración

```java
@Service
public class AccesibilidadService {
    
    /**
     * Obtener recorrido personalizado según perfil
     * Integra: Recorrido + Accesibilidad + Personalización
     */
    public RecorridoPersonalizadoDTO obtenerRecorridoPersonalizado(
            String usuarioId, String espacioDestinoId) {
        
        // 1. Obtener perfil usuario
        PerfilUsuario perfil = perfilRepository.findByUsuarioId(usuarioId);
        
        // 2. Obtener recorrido base
        Recorrido recorrido = recorridoRepository.findById(espacioDestinoId);
        
        // 3. Si María: Validar accesibilidad COMPLETA
        if (perfil.isRequiereAccesibilidadGarantizada()) {
            validarAccesibilidadCompleta(recorrido);
        }
        
        // 4. Personalizar respuesta
        if (perfil.getTipo() == TipoPerfil.PAOLA_ESTUDIANTE) {
            // Solo instrucciones simples, rápido
            return new RecorridoDTO(
                recorrido.getDistancia_metros(),
                recorrido.getDuracion_estimada_segundos(),
                recorrido.getPasos().stream()
                    .map(PasoRecorrido::getInstruccion_simple)
                    .collect(Collectors.toList())
            );
        } else if (perfil.getTipo() == TipoPerfil.MARIA_ACCESIBILIDAD) {
            // 100% datos accesibilidad
            return new RecorridoAccesibleDTO(
                recorrido.getId(),
                recorrido.getEspacioDestino().getAccesibilidad().isGarantia_acceso_total() ? "GARANTIZADO" : "NO ACCESIBLE",
                recorrido.getEspacioDestino().getAccesibilidad().getMotivo_no_accesible()
            );
        }
        // ... más perfiles
    }
}
```

---

## 📋 CHECKLIST IMPLEMENTACIÓN

### Entities:
- [ ] Pabellon.java
- [ ] Pasillo.java
- [ ] Espacio.java (ampliada)
- [ ] AccesibilidadMetadata.java
- [ ] PasoRecorrido.java (ampliada)
- [ ] Recorrido.java (ampliada)
- [ ] PerfilUsuario.java
- [ ] Usuario.java (existente)
- [ ] Reporte.java (existente)

### Repositories:
- [ ] PabellonRepository.java
- [ ] PasilloRepository.java
- [ ] EspacioRepository.java
- [ ] AccesibilidadMetadataRepository.java
- [ ] RecorridoRepository.java
- [ ] PerfilUsuarioRepository.java

### Services:
- [ ] AccesibilidadService.java
- [ ] PersonalizacionService.java
- [ ] EspacioService.java
- [ ] RecorridoService.java

### DTOs:
- [ ] RecorridoDTO.java
- [ ] RecorridoPersonalizadoDTO.java
- [ ] RecorridoAccesibleDTO.java (para María)
- [ ] EspacioDTO.java

### Tests:
- [ ] Validar ambiguedad_score = 0 para todos pasos
- [ ] Validar 100% espacios tienen accesibilidad_metadata
- [ ] Validar garantia_acceso_total está documentada
- [ ] Validar lado_pasillo + numero_aula + posicion_en_pasillo para aulas

---

## 🎯 DEFINICIÓN DE HECHO

✅ Entities completas permiten:
1. Representar 3 pabellones + pasillos + aulas enfrentadas
2. Documentar accesibilidad 100% (para María)
3. Almacenar instrucciones claras (para Federico)
4. Personalizar respuestas (para Paola/Camilo)
5. Registrar cambios/reportes (crowdsourcing)

---

**Tiempo estimado:** 16 horas (Sprint 1)
**Dueño:** angelgabrieldaq (Data) + Backend Team
**Status:** Backlog → (Sprint 1)
