package pe.edu.pucp.steam.comunidad.mysql;

import pe.edu.pucp.steam.comunidad.dao.MensajeDAO;
import pe.edu.pucp.steam.comunidad.model.Mensaje;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.steam.comunidad.model.Hilo;

public class MensajeMySQL implements MensajeDAO{
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarMensaje(Mensaje mensaje) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_MENSAJE"
                    + "(?,?,?,?,?,?)}");
            cs.registerOutParameter("_id_mensaje",
                    java.sql.Types.INTEGER);
            cs.setInt("_id_hilo", mensaje.getHilo().getIdHilo());
            cs.setInt("_id_usuario",mensaje.getIdAutor());
            cs.setString("_contenido",mensaje.getContenido());
            cs.setDate("_fecha_publicacion", new java.sql.Date((new Date()).getTime()));
            cs.setDate("_fecha_max_edicion", new java.sql.Date((new Date()).getTime()));
            cs.executeUpdate();
            mensaje.setIdMensaje(cs.getInt("_id_mensaje"));
            mensaje.setOculto(false);
            resultado = mensaje.getIdMensaje();
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
    public ArrayList<Mensaje> mostrarMensajesHilo(Hilo hilo) {
                ArrayList<Mensaje> mensajes =  new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call MOSTRAR_MENSAJES_POR_HILO"
                    + "(?)}");
 
			cs.setInt("_id_hilo", hilo.getIdHilo());
            rs = cs.executeQuery();
			while(rs.next()){
                Mensaje mensaje = new Mensaje();
				mensaje.setIdMensaje(rs.getInt("id_mensaje"));
                                mensaje.setContenido(rs.getString("contenido"));
                                mensaje.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                                mensaje.setFechaMaxEdicion(rs.getDate("fecha_max_edicion"));
                                mensaje.setIdAutor(rs.getInt("fid_usuario"));
                                mensaje.setNombreUsuario(rs.getString("nombre_perfil"));
                                mensaje.setFotoPerfil(rs.getString("foto_url"));
				mensajes.add(mensaje);
                
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            
            try{con.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }
			try{rs.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }
			
        }
        return mensajes;   
    }

    @Override
    public int editarMensaje(Mensaje mensaje) {
    int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call EDITAR_MENSAJE"
                    + "(?,?)}");
            cs.setInt("_id_mensaje", mensaje.getIdMensaje());
            cs.setInt("_id_hilo", mensaje.getHilo().getIdHilo());
            cs.setString("_contenido",mensaje.getContenido());
            cs.setDate("_fecha_max_edicion", new java.sql.Date(
                    mensaje.getFechaMaxEdicion().getTime()));
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
    public int eliminarMensaje(Mensaje mensaje) {
       int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call DESACTIVAR_MENSAJE"
                    + "(?)}");
            cs.setInt("_id_mensaje", mensaje.getIdMensaje());

            resultado = cs.executeUpdate();
            mensaje.setOculto(true);            
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
    public String leerMensaje(Mensaje mensaje) {
         Mensaje msg = new Mensaje();
         
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call MOSTRAR_MENSAJE"
                    + "(?)}");
 
	    cs.setInt("_id_mensaje", mensaje.getIdMensaje());
            rs = cs.executeQuery();
            rs.next();
                      
				msg.setIdMensaje(rs.getInt("id_mensaje"));
				msg.setContenido(rs.getString("contenido"));
                                msg.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                                msg.setFechaMaxEdicion(rs.getDate("fecha_max_edicion"));
                                msg.setIdAutor(rs.getInt("fid_usuario"));
                                msg.setOculto(rs.getBoolean("oculto"));
                
            
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            
            try{con.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }
			try{rs.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }
			
        }
        return msg.getContenido();   
    }
}