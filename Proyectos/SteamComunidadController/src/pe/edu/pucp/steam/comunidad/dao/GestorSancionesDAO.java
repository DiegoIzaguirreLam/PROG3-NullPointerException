package pe.edu.pucp.steam.comunidad.dao;

import pe.edu.pucp.steam.comunidad.model.GestorSanciones;
import pe.edu.pucp.steam.usuario.model.Usuario;

public interface GestorSancionesDAO {
    int crearGestor(GestorSanciones gestorSanciones, Usuario usuario);
    int actualizarGestor(GestorSanciones gestorSanciones);
    /*int buscarGestor(int idUser);*/
}
