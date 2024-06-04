package pe.edu.pucp.steam.comunidad.dao;

import pe.edu.pucp.steam.comunidad.model.GestorSanciones;

public interface GestorSancionesDAO {
    int asignarGestorUsuario (int uid_usuario);
    int actualizarGestor(GestorSanciones gestorSanciones);
    GestorSanciones buscarGestor(int idUser);
}
