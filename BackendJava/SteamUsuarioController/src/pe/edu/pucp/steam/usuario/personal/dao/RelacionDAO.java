package pe.edu.pucp.steam.usuario.personal.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;

public interface RelacionDAO {
    int agregarAmigo(int idUsuarioActuador, int idUsuarioDestino);
    int eliminarAmigo(int idUsuarioActuador, int idUsuarioDestino);
    int bloquearUsuario(int idUsuarioActuador, int idUsuarioDestino);
}