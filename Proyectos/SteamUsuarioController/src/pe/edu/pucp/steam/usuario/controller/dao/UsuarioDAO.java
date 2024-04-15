/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.usuario.controller.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.model.Usuario;

/**
 *
 * @author GAMER
 */
public interface UsuarioDAO {
    int registrar(Usuario jugador);
    int actualiza(Usuario jugador);
    int suspenderCuenta(Usuario jugador); //Elimina logicamente
    int eliminarCuenta(Usuario jugador); //Elimina de la base de datos
    ArrayList<Usuario> listarCuentas();
}
