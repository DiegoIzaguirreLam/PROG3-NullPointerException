/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.model;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author GAMER
 */
public class GestorSanciones {

  
    private int idGestor; //Su constructor llamará al id del Usuario
    private int idUsuario;
    private int contadorPalabras;
    private int contadorBaneos;
    private int contadorFaltas;
    private int maxFaltas;
    private int maxBaneos;
    private Date fechaFinBan;
    private int cantFaltas;
    private int cantBaneos;
    private ArrayList<Subforo> subforos;
    private boolean activo;

    public GestorSanciones(){
        
    }
    
    public GestorSanciones(int idGestor, int contadorPalabras, int contadorBaneos, int maxFaltas, int maxBaneos, Date finBan, int cantFaltas, int cantBaneos, ArrayList<Subforo> subforos) {
        this.idGestor = idGestor;
        this.contadorPalabras = contadorPalabras;
        this.contadorBaneos = contadorBaneos;
        this.maxFaltas = maxFaltas;
        this.maxBaneos = maxBaneos;
        this.fechaFinBan = finBan;
        this.cantFaltas = cantFaltas;
        this.cantBaneos = cantBaneos;
        this.subforos = subforos;
    }

    public int getIdGestor() {
        return idGestor;
    }

    public void setIdGestor(int idGestor) {
        this.idGestor = idGestor;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getContadorPalabras() {
        return contadorPalabras;
    }

    public void setContadorPalabras(int contadorPalabras) {
        this.contadorPalabras = contadorPalabras;
    }

    public int getContadorBaneos() {
        return contadorBaneos;
    }

    public void setContadorBaneos(int contadorBaneos) {
        this.contadorBaneos = contadorBaneos;
    }

    public int getMaxFaltas() {
        return maxFaltas;
    }

    public void setMaxFaltas(int maxFaltas) {
        this.maxFaltas = maxFaltas;
    }

    public int getMaxBaneos() {
        return maxBaneos;
    }

    public void setMaxBaneos(int maxBaneos) {
        this.maxBaneos = maxBaneos;
    }

    public Date getFechaFinBan() {
        return fechaFinBan;
    }

    public void setFechaFinBan(Date fechaFinBan) {
        this.fechaFinBan = fechaFinBan;
    }

    public int getCantFaltas() {
        return cantFaltas;
    }

    public void setCantFaltas(int cantFaltas) {
        this.cantFaltas = cantFaltas;
    }

    public int getCantBaneos() {
        return cantBaneos;
    }

    public void setCantBaneos(int cantBaneos) {
        this.cantBaneos = cantBaneos;
    }

    public ArrayList<Subforo> getSubforos() {
        return subforos;
    }

    public void setSubforos(ArrayList<Subforo> subforos) {
        this.subforos = subforos;
    }
  
    public int getContadorFaltas() {
        return contadorFaltas;
    }

  
    public void setContadorFaltas(int contadorFaltas) {
        this.contadorFaltas = contadorFaltas;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    
}
