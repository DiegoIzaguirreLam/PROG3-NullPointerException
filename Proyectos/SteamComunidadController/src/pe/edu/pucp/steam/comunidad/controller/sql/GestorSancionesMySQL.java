/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.controller.sql;

import pe.edu.pucp.steam.comunidad.controller.dao.GestorSancionesDAO;
import pe.edu.pucp.steam.comunidad.model.GestorSanciones;
import pe.edu.pucp.steam.usuario.model.Usuario;
/**
 *
 * @author piero
 */
public class GestorSancionesMySQL implements GestorSancionesDAO{

    @Override
    public int crearGestor(GestorSanciones gestorSanciones, Usuario usuario) {
        return 0;
    }

    @Override
    public int actualizarGestor(GestorSanciones gestorSanciones) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int buscarGestor(int idUser) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
