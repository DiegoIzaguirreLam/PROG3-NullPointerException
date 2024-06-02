package pe.edu.pucp.steam.perfil.mysql;

import pe.edu.pucp.steam.perfil.model.Comentario;
import pe.edu.pucp.steam.perfil.dao.ComentarioDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.perfil.model.Perfil;

public class ComentarioMySQL implements ComentarioDAO {
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int insertarComentario(Comentario comentario) {
        int resultado = 0;
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_COMENTARIO(?,?,?,?,?,?)}");
            cs.registerOutParameter("_id_comentario", java.sql.Types.INTEGER);
            cs.setInt("_fid_perfil", comentario.getIdComentarista());
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
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_COMENTARIO(?,?,?,?,?,?)}");
            cs.registerOutParameter("_id_expositor", java.sql.Types.INTEGER);
            cs.setInt("_fid_perfil", comentario.getIdComentarista());
            cs.setString("_texto", comentario.getTexto());
            cs.setInt("_nro_likes", comentario.getNlikes());
            cs.setBoolean("_oculto", comentario.isOculto());
            cs.executeUpdate();
            comentario.setIdComentario(cs.getInt("_id_comentario"));
            cs.setInt("_id_comentario", comentario.getIdComentario());
            cs.setInt("_fid_perfil", comentario.getPerfilComentado().getIdPerfil());
            cs.setInt("_fid_usuario", comentario.getIdComentarista());
            cs.setString("_texto", comentario.getTexto());
            cs.setInt("_nro_likes", comentario.getNlikes());
            cs.setBoolean("_oculto", comentario.isOculto());
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
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_COMENTARIO(?,?)}");
            cs.registerOutParameter("_id_expositor", java.sql.Types.INTEGER);
            cs.setInt("_fid_perfil", comentario.getIdComentarista());
            cs.executeUpdate();
            comentario.setIdComentario(cs.getInt("_id_comentario"));
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

    public int leerComentario(Comentario comentario) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
        
    public ArrayList<Comentario> listarComentarios() {
        ArrayList<Comentario> comentarios =  new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_COMENTARIOS()}");
            rs = cs.executeQuery();
            while(rs.next()){
                Comentario comentario = new Comentario();
                comentario.setIdComentario(rs.getInt("id_comentario"));
                comentario.setNlikes(rs.getInt("nro_likes"));
                comentario.setTexto(rs.getString("texto"));
                comentario.setOculto(rs.getBoolean("oculto"));
                comentario.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                comentario.setFechaMaxEdicion(rs.getDate("fecha_maxedicion"));
                comentario.setIdComentarista(rs.getInt("fid_usuario_comentarista"));
                comentario.setPerfilComentado(new Perfil());
                comentario.getPerfilComentado().setIdPerfil(rs.getInt("id_perfil"));
                comentario.getPerfilComentado().setActivo(rs.getBoolean("perfil_oculto"));
                comentarios.add(comentario);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{rs.close();}catch(Exception ex){System.out.println(ex.getMessage());}
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return comentarios;
    }

    @Override
    public ArrayList<Comentario> listarComentariosPerfil(int id_perfil) {
        ArrayList<Comentario> comentarios =  new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_COMENTARIOS_PERFIL(?)}");
            cs.setInt("_id_perfil",id_perfil);
            rs = cs.executeQuery();
            while(rs.next()){
                Comentario comentario = new Comentario();
                comentario.setIdComentario(rs.getInt("id_comentario"));
                comentario.setNlikes(rs.getInt("nro_likes"));
                comentario.setTexto(rs.getString("texto"));
                comentario.setOculto(rs.getBoolean("oculto"));
                comentario.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                comentario.setFechaMaxEdicion(rs.getDate("fecha_maxedicion"));
                comentario.setIdComentarista(rs.getInt("fid_usuario_comentarista"));
                comentario.setPerfilComentado(new Perfil());
                comentario.getPerfilComentado().setIdPerfil(rs.getInt("id_perfil"));
                comentario.getPerfilComentado().setActivo(rs.getBoolean("perfil_oculto"));
                comentarios.add(comentario);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{rs.close();}catch(Exception ex){System.out.println(ex.getMessage());}
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return comentarios;
    }
    
}
