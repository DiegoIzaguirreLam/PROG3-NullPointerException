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
public class Coleccion implements IConsultable{
    private int idColeccion;
    private String nombre;
    private Biblioteca biblioteca;
    private ArrayList<ProductoAdquirido> productos;
    
    public Coleccion(){};

    public Coleccion(int idColeccion, String nombre, Biblioteca biblioteca) {
        this.idColeccion = idColeccion;
        this.nombre = nombre;
        this.biblioteca = biblioteca;
    }

    public int getIdColeccion() {
        return idColeccion;
    }

    public String getNombre() {
        return nombre;
    }

    public Biblioteca getBiblioteca() {
        return biblioteca;
    }

    public ArrayList<ProductoAdquirido> getProductos() {
        return productos;
    }

    public void setIdColeccion(int idColeccion) {
        this.idColeccion = idColeccion;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setBiblioteca(Biblioteca biblioteca) {
        this.biblioteca = biblioteca;
    }

    public void setProductos(ArrayList<ProductoAdquirido> productos) {
        this.productos = productos;
    }
    
    
    
    @Override
    public void consultarDatos() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
