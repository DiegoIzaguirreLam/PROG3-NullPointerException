/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.usuario.personal.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.usuario.personal.dao.RelacionDAO;
import pe.edu.pucp.steam.usuario.personal.dao.UsuarioDAO;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;

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

    @Override
    public ArrayList<Usuario> listarAmigosPorUsuario(int idUsuario) {
        ArrayList<Usuario> amigos = new ArrayList<>();
        
        try {
            con = DBManager.getInstance().getConnection();
            
            cs = con.prepareCall("{call LISTAR_AMIGOS_POR_USUARIO(?)}");     
            cs.setInt("_id_usuario", idUsuario);
            rs = cs.executeQuery();
            
            int idAmigo, idUsuarioA, idUsuarioB;
            while(rs.next()) {
                // Obtener el ID del amigo
                idUsuarioA = rs.getInt("ID Usuario A");
                idUsuarioB = rs.getInt("ID Usuario B");
                idAmigo = idUsuarioA != idUsuario ? idUsuarioA : idUsuarioB;
                
                // Obtener toda la información del amigo
                UsuarioDAO usuarioDao;
                try {
                    usuarioDao = new UsuarioMySQL();
                    Usuario amigo = usuarioDao.buscarUsuarioPorId(idAmigo);
                    amigos.add(amigo);
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try{con.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }
        }
        
        return amigos;
    }
}
