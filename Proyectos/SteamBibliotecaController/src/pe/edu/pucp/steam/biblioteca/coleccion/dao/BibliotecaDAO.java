/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.coleccion.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Coleccion;
import pe.edu.pucp.steam.biblioteca.producto.model.ProductoAdquirido;

/**
 *
 * @author GAMER
 */
public interface BibliotecaDAO {
    int insertarBiblioteca(Biblioteca biblioteca);
    Biblioteca buscarBiblioteca(int idUser);
    ArrayList<ProductoAdquirido> listarObjetos(Biblioteca biblioteca);
    ArrayList<Coleccion> listarColeccion(int idBiblioteca);
}