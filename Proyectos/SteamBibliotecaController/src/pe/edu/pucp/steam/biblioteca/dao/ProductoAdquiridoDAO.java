/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.dao;

<<<<<<< HEAD
=======
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.Biblioteca;
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;

/**
 *
 * @author piero
 */
public interface ProductoAdquiridoDAO {
<<<<<<< HEAD
    int agregarProducto(ProductoAdquirido producto);
    int ocultarProducto(ProductoAdquirido producto);
=======
    int insertarProducto(ProductoAdquirido producto);
    int actualizarProducto(ProductoAdquirido producto);
    int eliminarProducto(int idProducto);
    ArrayList<ProductoAdquirido> listarProductosAdquiridos(Biblioteca biblioteca);
    ProductoAdquirido buscarProductoAdquirido(int idProductoAdquirido);
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
}
