package pe.edu.pucp.steam.inventario.model;

import java.util.ArrayList;

public class Inventario {
    private int idInventario; //Mismo id que el del usuario
    private int cantGemas;
    private ArrayList<InventarioActivo> inventarios;

    public Inventario(int cantGemas, ArrayList<InventarioActivo> inventarios) {
        this.cantGemas = cantGemas;
        this.inventarios = inventarios;
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
}