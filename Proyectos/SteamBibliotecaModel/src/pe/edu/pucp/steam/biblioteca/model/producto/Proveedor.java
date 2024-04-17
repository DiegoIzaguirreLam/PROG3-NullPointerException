/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.model.producto;

import java.util.ArrayList;

/**
 *
 * @author GAMER
 */
public class Proveedor{
    private int idProveedor;
    private String razonSocial;
    private ArrayList<Producto> productos;
    
    public Proveedor(){};

    public Proveedor(int idProveedor, String razonSocial, ArrayList<Producto> productos) {
        this.idProveedor = idProveedor;
        this.razonSocial = razonSocial;
        this.productos = productos;
    }

    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    public String getRazonSocial() {
        return razonSocial;
    }

    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
    }

    public ArrayList<Producto> getProductos() {
        return productos;
    }

    public void setProductos(ArrayList<Producto> productos) {
        this.productos = productos;
    }
    
    
}
