/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.controller.dao;

import pe.edu.pucp.steam.biblioteca.model.Coleccion;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;

/**
 *
 * @author piero
 */
public interface ColeccionDAO {
    int crearColeccion(Coleccion coleccion);
    int actualizarColeccion(Coleccion coleccion);
}
