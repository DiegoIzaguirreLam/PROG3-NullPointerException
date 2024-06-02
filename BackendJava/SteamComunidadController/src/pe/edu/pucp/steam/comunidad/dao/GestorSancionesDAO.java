package pe.edu.pucp.steam.comunidad.dao;

import pe.edu.pucp.steam.comunidad.model.GestorSanciones;

public interface GestorSancionesDAO {
    int insertarGestor(GestorSanciones gestorSanciones);
    int actualizarGestor(GestorSanciones gestorSanciones);
    GestorSanciones buscarGestor(int idUser);
}
