package com.campusmap.model;

/**
 * Representa un sector o área dentro del CFP N.º 7.
 * NOTA DE NEGOCIO: Se utiliza el término "Sector" por requerimiento explícito
 * de la dirección, reemplazando el término "Pabellón".
 */
public class Sector {
    private String id;
    private String nombre;
    private String descripcion;
    private boolean accesible;

    // Constructores, Getters y Setters
    public Sector() {}

    public Sector(String id, String nombre, String descripcion, boolean accesible) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.accesible = accesible;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public boolean isAccesible() { return accesible; }
    public void setAccesible(boolean accesible) { this.accesible = accesible; }
}
