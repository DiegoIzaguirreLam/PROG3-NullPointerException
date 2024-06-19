/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.model;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Coleccion;

/**
 *
 * @author GAMER
 */
public class ProductoAdquirido{
    private int idProductoAdquirido;
    private Date fechaAdquisicion;
    private Date fechaEjecutado;
    private Date tiempoUso;
    private boolean actualizado;
    private Producto producto;
    private Biblioteca biblioteca;
    private boolean oculto; //Si es 0 se muestra al listo, sino se oculta
    private boolean activo;

    public ProductoAdquirido(){};

    public ProductoAdquirido(Date fechaAdquisicion, Date fechaEjecutado, Date tiempoUso, boolean actualizado, boolean oculto, Producto producto, Biblioteca biblioteca) {
        this.fechaAdquisicion = fechaAdquisicion;
        this.fechaEjecutado = fechaEjecutado;
        this.tiempoUso = tiempoUso;
        this.actualizado = actualizado;
        this.oculto = oculto;
        this.producto = producto;
        this.biblioteca = biblioteca;
    }

    public int getIdProductoAdquirido() {
        return idProductoAdquirido;
    }

    public void setIdProductoAdquirido(int idProductoAdquirido) {
        this.idProductoAdquirido = idProductoAdquirido;
    }

    public Date getFechaAdquisicion() {
        return fechaAdquisicion;
    }

    public void setFechaAdquisicion(Date fechaAdquisicion) {
        this.fechaAdquisicion = fechaAdquisicion;
    }

    public Date getFechaEjecutado() {
        return fechaEjecutado;
    }

    public void setFechaEjecutado(Date fechaEjecutado) {
        this.fechaEjecutado = fechaEjecutado;
    }

    public Date getTiempoUso() {
        return tiempoUso;
    }

    public void setTiempoUso(Date tiempoUso) {
        this.tiempoUso = tiempoUso;
    }

    public boolean isActualizado() {
        return actualizado;
    }

    public void setActualizado(boolean actualizado) {
        this.actualizado = actualizado;
    }

    public boolean isOculto() {
        return oculto;
    }

    public void setOculto(boolean oculto) {
        this.oculto = oculto;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public Biblioteca getBiblioteca() {
        return biblioteca;
    }

    public void setBiblioteca(Biblioteca biblioteca) {
        this.biblioteca = biblioteca;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}
