/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.model;

import java.util.ArrayList;

/**
 *
 * @author GAMER
 */
public class Foro {
    private int idForo;
    private String nombre;
    private String descripcion;
    private OrigenForo origen;
    private ArrayList<Subforo> subforos;
    private int oculto;

    public Foro(){
        
    }
    public Foro(String nombre, String descripcion, OrigenForo origen, ArrayList<Subforo> subforos, int oculto) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.origen = origen;
        this.subforos = subforos;
        this.oculto = oculto;
    }

    public int getIdForo() {
        return idForo;
    }

    public void setIdForo(int idForo) {
        this.idForo = idForo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public OrigenForo getOrigen() {
        return origen;
    }

    public void setOrigen(OrigenForo origen) {
        this.origen = origen;
    }

    public ArrayList<Subforo> getSubforos() {
        return subforos;
    }

    public void setSubforos(ArrayList<Subforo> subforos) {
        this.subforos = subforos;
    }

    public int getOculto() {
        return oculto;
    }

    public void setOculto(int oculto) {
        this.oculto = oculto;
    }
}
