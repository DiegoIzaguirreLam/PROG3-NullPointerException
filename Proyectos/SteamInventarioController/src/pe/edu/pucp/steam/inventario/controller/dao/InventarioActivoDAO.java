/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.inventario.controller.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.inventario.model.InventarioActivo;
import pe.edu.pucp.steam.inventario.model.ObjetoObtenido;

/**
 *
 * @author piero
 */
public interface InventarioActivoDAO {
    int crearInventarioActivo(InventarioActivo inventario);
    int actualizarInventarioActivo(InventarioActivo inventario);
    ArrayList<ObjetoObtenido> listarObjetos(InventarioActivo inventario);
    InventarioActivo buscarInventario(int idInventario);
    int eliminarInventario(InventarioActivo inventario);
}
