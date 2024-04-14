/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.perfil.model;

import java.util.ArrayList;
import pe.edu.pucp.steam.inventario.model.ObjetoUsable;

/**
 *
 * @author GAMER
 */
public class Perfil {
    private int idPerfil; //El id es el mismo que el del usuario por eso el constructor pide
    private ArrayList<Expositor> expositores;
    private ArrayList<Comentario> comentarios;
    private ArrayList<ObjetoUsable> mostradosPerfil;

    public Perfil(int idPerfil, ArrayList<Expositor> expositores, ArrayList<Comentario> comentarios, ArrayList<ObjetoUsable> mostradosPerfil) {
        this.idPerfil = idPerfil;
        this.expositores = expositores;
        this.comentarios = comentarios;
        this.mostradosPerfil = mostradosPerfil;
    }

    public int getIdPerfil() {
        return idPerfil;
    }

    public void setIdPerfil(int idPerfil) {
        this.idPerfil = idPerfil;
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

    public ArrayList<ObjetoUsable> getMostradosPerfil() {
        return mostradosPerfil;
    }

    public void setMostradosPerfil(ArrayList<ObjetoUsable> mostradosPerfil) {
        this.mostradosPerfil = mostradosPerfil;
    }
    
    
}
