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
    private String nombre;
    private String mensaje;
    private boolean oculto;
    private boolean activo;
    private Foro foro;
    private ArrayList<Hilo> hilos;
    
    public Subforo(){
        
        
    }
    public Subforo(Foro foro, String nombre, ArrayList<Hilo> hilos, boolean oculto) {
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

    public boolean isOculto() {
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

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }
}
