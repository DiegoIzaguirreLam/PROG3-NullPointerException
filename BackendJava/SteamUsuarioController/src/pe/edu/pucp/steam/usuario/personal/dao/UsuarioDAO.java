package pe.edu.pucp.steam.usuario.personal.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;

public interface UsuarioDAO {
    int insertarUsuario(Usuario jugador);
    int actualizarUsuario(Usuario jugador);
    int suspenderUsuario(Usuario jugador); //Elimina logicamente
    int eliminarUsuario(Usuario jugador); //Elimina de la base de datos
    Usuario buscarUsuarioPorNombreCuenta (String nombreCuenta);
    Usuario buscarUsuarioPorId (int uid);
    Usuario verificarCuenta (String nombreCuenta, String password);
    ArrayList<Usuario> listarUsuarios();
    ArrayList<Usuario> listarUsuariosPorNombreCuenta(String nombreCuenta);
    ArrayList<Usuario> listarAmigosPorUsuario(int idUsuario);
    ArrayList<Usuario> listarBloqueadosPorUsuario(int idUsuario);
    ArrayList<Usuario> listarUsuariosQueBloquearon(int idUsuario);
}