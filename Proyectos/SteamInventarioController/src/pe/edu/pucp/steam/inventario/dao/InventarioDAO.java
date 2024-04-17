package pe.edu.pucp.steam.inventario.dao;

import pe.edu.pucp.steam.inventario.model.Inventario;

public interface InventarioDAO {
    int crearInventario(Inventario inventario);
    int actualizarInventario(Inventario inventario);
    Inventario buscarInventario(int idUsuario);
}
