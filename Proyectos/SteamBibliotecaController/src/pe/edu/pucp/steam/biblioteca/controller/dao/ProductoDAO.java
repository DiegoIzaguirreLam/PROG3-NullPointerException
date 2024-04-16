/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.controller.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.Producto;

/**
 *
 * @author piero
 */
public interface ProductoDAO {
    /*int crearProducto(Producto producto);
    int eliminarProducto(Producto producto);
    ArrayList<Producto> listarProducto();*/
    Producto buscarProducto(int idProducto);
    int agregarProductoEtiqueta(int idProducto, int idEtiqueta);
    int eliminarProductoEtiqueta(int idProducto, int idEtiqueta);
}
