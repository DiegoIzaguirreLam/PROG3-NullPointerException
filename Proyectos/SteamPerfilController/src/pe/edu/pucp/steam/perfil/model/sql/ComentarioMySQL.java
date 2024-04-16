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
            con = DriverManager.getConnection(DBManager.url, DBManager.user, DBManager.password);
            cs = con.prepareCall("{call INSERTAR_COMENTARIO(?,?,?,?,?,?)}");
            cs.registerOutParameter("_id_comentario", java.sql.Types.INTEGER);
            cs.setInt("_fid_perfil", comentario.getComentarista().getIdPerfil());
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
            con = DriverManager.getConnection(DBManager.url, DBManager.user, DBManager.password);
            cs = con.prepareCall("{call ACTUALIZAR_COMENTARIO(?,?,?,?,?,?)}");
            cs.registerOutParameter("_id_expositor", java.sql.Types.INTEGER);
            cs.setInt("_fid_perfil", expositor.getowner().getIdPerfil());
            cs.setString("_texto", expositor.getTexto());
            cs.setInt("_nro_likes", expositor.getNlikes());
            cs.setBoolean("_oculto", expositor.getOculto());
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
    public int ocultarComentario(Comentario comentario) {
        int resultado = 0;
        try {
            con = DriverManager.getConnection(DBManager.url, DBManager.user, DBManager.password);
            cs = con.prepareCall("{call INSERTAR_COMENTARIO(?,?)}");
            cs.registerOutParameter("_id_expositor", java.sql.Types.INTEGER);
            cs.setInt("_fid_perfil", expositor.getowner().getIdPerfil());
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
    public int leerComentario(Comentario comentario) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
