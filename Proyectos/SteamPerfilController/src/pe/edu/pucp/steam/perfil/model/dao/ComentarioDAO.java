/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.perfil.model.dao;

import pe.edu.pucp.steam.perfil.model.Comentario;

/**
 *
 * @author piero
 */
public interface ComentarioDAO {
    int crearComentario(Comentario comentario);
    int actualizarComentario(Comentario comentario);
    int ocultarComentario(Comentario comentario);
    int leerComentario(Comentario comentario);
}
