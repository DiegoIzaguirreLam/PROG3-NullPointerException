/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.mysql;

import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.dao.ForoDAO;
import pe.edu.pucp.steam.comunidad.model.Foro;
import pe.edu.pucp.steam.comunidad.model.Subforo;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.CallableStatement;
import pe.edu.pucp.steam.comunidad.model.OrigenForo;
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
    public int insertarForo(Foro foro) {
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
            foro.setActivo(true);
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
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call DESACTIVAR_FORO"
                    + "(?)}");
 
	    cs.setInt("_id_foro", foro.getIdForo());
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
    public ArrayList<Foro> listarForos() {
        ArrayList<Foro> foros =  new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_FOROS}");
            rs = cs.executeQuery();
            while(rs.next()){
                Foro foro = new Foro();
                foro.setIdForo(rs.getInt("id_foro"));
                foro.setNombre(rs.getString("nombre"));
                foro.setDescripcion(rs.getString("descripcion"));
                foro.setOrigen(OrigenForo.valueOf(rs.getString("origen_foro")));
                foro.setIdCreador(rs.getInt("id_user"));
		foros.add(foro);
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
        return foros; 
    }

    @Override
    public ArrayList<Foro> buscarForos(String nombre) {
        ArrayList<Foro> foros =  new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_FORO}");
            cs.setString("_nombre", nombre);
            rs = cs.executeQuery();
            while(rs.next()){
                Foro foro = new Foro();
                foro.setIdForo(rs.getInt("id_foro"));
                foro.setNombre(rs.getString("nombre"));
                foro.setDescripcion(rs.getString("descripcion"));
                foro.setOrigen(OrigenForo.valueOf(rs.getString("origen_foro")));
                foro.setIdCreador(rs.getInt("id_user"));
		foros.add(foro);
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
        return foros;
    }

    @Override
    public ArrayList<Foro> listarCreados(int idUser) {
        ArrayList<Foro> foros =  new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_CREADOS}");
            cs.setInt("_iduser", idUser);
            rs = cs.executeQuery();
            while(rs.next()){
                Foro foro = new Foro();
                foro.setIdForo(rs.getInt("id_foro"));
                foro.setNombre(rs.getString("nombre"));
                foro.setDescripcion(rs.getString("descripcion"));
                foro.setOrigen(OrigenForo.valueOf(rs.getString("origen_foro")));
                foro.setIdCreador(rs.getInt("id_user"));
		foros.add(foro);
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
        return foros;
    }

    @Override
    public ArrayList<Foro> listarSuscritos(int idUser) {
        ArrayList<Foro> foros =  new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_SUSCRITOS}");
            cs.setInt("_iduser", idUser);
            rs = cs.executeQuery();
            while(rs.next()){
                Foro foro = new Foro();
                foro.setIdForo(rs.getInt("id_foro"));
                foro.setNombre(rs.getString("nombre"));
                foro.setDescripcion(rs.getString("descripcion"));
                foro.setOrigen(OrigenForo.valueOf(rs.getString("origen_foro")));
                foro.setIdCreador(rs.getInt("id_user"));
		foros.add(foro);
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
        return foros;
    }
    
}
