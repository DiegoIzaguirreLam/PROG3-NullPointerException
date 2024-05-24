/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.model.ProductoAdquirido;

/**
 *
 * @author piero
 */
public interface ProductoAdquiridoDAO {
    int insertarProducto(ProductoAdquirido producto);
    int actualizarProducto(ProductoAdquirido producto);
    int eliminarProductoAdquirido(int idProducto);
    ArrayList<ProductoAdquirido> listarProductosAdquiridosPorIdBiblioteca(int idBiblioteca);
    ProductoAdquirido buscarProductoAdquirido(int idProductoAdquirido);
}