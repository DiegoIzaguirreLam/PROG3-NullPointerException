package pe.edu.pucp.steam.usuario.personal.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;

public interface RelacionDAO {
    int agregarAmigo(int idUsuarioA, int idUsuarioB);
    int eliminarAmigo(int idUsuarioA, int idUsuarioB);
    int bloquearUsuario(int idUsuarioA, int idUsuarioB);
}
