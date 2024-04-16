/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.perfil.model;

import java.util.Date;

/**
 *
 * @author GAMER
 */
public class Comentario {
    private int idComentario; //Se genera proceduralmente
    private Perfil perfilComentado;
    private String texto;
    private int nlikes;
    private boolean oculto; //Si es 1, no se muestra, si es 0  si se muestra
    private Date fechaMaxEdicion; //Al crearse un mensaje, puede editarse por un tiempo hasta que sea menor a fechaMaxEdicion
    private Date fechaPublicacion;
    private int idComentarista;

    public Comentario(Perfil perfilComentado, String texto, int nlikes, boolean oculto, Date fechaMaxEdicion, Date fechaPublicacion, int idComentarista) {
        this.perfilComentado = perfilComentado;
        this.texto = texto;
        this.nlikes = nlikes;
        this.oculto = oculto;
        this.fechaMaxEdicion = fechaMaxEdicion;
        this.fechaPublicacion = fechaPublicacion;
        this.idComentarista = idComentarista;
    }

    public int getIdComentario() {
        return idComentario;
    }

    public void setIdComentario(int idComentario) {
        this.idComentario = idComentario;
    }

    public Perfil getPerfilComentado() {
        return perfilComentado;
    }

    public void setPerfilComentado(Perfil perfilComentado) {
        this.perfilComentado = perfilComentado;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public int getNlikes() {
        return nlikes;
    }

    public void setNlikes(int nlikes) {
        this.nlikes = nlikes;
    }

    public boolean isOculto() {
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

    public Date getFechaPublicacion() {
        return fechaPublicacion;
    }

    public void setFechaPublicacion(Date fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }

    public int getIdComentarista() {
        return idComentarista;
    }

    public void setIdComentarista(int idComentarista) {
        this.idComentarista = idComentarista;
    }

    
}
