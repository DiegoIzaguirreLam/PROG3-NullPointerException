/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.controller.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.Coleccion;

/**
 *
 * @author piero
 */
public interface ColeccionDAO {
    int insertarColeccion(Coleccion coleccion);
    int actualizarColeccion(Coleccion coleccion);
    int eliminarColeccion(int idColeccion);
    ArrayList<Coleccion> listarColecciones(int idBiblioteca);
}
