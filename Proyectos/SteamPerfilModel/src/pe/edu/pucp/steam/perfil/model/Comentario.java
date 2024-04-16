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
    private Perfil comentarista;
    private String texto;
    private int nlikes;
    private boolean oculto; //Si es 1, no se muestra, si es 0  si se muestra
    private Date fechaMaxEdicion; //Al crearse un mensaje, puede editarse por un tiempo hasta que sea menor a fechaMaxEdicion
    private Date fechaPublicacion;

    public Comentario(Perfil comentarista, String texto, int nlikes) {
        this.comentarista = comentarista;
        this.texto = texto;
        this.nlikes = nlikes;
        this.oculto = false;
    }

    public int getIdComentario() {
        return idComentario;
    }

    public void setIdComentario(int idComentario) {
        this.idComentario = idComentario;
    }

    public Perfil getComentarista() {
        return comentarista;
    }

    public void setComentarista(Perfil comentarista) {
        this.comentarista = comentarista;
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
}
