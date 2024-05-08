/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.usuario.personal.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.usuario.personal.dao.RelacionDAO;

/**
 *
 * @author GAMER
 */
public class RelacionMySQL implements RelacionDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int agregarAmigo(int idUsuarioA, int idUsuarioB) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call AGREGAR_AMIGO(?, ?)}");
            cs.setInt("_fid_usuario_a", idUsuarioA);
            cs.setInt("_fid_usuario_b", idUsuarioB);
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

    @Override
    public int eliminarAmigo(int idUsuarioA, int idUsuarioB) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_AMIGO(?, ?)}");
            cs.setInt("_fid_usuario_a", idUsuarioA);
            cs.setInt("_fid_usuario_b", idUsuarioB);
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

    @Override
    public int bloquearUsuario(int idUsuarioA, int idUsuarioB) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BLOQUEAR_USUARIO(?, ?)}");
            cs.setInt("_fid_usuario_a", idUsuarioA);
            cs.setInt("_fid_usuario_b", idUsuarioB);
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
}
