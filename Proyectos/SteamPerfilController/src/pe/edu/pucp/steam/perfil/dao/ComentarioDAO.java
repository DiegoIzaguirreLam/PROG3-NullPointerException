/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.perfil.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.perfil.model.Comentario;

/**
 *
 * @author piero
 */
public interface ComentarioDAO {
    int insertarComentario(Comentario comentario);
    int actualizarComentario(Comentario comentario);
    int ocultarComentario(Comentario comentario);
    ArrayList<Comentario> listarComentarios();
    ArrayList<Comentario> listarComentariosPerfil(int id_perfil);
}
