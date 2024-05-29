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
public interface RelacionDAO {
    int agregarAmigo(int idUsuarioA, int idUsuarioB);
    int eliminarAmigo(int idUsuarioA, int idUsuarioB);
    int bloquearUsuario(int idUsuarioA, int idUsuarioB);
    ArrayList<Usuario> listarAmigosPorUsuario(int idUsuario);
}
