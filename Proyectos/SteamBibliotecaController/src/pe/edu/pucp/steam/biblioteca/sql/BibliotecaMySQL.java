/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.sql;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.dao.BibliotecaDAO;
import pe.edu.pucp.steam.biblioteca.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.model.Coleccion;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;

/**
 *
 * @author GAMER
 */
public class BibliotecaMySQL implements BibliotecaDAO{

    @Override
    public int crearBiblioteca(Biblioteca biblioteca) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Biblioteca buscarBiblioteca(int idUser) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int actualizarBiblioteca(Biblioteca biblioteca) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<ProductoAdquirido> listarObjetos(Biblioteca biblioteca) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Coleccion> listarColeccion(Biblioteca biblioteca) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
