/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.controller.dao;

import pe.edu.pucp.steam.comunidad.model.GestorSanciones;
import pe.edu.pucp.steam.usuario.model.Usuario;
/**
 *
 * @author piero
 */
public interface GestorSancionesDAO {
    int crearGestor(GestorSanciones gestorSanciones, Usuario usuario);
    int actualizarGestor(GestorSanciones gestorSanciones);
    int buscarGestor(int idUser);
}
