package pe.edu.pucp.steam.comunidad.mysql;

import pe.edu.pucp.steam.comunidad.dao.GestorSancionesDAO;
import pe.edu.pucp.steam.comunidad.model.GestorSanciones;
import java.sql.CallableStatement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

public class GestorSancionesMySQL implements GestorSancionesDAO{
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarGestor(GestorSanciones gestorSanciones) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_GESTOR"
                    + "(?,?,?,?,?,?,?,?,?)}");
            cs.registerOutParameter("_id_gestor",
                    java.sql.Types.INTEGER);
            cs.setInt("_id_usuario", gestorSanciones.getIdUsuario());
            cs.setInt("_contador_baneos",gestorSanciones.getContadorBaneos());
            cs.setInt("_contador_palabras",gestorSanciones.getContadorPalabras());
            cs.setInt("_max_faltas",gestorSanciones.getMaxFaltas());
            cs.setInt("_max_baneos",gestorSanciones.getMaxBaneos());
            cs.setInt("_cant_baneos",gestorSanciones.getCantBaneos());
            cs.setInt("_cant_faltas",gestorSanciones.getCantFaltas());
            cs.setDate("_fin_ban", new java.sql.Date(
                    gestorSanciones.getFechaFinBan().getTime()));
           
            cs.executeUpdate();
            gestorSanciones.setIdGestor(cs.getInt("_id_usuario"));
 
            resultado = gestorSanciones.getIdGestor();
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
    public int actualizarGestor(GestorSanciones gestorSanciones) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call EDITAR_GESTOR"
                    + "(?,?,?,?,?,?,?,?,?)}");
            
            cs.setInt("_id_usuario", gestorSanciones.getIdGestor());
            cs.setInt("_contador_baneos",gestorSanciones.getContadorBaneos());
            cs.setInt("_contador_palabras",gestorSanciones.getContadorPalabras());
            cs.setInt("_contador_faltas",gestorSanciones.getContadorFaltas());
            cs.setInt("_max_faltas",gestorSanciones.getMaxFaltas());
            cs.setInt("_max_baneos",gestorSanciones.getMaxBaneos());
            cs.setInt("_cant_baneos",gestorSanciones.getCantBaneos());
            cs.setInt("_cant_faltas",gestorSanciones.getCantFaltas());
            cs.setDate("_fin_ban", new java.sql.Date(
                    gestorSanciones.getFechaFinBan().getTime()));
           
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
    public GestorSanciones buscarGestor(int idUser) {
        GestorSanciones gestor = new GestorSanciones();
        try{
            
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return gestor;
    }
}
