/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.perfil.model;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;

/**
 *
 * @author GAMER
 */
public class Expositor {
    private int idExpositor; //Es creacion procedural
    private Perfil owner;
    private ArrayList<ProductoAdquirido> mostrados;
    private boolean activo;
    private boolean oculto;

    public Expositor(Perfil owner, ArrayList<ProductoAdquirido> mostrados) {
        this.owner = owner;
        this.mostrados = mostrados;
    }

    public int getIdExpositor() {
        return idExpositor;
    }

    public void setIdExpositor(int idExpositor) {
        this.idExpositor = idExpositor;
    }

    public Perfil getOwner() {
        return owner;
    }

    public void setOwner(Perfil owner) {
        this.owner = owner;
    }

    public ArrayList<ProductoAdquirido> getMostrados() {
        return mostrados;
    }

    public void setMostrados(ArrayList<ProductoAdquirido> mostrados) {
        this.mostrados = mostrados;
    }

    public boolean getActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public boolean getOculto() {
        return oculto;
    }

    public void setOculto(boolean oculto) {
        this.oculto = oculto;
    }
}
