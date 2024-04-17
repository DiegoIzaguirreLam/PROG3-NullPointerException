/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.model.producto;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.steam.biblioteca.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.model.Coleccion;
import pe.edu.pucp.steam.biblioteca.model.IConsultable;

/**
 *
 * @author GAMER
 */
public class ProductoAdquirido implements IConsultable{
    private int idProductoAdquirido;
    private Date fechaAdquisicion;
    private Date fechaEjecutado;
    private LocalTime tiempoUso;
    private boolean actualizado;
    private boolean oculto; //Si es 0 se muestra al listo, sino se oculta
    private Producto producto;
    private ArrayList<LogroDesbloqueado> desbloqueados;
    private ArrayList<Coleccion> colecciones;
    private Biblioteca biblioteca;

    public ProductoAdquirido(Date fechaAdquisicion, Date fechaEjecutado, LocalTime tiempoUso, boolean actualizado, boolean oculto, Producto producto, ArrayList<LogroDesbloqueado> desbloqueados, ArrayList<Coleccion> colecciones, Biblioteca biblioteca) {
        this.fechaAdquisicion = fechaAdquisicion;
        this.fechaEjecutado = fechaEjecutado;
        this.tiempoUso = tiempoUso;
        this.actualizado = actualizado;
        this.oculto = oculto;
        this.producto = producto;
        this.desbloqueados = desbloqueados;
        this.colecciones = colecciones;
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

    public LocalTime getTiempoUso() {
        return tiempoUso;
    }

    public void setTiempoUso(LocalTime tiempoUso) {
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

    public ArrayList<LogroDesbloqueado> getDesbloqueados() {
        return desbloqueados;
    }

    public void setDesbloqueados(ArrayList<LogroDesbloqueado> desbloqueados) {
        this.desbloqueados = desbloqueados;
    }

    public ArrayList<Coleccion> getColecciones() {
        return colecciones;
    }

    public void setColecciones(ArrayList<Coleccion> colecciones) {
        this.colecciones = colecciones;
    }

    public Biblioteca getBiblioteca() {
        return biblioteca;
    }

    public void setBiblioteca(Biblioteca biblioteca) {
        this.biblioteca = biblioteca;
    }

    @Override
    public void consultarDatos() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
