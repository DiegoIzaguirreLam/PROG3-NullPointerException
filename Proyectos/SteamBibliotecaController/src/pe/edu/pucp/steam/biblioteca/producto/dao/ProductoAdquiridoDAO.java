/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.producto.model.ProductoAdquirido;

/**
 *
 * @author piero
 */
public interface ProductoAdquiridoDAO {
    int insertarProducto(ProductoAdquirido producto);
    int actualizarProducto(ProductoAdquirido producto);
    int eliminarProducto(int idProducto);
    ArrayList<ProductoAdquirido> listarProductosAdquiridos(Biblioteca biblioteca);
    ProductoAdquirido buscarProductoAdquirido(int idProductoAdquirido);
}