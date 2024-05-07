/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.perfil.model;

import java.util.ArrayList;

/**
 *
 * @author GAMER
 */
public class Perfil {
    private int idPerfil; //El id es el mismo que el del usuario por eso el constructor pide
    private String fotoUrl;
    private boolean activo;
    private ArrayList<Expositor> expositores;
    private ArrayList<Comentario> comentarios;
    
    public Perfil(){};

    public Perfil(int idPerfil) {
        this.idPerfil = idPerfil;
        this.activo = true;
    }

    public int getIdPerfil() {
        return idPerfil;
    }

    public void setIdPerfil(int idPerfil) {
        this.idPerfil = idPerfil;
    }

    public boolean getOculto() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public ArrayList<Expositor> getExpositores() {
        return expositores;
    }

    public void setExpositores(ArrayList<Expositor> expositores) {
        this.expositores = expositores;
    }

    public ArrayList<Comentario> getComentarios() {
        return comentarios;
    }

    public void setComentarios(ArrayList<Comentario> comentarios) {
        this.comentarios = comentarios;
    }

    public String getFotoUrl() {
        return fotoUrl;
    }

    public void setFotoUrl(String fotoUrl) {
        this.fotoUrl = fotoUrl;
    }
    
    
}
