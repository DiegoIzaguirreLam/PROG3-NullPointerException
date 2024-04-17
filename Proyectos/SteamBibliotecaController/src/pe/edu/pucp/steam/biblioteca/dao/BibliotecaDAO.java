package pe.edu.pucp.steam.biblioteca.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.model.Coleccion;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;

public interface BibliotecaDAO {
    int crearBiblioteca(Biblioteca biblioteca);
    Biblioteca buscarBiblioteca(int idUser);
    int actualizarBiblioteca(Biblioteca biblioteca);
    ArrayList<ProductoAdquirido> listarObjetos(Biblioteca biblioteca);
    ArrayList<Coleccion> listarColeccion(Biblioteca biblioteca);
}
