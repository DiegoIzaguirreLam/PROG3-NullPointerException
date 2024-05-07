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
public class Hilo {
    private int idHilo;
    private boolean fijado;
    private int idCreador; //Id del usuario que creó el hilo
    private int nroMensajes;
    private Date fechaCreacion;
    private Date fechaModificacion;
    private Subforo subforo;
    private ArrayList<Mensaje> mensajes;
    private String imagenUrl;
    private boolean oculto;
    private boolean activo;

    
    public Hilo(){
        
    }
    public Hilo(boolean fijado, int idCreador, int nroMensajes, Date fechaCreacion, Date fechaModificacion, Subforo subforo, ArrayList<Mensaje> mensajes, String imagenUrl, boolean oculto) {
        this.fijado = fijado;
        this.idCreador = idCreador;
        this.nroMensajes = nroMensajes;
        this.fechaCreacion = fechaCreacion;
        this.fechaModificacion = fechaModificacion;
        this.subforo = subforo;
        this.mensajes = mensajes;
        this.oculto = oculto;
        this.imagenUrl = imagenUrl;
    }

    public int getIdHilo() {
        return idHilo;
    }

    public void setIdHilo(int idHilo) {
        this.idHilo = idHilo;
    }

    public boolean isFijado() {
        return fijado;
    }

    public void setFijado(boolean fijado) {
        this.fijado = fijado;
    }

    public int getIdCreador() {
        return idCreador;
    }

    public void setIdCreador(int idCreador) {
        this.idCreador = idCreador;
    }

    public int getNroMensajes() {
        return nroMensajes;
    }

    public void setNroMensajes(int nroMensajes) {
        this.nroMensajes = nroMensajes;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public Date getFechaModificacion() {
        return fechaModificacion;
    }

    public void setFechaModificacion(Date fechaModificacion) {
        this.fechaModificacion = fechaModificacion;
    }

    public Subforo getSubforo() {
        return subforo;
    }

    public void setSubforo(Subforo subforo) {
        this.subforo = subforo;
    }

    public ArrayList<Mensaje> getMensajes() {
        return mensajes;
    }

    public void setMensajes(ArrayList<Mensaje> mensajes) {
        this.mensajes = mensajes;
    }

    public String getImagenUrl() {
        return imagenUrl;
    }

    public void setImagenUrl(String imagenUrl) {
        this.imagenUrl = imagenUrl;
    }
    
    public boolean getOculto() {
        return oculto;
    }

    public void setOculto(boolean oculto) {
        this.oculto = oculto;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    
}
