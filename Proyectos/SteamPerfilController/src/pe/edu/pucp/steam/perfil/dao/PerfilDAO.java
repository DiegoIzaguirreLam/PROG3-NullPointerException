/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.perfil.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.perfil.model.Comentario;
import pe.edu.pucp.steam.perfil.model.Expositor;
import pe.edu.pucp.steam.perfil.model.Perfil;

/**
 *
 * @author GAMER
 */
public interface PerfilDAO {
    int crearPerfil(Perfil perfil); //Cuando un user se registre se llamará este método
    int actualizaPerfil(Perfil perfil);
    int ocultarPerfil(Perfil perfil);
    int buscarPerfil(int idUser);
    ArrayList<Comentario> listarComentarios(Perfil perfil);
    ArrayList<Expositor> listarExpositores(Perfil perfil);
}
