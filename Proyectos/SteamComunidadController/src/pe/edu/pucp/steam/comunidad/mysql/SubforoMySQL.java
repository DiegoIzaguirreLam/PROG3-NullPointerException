/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.mysql;

import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.dao.SubforoDAO;
import pe.edu.pucp.steam.comunidad.model.Hilo;
import pe.edu.pucp.steam.comunidad.model.Subforo;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.comunidad.model.Foro;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.CallableStatement;


/**
 *
 * @author piero
 */
public class SubforoMySQL implements SubforoDAO{
    
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarSubforo(Subforo subforo) {
       int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_SUBFORO"
                    + "(?,?)}");
            cs.registerOutParameter("_id_subforo",
                    java.sql.Types.INTEGER);
            cs.setInt("_id_foro", subforo.getForo().getIdForo());
            cs.setString("_nombre",subforo.getNombre());
      
            cs.executeUpdate();
            subforo.setIdSubforo(cs.getInt("_id_subforo"));
            subforo.setActivo(true);
            resultado = subforo.getIdSubforo();
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
    public int editarSubforo(Subforo subforo) {
         int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call EDITAR_SUBFORO"
                    + "(?,?)}");
           
            cs.setInt("_id_subforo", subforo.getIdSubforo());
            cs.setString("_nombre",subforo.getNombre());
      
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
    public int eliminarSubforo(Subforo subforo) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call DESACTIVAR_SUBFORO"
                    + "(?)}");
           
            cs.setInt("_id_subforo", subforo.getIdSubforo());
      
            resultado = cs.executeUpdate();
            subforo.setActivo(true);
            
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            
            try{con.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }

        }
        return resultado;
    }
    
}
