/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.inventario.dao;

import pe.edu.pucp.steam.inventario.model.Inventario;

/**
 *
 * @author GAMER
 */
public interface InventarioDAO {
    int crearInventario(Inventario inventario);
    int actualizarInventario(Inventario inventario);
    Inventario buscarInventario(int idUsuario);
}
