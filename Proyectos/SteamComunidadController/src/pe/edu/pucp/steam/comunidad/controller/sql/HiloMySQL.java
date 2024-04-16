/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.controller.sql;

import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.controller.dao.HiloDAO;
import pe.edu.pucp.steam.comunidad.model.Hilo;
import pe.edu.pucp.steam.comunidad.model.Mensaje;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.CallableStatement;
/**
 *
 * @author piero
 */
public class HiloMySQL implements HiloDAO {
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int crearHilo(Hilo hilo, int idSubforo) {
        int resultado=0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_HILO"
                    + "(?,?,?,?)}");
           
            cs.registerOutParameter("_id_hilo",
                    java.sql.Types.INTEGER);
            cs.setInt("_id_subforo", idSubforo);
            cs.setBoolean("_fijado",hilo.isFijado());
            cs.setDate("_fecha_creacion", new java.sql.Date(
                    hilo.getFechaCreacion().getTime()));
            cs.setDate("_fecha_modificacion",new java.sql.Date(
                    hilo.getFechaModificacion().getTime()) );
            cs.executeUpdate();
            hilo.setIdHilo(cs.getInt("_id_hilo"));
            hilo.setOculto(false);
            resultado = hilo.getIdHilo();
            
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
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int editarHilo(Hilo hilo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int eliminarHilo(Hilo hilo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    
}
