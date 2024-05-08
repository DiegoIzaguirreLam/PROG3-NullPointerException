/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.model.Producto;

/**
 *
 * @author piero
 */
public interface ProductoDAO {
    ArrayList<Producto> listarProductos();
    Producto buscarProducto(int idProducto);
}
