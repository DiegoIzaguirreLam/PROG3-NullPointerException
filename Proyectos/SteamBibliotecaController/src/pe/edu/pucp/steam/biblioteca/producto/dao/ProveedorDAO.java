/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.model.Proveedor;

/**
 *
 * @author piero
 */
public interface ProveedorDAO {
    int insertarProveedor(Proveedor proveedor);
    int actualizarProveedor(Proveedor proveedor);
    int eliminarProveedor(int idProveedor);
    ArrayList<Proveedor> listarProveedores();
}