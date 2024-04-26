/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.model;

import java.util.ArrayList;

/**
 *
 * @author GAMER
 */
public class Logro {
    private int idLogro;
    private String nombre;
    private String descripcion;
    private Juego juego;
    private boolean activo;
    
    public Logro(){};

    public Logro(String nombre, String descripcion, Juego juego, boolean activo) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.juego = juego;
        this.activo = activo;
    }

    public int getIdLogro() {
        return idLogro;
    }

    public void setIdLogro(int idLogro) {
        this.idLogro = idLogro;
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

    public Juego getJuego() {
        return juego;
    }

    public void setJuego(Juego juego) {
        this.juego = juego;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}
