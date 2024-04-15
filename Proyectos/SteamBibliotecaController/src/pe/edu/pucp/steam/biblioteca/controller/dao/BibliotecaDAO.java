/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.controller.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.model.Coleccion;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;

/**
 *
 * @author GAMER
 */
public interface BibliotecaDAO {
    int crearBiblioteca(Biblioteca biblioteca);
    Biblioteca buscarBiblioteca(int idUser);
    int actualizarBiblioteca(Biblioteca biblioteca);
    ArrayList<ProductoAdquirido> listarObjetos(Biblioteca biblioteca);
    ArrayList<Coleccion> listarColeccion(Biblioteca biblioteca);
}
