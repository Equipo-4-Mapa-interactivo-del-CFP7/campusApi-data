package com.campusmap.model;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Pabellón - Contenedor físico en CFP N°7
 * 
 * CFP N°7 tiene 3 pabellones antiguos.
 * Cada pabellón contiene múltiples pasillos con aulas.
 */
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
    
    @Column(columnDefinition = "TEXT")
    private String descripcion;
    
    // Ubicación para mapa general
    @Column
    private Double coordenada_x;
    
    @Column
    private Double coordenada_y;
    
    // ACCESIBILIDAD EN NIVEL PABELLÓN
    @Column
    private Boolean tiene_rampa_entrada; // ¿Puede entrar silla de ruedas?
    
    @Column
    private Boolean tiene_baño_adaptado; // ¿Hay baño adaptado en este pabellón?
    
    @Column(columnDefinition = "TEXT")
    private String notas_accesibilidad_pabellon;
    // Ej: "Rampa principal funciona, escaleras secundarias sin rampa"
    
    // RELACIÓN: Un pabellón tiene múltiples pasillos
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "pabellon", fetch = FetchType.LAZY)
    private List<Pasillo> pasillos;
    
    @CreationTimestamp
    private LocalDateTime creado;
    
    @UpdateTimestamp
    private LocalDateTime actualizado;
    
    // ===== GETTERS / SETTERS =====
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    
    public Integer getNumero() { return numero; }
    public void setNumero(Integer numero) { this.numero = numero; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    
    public Double getCoordenada_x() { return coordenada_x; }
    public void setCoordenada_x(Double coordenada_x) { this.coordenada_x = coordenada_x; }
    
    public Double getCoordenada_y() { return coordenada_y; }
    public void setCoordenada_y(Double coordenada_y) { this.coordenada_y = coordenada_y; }
    
    public Boolean getTiene_rampa_entrada() { return tiene_rampa_entrada; }
    public void setTiene_rampa_entrada(Boolean tiene_rampa_entrada) { this.tiene_rampa_entrada = tiene_rampa_entrada; }
    
    public Boolean getTiene_baño_adaptado() { return tiene_baño_adaptado; }
    public void setTiene_baño_adaptado(Boolean tiene_baño_adaptado) { this.tiene_baño_adaptado = tiene_baño_adaptado; }
    
    public String getNotas_accesibilidad_pabellon() { return notas_accesibilidad_pabellon; }
    public void setNotas_accesibilidad_pabellon(String notas_accesibilidad_pabellon) { this.notas_accesibilidad_pabellon = notas_accesibilidad_pabellon; }
    
    public List<Pasillo> getPasillos() { return pasillos; }
    public void setPasillos(List<Pasillo> pasillos) { this.pasillos = pasillos; }
    
    public LocalDateTime getCreado() { return creado; }
    public void setCreado(LocalDateTime creado) { this.creado = creado; }
    
    public LocalDateTime getActualizado() { return actualizado; }
    public void setActualizado(LocalDateTime actualizado) { this.actualizado = actualizado; }
}
