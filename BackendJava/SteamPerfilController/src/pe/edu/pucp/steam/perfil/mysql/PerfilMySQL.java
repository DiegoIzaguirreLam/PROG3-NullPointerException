package pe.edu.pucp.steam.perfil.mysql;

import java.util.ArrayList;

import pe.edu.pucp.steam.perfil.model.Comentario;
import pe.edu.pucp.steam.perfil.model.Expositor;
import pe.edu.pucp.steam.perfil.model.Perfil;
import pe.edu.pucp.steam.perfil.dao.PerfilDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import java.sql.ResultSet;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.perfil.dao.ComentarioDAO;
import pe.edu.pucp.steam.perfil.dao.ExpositorDAO;

public class PerfilMySQL implements PerfilDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int asignarPerfilUsuario(int uid_usuario) {
        int resultado = 0;
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_PERFIL(?,?,?)}");
            cs.registerOutParameter("_id_perfil",
                    java.sql.Types.INTEGER);
            cs.setInt("_fid_usuario", uid_usuario);
            cs.setString("_foto_url", "[foto por defecto]");
            cs.executeUpdate();
            resultado = cs.getInt("_id_perfil");
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
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_PERFIL(?)}");
            cs.setInt("_id_perfil", perfil.getIdPerfil());
            cs.setString("_foto_url", perfil.getFotoUrl());
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
            con = DBManager.getInstance().getConnection();
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

    public ArrayList<Comentario> listarComentarios(Perfil perfil) {
        return null;
    }

    public ArrayList<Expositor> listarExpositores(Perfil perfil) {
        return null;
    }
    
    public Perfil buscarPerfil(int idUser) {
        Perfil perfil= new Perfil();
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_PERFIL(?)}");
            cs.setInt("_id_usuario", idUser);
            rs = cs.executeQuery();
            rs.next();
            perfil.setIdPerfil(rs.getInt("id_perfil"));
            perfil.setFotoUrl(rs.getString("url_foto"));
            perfil.setActivo(rs.getBoolean("oculto"));
            ComentarioDAO daoComentario = new ComentarioMySQL();
            perfil.setComentarios(daoComentario.listarComentariosPerfil(perfil.getIdPerfil()));
            ExpositorDAO daoExpositor = new ExpositorMySQL();
            perfil.setExpositores(daoExpositor.listarExpositoresPerfil(perfil.getIdPerfil()));
//            ObjetoUsable daoObjetoUsable = new ObjetoUsableMySQL();
//            perfil.setMostradosPerfil(daoObjetoUsable.listarObjetosUsablesPerfil(perfil.getIdPerfil()));
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {  
            try {con.close();} catch (Exception ex) {System.out.println(ex.getMessage());}
            try {rs.close();} catch (Exception ex) {System.out.println(ex.getMessage());}
        }
        return perfil;
    }

    @Override
    public ArrayList<Perfil> listarPerfiles() {
        ArrayList<Perfil> perfiles =  new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PERFILES()}");
            rs = cs.executeQuery();
            while(rs.next()){
                Perfil perfil = new Perfil();
                perfil.setIdPerfil(rs.getInt("id_perfil"));
                perfil.setActivo(rs.getBoolean("oculto"));
                perfiles.add(perfil);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{rs.close();}catch(Exception ex){System.out.println(ex.getMessage());}
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return perfiles;
    }
    
    
}