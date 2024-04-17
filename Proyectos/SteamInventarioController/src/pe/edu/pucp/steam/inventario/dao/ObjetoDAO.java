package pe.edu.pucp.steam.inventario.dao;

import pe.edu.pucp.steam.inventario.model.Objeto;

public interface ObjetoDAO {
    int crearObjeto(Objeto objeto);
    int actualizarObjeto(Objeto objeto);
}
