<<<<<<< HEAD
=======
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
package pe.edu.pucp.steam.inventario.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.inventario.model.InventarioActivo;
import pe.edu.pucp.steam.inventario.model.ObjetoObtenido;

<<<<<<< HEAD
public interface InventarioActivoDAO {
    int crearInventarioActivo(InventarioActivo inventario);
    ArrayList<ObjetoObtenido> listarObjetos(int idInventarioActivo);
    InventarioActivo buscarInventario(int idInventario);
}
=======
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
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
