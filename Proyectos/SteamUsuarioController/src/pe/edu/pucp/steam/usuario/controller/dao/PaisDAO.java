/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.usuario.controller.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.model.Pais;
import pe.edu.pucp.steam.usuario.model.Usuario;

/**
 *
 * @author GAMER
 */
public interface PaisDAO {
    int crearPais(Pais pais);
    int eliminarPais(Pais pais);
    ArrayList<Usuario> listarUsuario(Pais pais);
    Pais buscarPais(int idPais);
}
