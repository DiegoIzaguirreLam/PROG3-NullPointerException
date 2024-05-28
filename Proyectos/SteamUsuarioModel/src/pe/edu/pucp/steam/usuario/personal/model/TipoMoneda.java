/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package pe.edu.pucp.steam.usuario.personal.model;

import java.util.Date;

/**
 *
 * @author GAMER
 */
public class TipoMoneda {
    private int idTipoMoneda;
    private String nombre;
    private String codigo;
    private String simbolo;
    private double cambioDeDolares; // de dolar a esta nueva moneda
    private Date fechaCambio;
    private boolean activo;

    public TipoMoneda(){}
    
    public TipoMoneda(String nombre, String codigo, double cambioDeDolares, Date fechaCambio) {
        this.nombre = nombre;
        this.codigo = codigo;
        this.cambioDeDolares = cambioDeDolares;
        this.fechaCambio = fechaCambio;
    }
    
    public Date getFechaCambio() {
        return fechaCambio;
    }

    public void setFechaCambio(Date fechaCambio) {
        this.fechaCambio = fechaCambio;
    }

    public int getIdTipoMoneda() {
        return idTipoMoneda;
    }

    public void setIdTipoMoneda(int idTipoMoneda) {
        this.idTipoMoneda = idTipoMoneda;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getCambioDeDolares() {
        return cambioDeDolares;
    }

    public void setCambioDeDolares(double cambioDeDolares) {
        this.cambioDeDolares = cambioDeDolares;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public String getSimbolo() {
        return simbolo;
    }

    public void setSimbolo(String simbolo) {
        this.simbolo = simbolo;
    }
    
    
    
    
}
