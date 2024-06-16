package pe.edu.pucp.steam.usuario.personal.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.usuario.personal.dao.RelacionDAO;
import pe.edu.pucp.steam.usuario.personal.dao.UsuarioDAO;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;

public class RelacionMySQL implements RelacionDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int agregarAmigo(int idUsuarioActuador, int idUsuarioDestino) {
        int resultado = 0;
        
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call AGREGAR_AMIGO(?, ?)}");
            cs.setInt("_fid_usuario_actuador", idUsuarioActuador);
            cs.setInt("_fid_usuario_destino", idUsuarioDestino);
            resultado = cs.executeUpdate();
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try { con.close(); }
            catch(Exception ex)
            { System.out.println(ex.getMessage()); }
        }
        
        return resultado; 
    }

    @Override
    public int eliminarAmigo(int idUsuarioActuador, int idUsuarioDestino) {
        int resultado = 0;
        
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_AMIGO(?, ?)}");
            cs.setInt("_fid_usuario_actuador", idUsuarioActuador);
            cs.setInt("_fid_usuario_destino", idUsuarioDestino);
            resultado = cs.executeUpdate();
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try { con.close(); }
            catch(Exception ex)
            { System.out.println(ex.getMessage()); }
        }
        
        return resultado; 
    }

    @Override
    public int bloquearUsuario(int idUsuarioActuador, int idUsuarioDestino) {
        int resultado = 0;
        
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BLOQUEAR_USUARIO(?, ?)}");
            cs.setInt("_fid_usuario_actuador", idUsuarioActuador);
            cs.setInt("_fid_usuario_destino", idUsuarioDestino);
            resultado = cs.executeUpdate();
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try { con.close(); }
            catch(Exception ex)
            { System.out.println(ex.getMessage()); }
        }
        
        return resultado; 
    }
}