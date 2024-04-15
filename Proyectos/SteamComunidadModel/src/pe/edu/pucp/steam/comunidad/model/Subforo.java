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
public class Subforo {
    private int idSubforo;
    private Foro foro;
    private String nombre;
    private ArrayList<Hilo> hilos;
    private int oculto;

    public Subforo(Foro foro, String nombre, ArrayList<Hilo> hilos, int oculto) {
        this.foro = foro;
        this.nombre = nombre;
        this.hilos = hilos;
        this.oculto = oculto;
    }

    public int getIdSubforo() {
        return idSubforo;
    }

    public void setIdSubforo(int idSubforo) {
        this.idSubforo = idSubforo;
    }

    public Foro getForo() {
        return foro;
    }

    public void setForo(Foro foro) {
        this.foro = foro;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public ArrayList<Hilo> getHilos() {
        return hilos;
    }

    public void setHilos(ArrayList<Hilo> hilos) {
        this.hilos = hilos;
    }

    public int getOculto() {
        return oculto;
    }

    public void setOculto(int oculto) {
        this.oculto = oculto;
    }
    
}
