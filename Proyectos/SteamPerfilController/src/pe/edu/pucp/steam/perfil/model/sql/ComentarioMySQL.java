/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.perfil.model.sql;

import pe.edu.pucp.steam.perfil.model.Comentario;
import pe.edu.pucp.steam.perfil.model.dao.ComentarioDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
/**
 *
 * @author piero
 */

public class ComentarioMySQL implements ComentarioDAO{
    private Connection con;
    private CallableStatement cs;

    @Override
    public int crearComentario(Comentario comentario) {
        int resultado = 0;
        try {
            con = DriverManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_COMENTARIO(?,?,?,?,?)}");
            cs.registerOutParameter("_id_comentario", java.sql.Types.INTEGER);
            cs.setInt("_fid_perfil", comentario.getPerfilComentado().getIdPerfil());
            cs.setInt("_fid_usuario", comentario.getIdComentarista());
            cs.setString("_texto", comentario.getTexto());
            cs.setInt("_nro_likes", comentario.getNlikes());
            cs.executeUpdate();
            comentario.setIdComentario(cs.getInt("_id_comentario"));
            resultado = 1;
            cs.close();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {  
            try {con.close();} catch (Exception ex) {System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int actualizarComentario(Comentario comentario) {
        int resultado = 0;
        try {
            con = DriverManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_COMENTARIO(?,?,?,?,?,?)}");
            cs.setInt("_id_comentario", comentario.getIdComentario());
            cs.setInt("_fid_perfil", comentario.getPerfilComentado().getIdPerfil());
            cs.setInt("_fid_usuario", comentario.getIdComentarista());
            cs.setString("_texto", comentario.getTexto());
            cs.setInt("_nro_likes", comentario.getNlikes());
            cs.setBoolean("_oculto", comentario.getOculto());
            cs.executeUpdate();
            resultado = 1;
            cs.close();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {  
            try {con.close();} catch (Exception ex) {System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int ocultarComentario(Comentario comentario) {
        int resultado = 0;
        try {
            con = DriverManager.getInstance().getConnection();
            cs = con.prepareCall("{call OCULTAR_COMENTARIO(?)}");
            cs.setInt("_id_comentario", comentario.getIdComentario());
            cs.executeUpdate();
            resultado = 1;
            cs.close();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {  
            try {con.close();} catch (Exception ex) {System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int leerComentario(Comentario comentario) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
