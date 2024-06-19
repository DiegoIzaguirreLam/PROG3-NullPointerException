/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.usuario.jugador.model;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;

/**
 *
 * @author GAMER
 */
public class Cartera {
    private int idCartera;
    private double fondos;
    private int cantMovimientos;
    private ArrayList<Movimiento> movimientos;
    private Usuario owner;

    public Cartera() {
    }

    public Cartera(int idCartera, double fondos, int cantMovimientos, ArrayList<Movimiento> movimientos, Usuario owner) {
        this.idCartera = idCartera;
        this.fondos = fondos;
        this.cantMovimientos = cantMovimientos;
        this.movimientos = movimientos;
        this.owner = owner;
    }

    public int getIdCartera() {
        return idCartera;
    }

    public void setIdCartera(int idCartera) {
        this.idCartera = idCartera;
    }

    public double getFondos() {
        return fondos;
    }

    public void setFondos(double fondos) {
        this.fondos = fondos;
    }

    public int getCantMovimientos() {
        return cantMovimientos;
    }

    public void setCantMovimientos(int cantMovimientos) {
        this.cantMovimientos = cantMovimientos;
    }

    public ArrayList<Movimiento> getMovimientos() {
        return movimientos;
    }

    public void setMovimientos(ArrayList<Movimiento> movimientos) {
        this.movimientos = movimientos;
    }

    public Usuario getOwner() {
        return owner;
    }

    public void setOwner(Usuario owner) {
        this.owner = owner;
    }
}
