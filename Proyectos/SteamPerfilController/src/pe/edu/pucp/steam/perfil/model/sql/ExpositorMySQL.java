/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.perfil.model.sql;

import pe.edu.pucp.steam.perfil.model.Expositor;
import pe.edu.pucp.steam.perfil.model.dao.ExpositorDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class ExpositorMySQL implements ExpositorDAO{
    private Connection con;
    private CallableStatement cs;

    @Override
    public int crearExpositor(Expositor expositor) {
        int resultado = 0;
        try {
            con = DriverManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_EXPOSITOR(?,?)}");
            cs.registerOutParameter("_id_expositor", java.sql.Types.INTEGER);
            cs.setInt("_fid_perfil", expositor.getowner().getIdPerfil());
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
            con = DriverManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_EXPOSITOR(?,?,?,?)}");
            cs.setInt("_id_expositor", expositor.getIdExpositor());
            cs.setBoolean("_oculto", expositor.getOculto());
            cs.setBoolean("_activo", expositor.getActivo());
            cs.setInt("_fid_perfil", expositor.getowner().getIdPerfil());
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
            con = DriverManager.getInstance().getConnection();
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
            con = DriverManager.getInstance().getConnection();
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
}
