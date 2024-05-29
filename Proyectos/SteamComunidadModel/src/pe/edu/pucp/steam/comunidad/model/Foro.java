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
    private int idCreador;
    private String nombreCreador;
    private ArrayList<Integer> suscritos;
    private ArrayList<Subforo> subforos;
    private boolean oculto;
    private boolean activo;

    public Foro(){
        
    }
    
    public Foro(String nombre, String descripcion, OrigenForo origen, int idCreador, boolean oculto) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.origen = origen;
        this.idCreador = idCreador;
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

    public int getIdCreador() {
        return idCreador;
    }

    public void setIdCreador(int idCreador) {
        this.idCreador = idCreador;
    }

    public ArrayList<Integer> getSuscritos() {
        return suscritos;
    }

    public void setSuscritos(ArrayList<Integer> suscritos) {
        this.suscritos = suscritos;
    }

    public String getNombreCreador() {
        return nombreCreador;
    }

    public void setNombreCreador(String nombreCreador) {
        this.nombreCreador = nombreCreador;
    }
    
    public void setSubforos(ArrayList<Subforo> subforos) {
        this.subforos = subforos;
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

    
}
