package pe.edu.pucp.steam.comunidad.mysql;

import pe.edu.pucp.steam.comunidad.dao.GestorSancionesDAO;
import pe.edu.pucp.steam.comunidad.model.GestorSanciones;
import java.sql.CallableStatement;

import java.sql.Connection;
import java.sql.ResultSet;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

public class GestorSancionesMySQL implements GestorSancionesDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int actualizarGestor(GestorSanciones gestorSanciones) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call EDITAR_GESTOR"
                    + "(?,?,?,?,?,?,?,?,?)}");
            
            cs.setInt("_fid_usuario", gestorSanciones.getIdGestor());
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
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_GESTOR(?)}");
            cs.setInt("_fid_usuario", idUser);
            rs = cs.executeQuery();
            if(rs.next()){
                gestor.setIdGestor(rs.getInt("id_gestor"));
                gestor.setIdUsuario(rs.getInt("fid_usuario"));
                gestor.setFechaFinBan(rs.getDate("fin_ban"));
                gestor.setCantFaltas(rs.getInt("cant_faltas"));
                gestor.setCantBaneos(rs.getInt("cant_baneos"));
                gestor.setContadorFaltas(rs.getInt("contador_faltas"));
                gestor.setContadorPalabras(rs.getInt("contador_palabras"));
                gestor.setContadorBaneos(rs.getInt("contador_baneos"));
                gestor.setMaxFaltas(rs.getInt("max_faltas"));
                gestor.setMaxBaneos(rs.getInt("max_baneos"));
                gestor.setActivo(true);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{rs.close();}catch(Exception ex){System.out.println(ex.getMessage());}
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return gestor;
    }

    @Override
    public int asignarGestorUsuario(int uid_usuario) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_GESTOR"
                    + "(?,?,?,?,?,?,?,?,?)}");
            cs.registerOutParameter("_id_gestor",
                    java.sql.Types.INTEGER);
            cs.setInt("_fid_usuario", uid_usuario);
            cs.setInt("_contador_faltas",0);
            cs.setInt("_contador_baneos",0);
            cs.setInt("_contador_palabras",0);
            cs.setInt("_max_faltas",3);
            cs.setInt("_max_baneos",3);
            cs.setInt("_cant_baneos",0);
            cs.setInt("_cant_faltas",0);
            cs.executeUpdate();
            resultado = cs.getInt("_id_gestor");
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
