/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.mysql;

import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.steam.comunidad.dao.HiloDAO;
import pe.edu.pucp.steam.comunidad.model.Hilo;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.CallableStatement;
import pe.edu.pucp.steam.comunidad.model.Subforo;
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
    public int insertarHilo(Hilo hilo) {
        int resultado=0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_HILO"
                    + "(?,?,?,?,?, ?, ?)}");
            cs.registerOutParameter("_id_hilo",
                    java.sql.Types.INTEGER);
            cs.setInt("_id_subforo", hilo.getSubforo().getIdSubforo());
            cs.setInt("_id_usuario", hilo.getIdCreador());
            cs.setBoolean("_fijado",hilo.isFijado());
            cs.setDate("_fecha_creacion", new java.sql.Date((new Date()).getTime()));
            cs.setDate("_fecha_modificacion",new java.sql.Date((new Date()).getTime()));
            cs.setString("_imagen_url", hilo.getImagenUrl());
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
    public ArrayList<Hilo> mostrarHilosSubforo(Subforo subforo) {
         ArrayList<Hilo> hilos =  new ArrayList<>();
         
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call MOSTRAR_HILOS_POR_SUBFORO"
                    + "(?)}");
 
			cs.setInt("_id_subforo", subforo.getIdSubforo());
            rs = cs.executeQuery();
			while(rs.next()){
                Hilo hilo = new Hilo();
              
                                //boolean b = ((rs.getInt("fijado")) != 0);
				hilo.setIdHilo(rs.getInt("id_hilo"));
				//hilo.setFijado(b);
                                hilo.setNroMensajes(rs.getInt("nro_mensajes"));
                                hilo.setImagenUrl(rs.getString("imagen_url"));
                                hilo.setFechaCreacion(rs.getDate("fecha_creacion"));
                                hilo.setFechaModificacion(rs.getDate("fecha_modificacion"));
                                hilo.setIdCreador(rs.getInt("fid_creador"));
                                hilo.setNombre(rs.getString("nombre_perfil"));
                                hilo.setFotoPerfil(rs.getString("foto_url"));
				hilos.add(hilo);
                
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
        return hilos;   
    }

    @Override
    public int editarHilo(Hilo hilo) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call EDITAR_HILO"
                    + "(?,?,?,?)}");
 
			cs.setInt("_id_hilo", hilo.getIdHilo());
                        cs.setInt("_id_subforo",hilo.getSubforo().getIdSubforo());
            //cs.setString("_fijado", hilo.getFijado());
            cs.setDate("_fecha_modificacion", new java.sql.Date(
                    hilo.getFechaModificacion().getTime()));
            cs.setString("_imagen_url", hilo.getImagenUrl());
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
    public int eliminarHilo(Hilo hilo) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call DESACTIVAR_HILO"
                    + "(?)}");
 
			cs.setInt("_id_hilo", hilo.getIdHilo());
                       
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
