/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.perfil.model.sql;

import java.util.ArrayList;
import pe.edu.pucp.steam.perfil.model.Comentario;
import pe.edu.pucp.steam.perfil.model.Expositor;
import pe.edu.pucp.steam.perfil.model.Perfil;
import pe.edu.pucp.steam.perfil.model.dao.PerfilDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author GAMER
 */
public class PerfilMySQL implements PerfilDAO{
    private Connection con;
    private CallableStatement cs;

    @Override
    public int crearPerfil(Perfil perfil) {
        int resultado = 0;
        try {
            con = DriverManager.getConnection(DBManager.url, DBManager.user, DBManager.password);
            cs = con.prepareCall("{call INSERTAR_PERFIL(?)}");
            cs.setInt("_id_perfil", perfil.getIdPerfil());
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
    public int actualizaPerfil(Perfil perfil) {
        int resultado = 0;
        try {
            con = DriverManager.getConnection(DBManager.url, DBManager.user, DBManager.password);
            cs = con.prepareCall("{call ACTUALIZAR_PERFIL(?)}");
            cs.setInt("_id_perfil", perfil.getIdPerfil());
            cs.setBoolean("_oculto", perfil.getOculto());
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
    public int ocultarPerfil(Perfil perfil) {
        int resultado = 0;
        try {
            con = DriverManager.getConnection(DBManager.url, DBManager.user, DBManager.password);
            cs = con.prepareCall("{call OCULTAR_PERFIL(?)}");
            cs.setInt("_id_perfil", perfil.getIdPerfil());
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
    public int buscarPerfil(int idUser) {
        
    }

    @Override
    public ArrayList<Comentario> listarComentarios(Perfil perfil) {
        
    }

    @Override
    public ArrayList<Expositor> listarExpositores(Perfil perfil) {
        
    }
    
    
}
