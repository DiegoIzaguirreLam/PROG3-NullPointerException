/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.perfil.model.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.perfil.model.Comentario;
import pe.edu.pucp.steam.perfil.model.Expositor;
import pe.edu.pucp.steam.perfil.model.Perfil;

/**
 *
 * @author GAMER
 */
public interface PerfilDAO {
    int crearExpositor(Expositor expositor);
    int actualizaExpositor(Expositor expositor);
    int actualizaPerfil(Perfil perfil);
    int ocultarExpositor(Expositor expositor);
    int eliminarExpositor(Expositor expositor);
    ArrayList<Comentario> listarComentarios(Perfil perfil);
    ArrayList<Expositor> listarExpositores(Perfil perfil);
}
