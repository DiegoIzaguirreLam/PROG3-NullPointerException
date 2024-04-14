/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.inventario.model;

import java.util.ArrayList;

/**
 *
 * @author GAMER
 */
public class Inventario {
    private int idInventario; //Mismo id que el del usuario
    private int cantGemas;
    private ArrayList<InventarioActivo> inventarios;
    private int nInventarios;

    public Inventario(int cantGemas, ArrayList<InventarioActivo> inventarios, int nInventarios) {
        this.cantGemas = cantGemas;
        this.inventarios = inventarios;
        this.nInventarios = nInventarios;
    }

    public int getIdInventario() {
        return idInventario;
    }

    public void setIdInventario(int idInventario) {
        this.idInventario = idInventario;
    }

    public int getCantGemas() {
        return cantGemas;
    }

    public void setCantGemas(int cantGemas) {
        this.cantGemas = cantGemas;
    }

    public ArrayList<InventarioActivo> getInventarios() {
        return inventarios;
    }

    public void setInventarios(ArrayList<InventarioActivo> inventarios) {
        this.inventarios = inventarios;
    }

    public int getnInventarios() {
        return nInventarios;
    }

    public void setnInventarios(int nInventarios) {
        this.nInventarios = nInventarios;
    }
}
