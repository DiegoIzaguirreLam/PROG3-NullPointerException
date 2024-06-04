/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.usuario.personal.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;

/**
 *
 * @author GAMER
 */
public interface UsuarioDAO {
    int insertarUsuario(Usuario jugador);
    int actualizarUsuario(Usuario jugador);
    int suspenderUsuario(Usuario jugador); //Elimina logicamente
    int eliminarUsuario(Usuario jugador); //Elimina de la base de datos
    Usuario buscarUsuarioPorNombreCuenta (String nombreCuenta);
    Usuario buscarUsuarioPorId (int uid);
    Usuario verificarCuenta (String nombreCuenta, String password);
    ArrayList<Usuario> listarUsuarios();
}
