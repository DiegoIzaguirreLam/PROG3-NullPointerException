/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.dao;

/**
 *
 * @author Diego
 */
public interface ProductoEtiquetaDAO {
    int agregarProductoEtiqueta(int idProducto, int idEtiqueta);
    int eliminarProductoEtiqueta(int idProducto, int idEtiqueta);
}
