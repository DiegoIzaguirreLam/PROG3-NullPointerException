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
import pe.edu.pucp.steam.usuario.personal.dao.NotificacionDAO;
import pe.edu.pucp.steam.usuario.personal.model.Notificacion;
import pe.edu.pucp.steam.usuario.personal.model.TipoNotificacion;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;

/**
 *
 * @author GAMER
 */
public class NotificacionMySQL implements NotificacionDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int insertarNotificacion(Notificacion notificacion) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_NOTIFICACION"
                    + "(?,?,?,?)}");
            cs.registerOutParameter("_ID_NOTIFICACION",
                    java.sql.Types.INTEGER);
            cs.setString("_TIPO", notificacion.getTipo().toString());
            cs.setString("_MENSAJE", notificacion.getMensaje());
            cs.setInt("_FID_USUARIO", notificacion.getUsuario().getUID());
            cs.executeUpdate();
            notificacion.setIdNotificacion(cs.getInt("_ID_NOTIFICACION"));
            resultado = notificacion.getIdNotificacion();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int eliminarNotificacion(Notificacion notificacion) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_NOTIFICACION"
                    + "(?)}");
            cs.setInt("_ID_NOTIFICACION", notificacion.getIdNotificacion());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int actualizarNotificacion(Notificacion notificacion) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_NOTIFICACION"
                    + "(?,?,?,?)}");
            cs.setInt("_ID_NOTIFICACION", notificacion.getIdNotificacion());
            cs.setString("_TIPO", notificacion.getTipo().toString());
            cs.setString("_MENSAJE", notificacion.getMensaje());
            cs.setInt("_FID_USUARIO", notificacion.getUsuario().getUID());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public ArrayList<Notificacion> listarNotificaciones(Usuario usuario) {
        ArrayList<Notificacion> notificaciones = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_NOTIFICACIONES(?)}");
            cs.setInt("_FID_USUARIO", usuario.getUID());
            rs = cs.executeQuery();
            while(rs.next()){
                Notificacion notificacion = new Notificacion();
                notificacion.setIdNotificacion(rs.getInt("id_notificacion"));
                notificacion.setMensaje(rs.getString("mensaje"));
                notificacion.setTipo(TipoNotificacion.valueOf(rs.getString("tipo")));
                notificacion.setUsuario(new Usuario());
                notificacion.getUsuario().setUID(rs.getInt("fid_usuario"));
                notificacion.setRevisada(rs.getBoolean("revisada"));
                notificaciones.add(notificacion);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return notificaciones;
    }
    
}
