package pe.edu.pucp.steam.comunidad.dao;

import pe.edu.pucp.steam.comunidad.model.GestorSanciones;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;

public interface GestorSancionesDAO {
    int insertarGestor(GestorSanciones gestorSanciones, Usuario usuario);
    int actualizarGestor(GestorSanciones gestorSanciones);
    /*int buscarGestor(int idUser);*/
}
