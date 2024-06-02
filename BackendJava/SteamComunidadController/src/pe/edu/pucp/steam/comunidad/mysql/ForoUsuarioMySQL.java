/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.dao.ForoUsuarioDAO;
import pe.edu.pucp.steam.comunidad.model.Foro;
import pe.edu.pucp.steam.comunidad.model.OrigenForo;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author GAMER
 */
public class ForoUsuarioMySQL implements ForoUsuarioDAO{
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int crearRelacion(int idForo, int idUsuario) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_RELACION_FORO(?, ?)}");
            cs.setInt("_fid_foro", idForo);
            cs.setInt("_fid_usuario", idUsuario);
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
    public int suscribirRelacion(int idForo, int idUsuario) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call SUSCRIBIR_RELACION(?, ?)}");
            cs.setInt("_fid_foro", idForo);
            cs.setInt("_fid_usuario", idUsuario);
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
    public int eliminarRelacion(int idForo, int idUsuario) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_RELACION_FORO(?, ?)}");
            cs.setInt("_fid_foro", idForo);
            cs.setInt("_fid_usuario", idUsuario);
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
    public ArrayList<Foro> listarSuscritos(int idUsuario) {
        ArrayList<Foro> foros =  new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_FOROS(?)}");
            cs.setInt("_fid_usuario", idUsuario);
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
    public int desuscribirRelacion(int idForo, int idUsuario) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call DESUSCRIBIR_RELACION_FORO(?, ?)}");
            cs.setInt("_fid_foro", idForo);
            cs.setInt("_fid_usuario", idUsuario);
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
    
}
