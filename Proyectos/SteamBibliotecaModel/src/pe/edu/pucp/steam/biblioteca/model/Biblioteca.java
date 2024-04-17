/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.model;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;

/**
 *
 * @author GAMER
 */
public class Biblioteca {
    private int idBiblioteca;
    private ArrayList<Coleccion> colecciones;
    private ArrayList<ProductoAdquirido> productos;
    
    public Biblioteca(){};

    public Biblioteca(int idBiblioteca) {
        this.idBiblioteca = idBiblioteca;
    }

    public int getIdBiblioteca() {
        return idBiblioteca;
    }

    public ArrayList<Coleccion> getColecciones() {
        return colecciones;
    }

    public ArrayList<ProductoAdquirido> getProductos() {
        return productos;
    }

    public void setIdBiblioteca(int idBiblioteca) {
        this.idBiblioteca = idBiblioteca;
    }

    public void setColecciones(ArrayList<Coleccion> colecciones) {
        this.colecciones = colecciones;
    }

    public void setProductos(ArrayList<ProductoAdquirido> productos) {
        this.productos = productos;
    }
    
    
}
