/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.model;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author GAMER
 */
public class Mensaje {
    private int idMensaje;
    private int idAutor; //ID del usuario
    private String contenido;
    private String nombreUsuario;
    private String fotoPerfil;
    private Date fechaPublicacion;
    private Hilo hilo;
    private Date fechaMaxEdicion; //Al crearse un mensaje, puede editarse por un tiempo hasta que sea menor a fechaMaxEdicion
    private boolean oculto; //Si está en 1, es porque no se debe mostrar, si está en 0 si se debe listar
    private boolean activo;
    
    public Mensaje(){}
    
    public Mensaje(int idAutor, String contenido, Date fechaPublicacion, Hilo hilo, boolean oculto, Date fechaMaxEdicion) {
        this.idAutor = idAutor;
        this.contenido = contenido;
        this.fechaPublicacion = fechaPublicacion;
        this.hilo = hilo;
        this.oculto = oculto;
        this.fechaMaxEdicion = fechaMaxEdicion;
    }

    public int getIdMensaje() {
        return idMensaje;
    }

    public void setIdMensaje(int idMensaje) {
        this.idMensaje = idMensaje;
    }

    public int getIdAutor() {
        return idAutor;
    }

    public void setIdAutor(int idAutor) {
        this.idAutor = idAutor;
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getFotoPerfil() {
        return fotoPerfil;
    }

    public void setFotoPerfil(String fotoPerfil) {
        this.fotoPerfil = fotoPerfil;
    }

    public Date getFechaPublicacion() {
        return fechaPublicacion;
    }

    public void setFechaPublicacion(Date fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }

    public Hilo getHilo() {
        return hilo;
    }

    public void setHilo(Hilo hilo) {
        this.hilo = hilo;
    }

    public boolean getOculto() {
        return oculto;
    }

    public void setOculto(boolean oculto) {
        this.oculto = oculto;
    }

    public Date getFechaMaxEdicion() {
        return fechaMaxEdicion;
    }

    public void setFechaMaxEdicion(Date fechaMaxEdicion) {
        this.fechaMaxEdicion = fechaMaxEdicion;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    
}
