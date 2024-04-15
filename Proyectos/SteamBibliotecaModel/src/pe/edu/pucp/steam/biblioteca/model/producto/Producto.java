/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.model.producto;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author GAMER
 */
abstract public class Producto {
    private int idProducto;
    private String titulo;
    private Date fechaPublicacion;
    private double precio;
    private String descripcion;
    private double espacioDisco;
    private boolean oculto;

    public Producto(String titulo, Date fechaPublicacion, double precio, String descripcion, double espacioDisco, boolean oculto) {
        this.titulo = titulo;
        this.fechaPublicacion = fechaPublicacion;
        this.precio = precio;
        this.descripcion = descripcion;
        this.espacioDisco = espacioDisco;
        this.oculto = oculto;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public Date getFechaPublicacion() {
        return fechaPublicacion;
    }

    public void setFechaPublicacion(Date fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getEspacioDisco() {
        return espacioDisco;
    }

    public void setEspacioDisco(double espacioDisco) {
        this.espacioDisco = espacioDisco;
    }

    public boolean isOculto() {
        return oculto;
    }

    public void setOculto(boolean oculto) {
        this.oculto = oculto;
    }
    
    
}
