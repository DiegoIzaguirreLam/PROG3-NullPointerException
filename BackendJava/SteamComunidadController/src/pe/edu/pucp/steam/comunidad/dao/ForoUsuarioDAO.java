/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.model.Foro;

/**
 *
 * @author GAMER
 */
public interface ForoUsuarioDAO {
    int crearRelacion(int idForo, int idUsuario);
    int suscribirRelacion(int idForo, int idUsuario);
    int eliminarRelacion(int idForo, int idUsuario);
    int desuscribirRelacion(int idForo, int idUsuario);
    ArrayList<Foro> listarSuscritos(int idUsuario);
    ArrayList<Integer> listarSuscriptores(int idForo);
}
