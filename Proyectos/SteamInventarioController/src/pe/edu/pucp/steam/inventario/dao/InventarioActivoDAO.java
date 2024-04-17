package pe.edu.pucp.steam.inventario.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.inventario.model.InventarioActivo;
import pe.edu.pucp.steam.inventario.model.ObjetoObtenido;

public interface InventarioActivoDAO {
    int crearInventarioActivo(InventarioActivo inventario);
    ArrayList<ObjetoObtenido> listarObjetos(int idInventarioActivo);
    InventarioActivo buscarInventario(int idInventario);
}