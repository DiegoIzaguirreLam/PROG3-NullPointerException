<<<<<<< HEAD
=======
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
package pe.edu.pucp.steam.biblioteca.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.model.Coleccion;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;

public interface BibliotecaDAO {
    int crearBiblioteca(Biblioteca biblioteca);
    Biblioteca buscarBiblioteca(int idUser);
    ArrayList<ProductoAdquirido> listarObjetos(Biblioteca biblioteca);
    ArrayList<Coleccion> listarColeccion(int idBiblioteca);
}
