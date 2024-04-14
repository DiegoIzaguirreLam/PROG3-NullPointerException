/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.inventario.model;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.Juego;

/**
 *
 * @author GAMER
 */
public class InventarioActivo {
    private int idActivo;
    private int nObjetos;
    private ArrayList<ObjetoObtenido> objetos;
    private Inventario inventario;
    private Juego tematica;

    public InventarioActivo(int idActivo, int nObjetos, ArrayList<ObjetoObtenido> objetos, Inventario inventario, Juego tematica) {
        this.idActivo = idActivo;
        this.nObjetos = nObjetos;
        this.objetos = objetos;
        this.inventario = inventario;
        this.tematica = tematica;
    }

    public int getIdActivo() {
        return idActivo;
    }

    public void setIdActivo(int idActivo) {
        this.idActivo = idActivo;
    }

    public int getnObjetos() {
        return nObjetos;
    }

    public void setnObjetos(int nObjetos) {
        this.nObjetos = nObjetos;
    }

    public ArrayList<ObjetoObtenido> getObjetos() {
        return objetos;
    }

    public void setObjetos(ArrayList<ObjetoObtenido> objetos) {
        this.objetos = objetos;
    }

    public Inventario getInventario() {
        return inventario;
    }

    public void setInventario(Inventario inventario) {
        this.inventario = inventario;
    }

    public Juego getTematica() {
        return tematica;
    }

    public void setTematica(Juego tematica) {
        this.tematica = tematica;
    }
}
