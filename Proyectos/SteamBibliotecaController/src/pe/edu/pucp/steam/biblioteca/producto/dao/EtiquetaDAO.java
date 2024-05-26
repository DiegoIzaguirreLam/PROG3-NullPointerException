/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.model.Etiqueta;
import pe.edu.pucp.steam.biblioteca.producto.model.Producto;
import pe.edu.pucp.steam.biblioteca.producto.model.ProductoAdquirido;

/**
 *
 * @author piero
 */
public interface EtiquetaDAO {
    int insertarEtiqueta(Etiqueta etiqueta);
    int actualizarEtiqueta(Etiqueta etiqueta);
    ArrayList<Etiqueta> listarEtiquetas();
    int eliminarEtiqueta(int idEtiqueta);
}
