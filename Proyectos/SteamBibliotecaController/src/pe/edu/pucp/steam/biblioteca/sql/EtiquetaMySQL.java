/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.sql;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.dao.EtiquetaDAO;
import pe.edu.pucp.steam.biblioteca.model.producto.Etiqueta;
import pe.edu.pucp.steam.biblioteca.model.producto.Producto;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;

/**
 *
 * @author piero
 */
public class EtiquetaMySQL implements EtiquetaDAO{

    @Override
    public int crearEtiqueta(Etiqueta etiqueta) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Producto> listarProductos(Etiqueta etiqueta) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<ProductoAdquirido> listarAdquiridos(Etiqueta etiqueta) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int eliminarEtiqueta(Etiqueta etiqueta) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
