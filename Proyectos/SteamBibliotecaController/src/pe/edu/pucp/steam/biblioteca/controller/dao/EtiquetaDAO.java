/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.controller.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.Etiqueta;
import pe.edu.pucp.steam.biblioteca.model.producto.Producto;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;

/**
 *
 * @author piero
 */
public interface EtiquetaDAO {
    int crearEtiqueta(Etiqueta etiqueta);
    ArrayList<Producto> listarProductos(Etiqueta etiqueta);
    ArrayList<ProductoAdquirido> listarAdquiridos(Etiqueta etiqueta);
    int eliminarEtiqueta(Etiqueta etiqueta);
}
