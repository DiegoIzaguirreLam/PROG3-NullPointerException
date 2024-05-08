/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.coleccion.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Coleccion;
import pe.edu.pucp.steam.biblioteca.producto.model.ProductoAdquirido;

/**
 *
 * @author piero
 */
public interface ColeccionDAO {
    int insertarColeccion(Coleccion coleccion);
    int actualizarColeccion(Coleccion coleccion);
    int eliminarColeccion(int idColeccion);
    ArrayList<Coleccion> listarColecciones(int idBiblioteca);
    ArrayList<ProductoAdquirido> listarProductosAdquiridos(int idColeccion);
}
