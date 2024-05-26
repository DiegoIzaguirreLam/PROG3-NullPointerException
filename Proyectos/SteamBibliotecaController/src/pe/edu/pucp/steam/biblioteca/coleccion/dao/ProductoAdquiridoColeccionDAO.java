/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.coleccion.dao;

import java.util.ArrayList;

/**
 *
 * @author Diego
 */
public interface ProductoAdquiridoColeccionDAO {
    int insertarProductoAdquiridoAColeccion(int idColeccion, int idProductoAdquirido);
    int eliminarProductoAdquiridoDeColeccion(int idColeccion, int idProductoAdquirido);
}
