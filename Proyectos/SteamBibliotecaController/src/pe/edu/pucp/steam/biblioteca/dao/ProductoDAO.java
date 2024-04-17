/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.Producto;

/**
 *
 * @author piero
 */
public interface ProductoDAO {
    int crearProducto(Producto producto);
    int eliminarProducto(Producto producto);
    ArrayList<Producto> listarProducto();
}
