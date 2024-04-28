/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.perfil.mysql;

import pe.edu.pucp.steam.perfil.model.Expositor;
import pe.edu.pucp.steam.perfil.dao.ExpositorDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.perfil.model.Perfil;

/**
 *
 * @author piero
 */
public class ExpositorMySQL implements ExpositorDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int crearExpositor(Expositor expositor) {
        int resultado = 0;
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_EXPOSITOR(?,?)}");
            cs.registerOutParameter("_id_expositor", java.sql.Types.INTEGER);
            cs.setInt("_fid_perfil", expositor.getOwner().getIdPerfil());
            cs.executeUpdate();
            expositor.setIdExpositor(cs.getInt("_id_expositor"));
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
    public int actualizaExpositor(Expositor expositor) {
        int resultado = 0;
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_EXPOSITOR(?,?,?,?)}");
            cs.setInt("_id_expositor", expositor.getIdExpositor());
            cs.setBoolean("_oculto", expositor.getOculto());
            cs.setBoolean("_activo", expositor.getActivo());
            cs.setInt("_fid_perfil", expositor.getOwner().getIdPerfil());
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
    public int ocultarExpositor(Expositor expositor) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call OCULTAR_EXPOSITOR(?)}");
            cs.setInt("_id_expositor", expositor.getIdExpositor());
            cs.executeUpdate();
            resultado = 1;
            cs.close();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());};
        }
        return resultado;
    }

    @Override
    public int eliminarExpositor(Expositor expositor) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_EXPOSITOR(?)}");
            cs.setInt("_id_expositor", expositor.getIdExpositor());
            cs.executeUpdate();
            resultado = 1;
            cs.close();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());};
        }
        return resultado;
    }

    @Override
    public ArrayList<Expositor> listarExpositores() {
        ArrayList<Expositor> expositores =  new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_EXPOSITORES()}");
            rs = cs.executeQuery();
            while(rs.next()){
                Expositor expositor = new Expositor();
                expositor.setIdExpositor(rs.getInt("id_expositor"));
                expositor.setActivo(rs.getBoolean("activo"));
                expositor.setOculto(rs.getBoolean("oculto"));
                expositor.setOwner(new Perfil());
                expositor.getOwner().setIdPerfil(rs.getInt("fid_perfil"));
                expositores.add(expositor);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{rs.close();}catch(Exception ex){System.out.println(ex.getMessage());}
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return expositores;
    }

    @Override
    public ArrayList<Expositor> listarExpositoresPerfil(int id_perfil) {
        ArrayList<Expositor> expositores =  new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_EXPOSITORES_PERFIL(?)}");
            cs.setInt("_id_perfil",id_perfil);
            rs = cs.executeQuery();
            while(rs.next()){
                Expositor expositor = new Expositor();
                expositor.setIdExpositor(rs.getInt("id_expositor"));
                expositor.setActivo(rs.getBoolean("activo"));
                expositor.setOculto(rs.getBoolean("oculto"));
                expositor.setOwner(new Perfil());
                expositor.getOwner().setIdPerfil(rs.getInt("fid_perfil"));
                expositores.add(expositor);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{rs.close();}catch(Exception ex){System.out.println(ex.getMessage());}
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return expositores;
    }
}
