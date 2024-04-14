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
abstract public class Objeto {
    private String nombre;
    private Juego tematica;
    private int idObjeto; //No genera id porque es procedural en la bd
    private ArrayList<ObjetoObtenido> obtenidos;

    public Objeto(String nombre, Juego tematica, ArrayList<ObjetoObtenido> obtenidos) {
        this.nombre = nombre;
        this.tematica = tematica;
        this.obtenidos = obtenidos;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Juego getTematica() {
        return tematica;
    }

    public void setTematica(Juego tematica) {
        this.tematica = tematica;
    }

    public int getIdObjeto() {
        return idObjeto;
    }

    public void setIdObjeto(int idObjeto) {
        this.idObjeto = idObjeto;
    }

    public ArrayList<ObjetoObtenido> getObtenidos() {
        return obtenidos;
    }

    public void setObtenidos(ArrayList<ObjetoObtenido> obtenidos) {
        this.obtenidos = obtenidos;
    }
    
    
}
