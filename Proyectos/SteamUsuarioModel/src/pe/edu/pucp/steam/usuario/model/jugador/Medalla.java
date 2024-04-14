/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.usuario.model.jugador;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.model.Usuario;

/**
 *
 * @author GAMER
 */
public class Medalla {
    private int idMedalla; //Las medallas están generadas directamente al SQL por eso su constructor pide id
    private String nombre;
    private int experiencia;
    private ArrayList<Usuario> jugadores;

    public Medalla(int idMedalla, String nombre, int experiencia, ArrayList<Usuario> jugadores) {
        this.idMedalla = idMedalla;
        this.nombre = nombre;
        this.experiencia = experiencia;
        this.jugadores = jugadores;
    }

    public int getIdMedalla() {
        return idMedalla;
    }

    public void setIdMedalla(int idMedalla) {
        this.idMedalla = idMedalla;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getExperiencia() {
        return experiencia;
    }

    public void setExperiencia(int experiencia) {
        this.experiencia = experiencia;
    }

    public ArrayList<Usuario> getJugadores() {
        return jugadores;
    }

    public void setJugadores(ArrayList<Usuario> jugadores) {
        this.jugadores = jugadores;
    }
}
