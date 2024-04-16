/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.controller.sql;

import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.controller.dao.ForoDAO;
import pe.edu.pucp.steam.comunidad.model.Foro;
import pe.edu.pucp.steam.comunidad.model.Subforo;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.CallableStatement;
/**
 *
 * @author piero
 */
public class ForoMySQL implements ForoDAO{

	private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;
	
    @Override
    public int crearForo(Foro foro) {
     int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_FORO"
                    + "(?,?,?)}");
            cs.registerOutParameter("_id_foro",
                    java.sql.Types.INTEGER);
            cs.setString("_nombre", foro.getNombre());
            cs.setString("_descripcion",foro.getDescripcion());
            cs.setString("_origen_foro", String.valueOf(foro.getOrigen()));
            cs.executeUpdate();
            foro.setIdForo(cs.getInt("_id_foro"));
            resultado = foro.getIdForo();
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
    public ArrayList<Subforo> mostrarSubforosForo(Foro foro) {
        ArrayList<Subforo> subforos =  new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call MOSTRAR_SUBFOROS_POR_FORO"
                    + "(?)}");
 
			cs.setInt("_id_foro", foro.getIdForo());
            rs = cs.executeQuery();
			while(rs.next()){
                Subforo subforo = new Subforo();
				subforo.setIdSubforo(rs.getInt("id_subforo"));
				subforo.setNombre(rs.getString("nombre"));
				subforos.add(subforo);
                
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
        return subforos;   
    }

    @Override
    public int editarForo(Foro foro) {
      int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call EDITAR_FORO"
                    + "(?,?,?,?)}");
 
			cs.setInt("_id_foro", foro.getIdForo());
            cs.setString("_nombre", foro.getNombre());
            cs.setString("_descripcion",foro.getDescripcion());
            cs.setString("_origen_foro", String.valueOf(foro.getOrigen()));
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
    public int eliminarForo(Foro foro) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
