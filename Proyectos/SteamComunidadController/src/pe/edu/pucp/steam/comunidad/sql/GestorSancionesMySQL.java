/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.sql;

<<<<<<< HEAD
import pe.edu.pucp.steam.comunidad.dao.GestorSancionesDAO;
import pe.edu.pucp.steam.comunidad.model.GestorSanciones;

=======

import pe.edu.pucp.steam.comunidad.dao.GestorSancionesDAO;
import pe.edu.pucp.steam.comunidad.model.GestorSanciones;
import pe.edu.pucp.steam.usuario.model.Usuario;
import java.sql.CallableStatement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
/**
 *
 * @author piero
 */
public class GestorSancionesMySQL implements GestorSancionesDAO{
<<<<<<< HEAD

    @Override
    public int crearGestor(GestorSanciones gestorSanciones) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
=======
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int crearGestor(GestorSanciones gestorSanciones, Usuario usuario) {

        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_GESTOR"
                    + "(?,?,?,?,?,?,?,?,?)}");
            cs.registerOutParameter("_id_gestor",
                    java.sql.Types.INTEGER);
            cs.setInt("_id_usuario", usuario.getUID());
            cs.setInt("_contador_baneos",gestorSanciones.getContadorBaneos());
            cs.setInt("_contador_palabras",gestorSanciones.getContadorPalabras());
            cs.setInt("_max_faltas",gestorSanciones.getMaxFaltas());
            cs.setInt("_max_baneos",gestorSanciones.getMaxBaneos());
            cs.setInt("_cant_baneos",gestorSanciones.getCantBaneos());
            cs.setInt("_cant_faltas",gestorSanciones.getCantFaltas());
            cs.setDate("_fin_ban", new java.sql.Date(
                    gestorSanciones.getFinBan().getTime()));
           
            cs.executeUpdate();
            gestorSanciones.setIdGestor(cs.getInt("_id_usuario"));
 
            resultado = gestorSanciones.getIdGestor();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            
            try{con.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }

        }
        return resultado;
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
    }

    @Override
    public int actualizarGestor(GestorSanciones gestorSanciones) {
<<<<<<< HEAD
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int buscarGestor(int idUser) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
=======
           int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call EDITAR_GESTOR"
                    + "(?,?,?,?,?,?,?,?,?)}");
            
            cs.setInt("_id_usuario", gestorSanciones.getIdGestor());
            cs.setInt("_contador_baneos",gestorSanciones.getContadorBaneos());
            cs.setInt("_contador_palabras",gestorSanciones.getContadorPalabras());
            cs.setInt("_contador_faltas",gestorSanciones.getContadorFaltas());
            cs.setInt("_max_faltas",gestorSanciones.getMaxFaltas());
            cs.setInt("_max_baneos",gestorSanciones.getMaxBaneos());
            cs.setInt("_cant_baneos",gestorSanciones.getCantBaneos());
            cs.setInt("_cant_faltas",gestorSanciones.getCantFaltas());
            cs.setDate("_fin_ban", new java.sql.Date(
                    gestorSanciones.getFinBan().getTime()));
           
           resultado = cs.executeUpdate();
       
 
        
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            
            try{con.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }

        }
        return resultado;
    }
    
    /*@Override
    public int buscarGestor(int idUser) {
       
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }*/
    
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
}
