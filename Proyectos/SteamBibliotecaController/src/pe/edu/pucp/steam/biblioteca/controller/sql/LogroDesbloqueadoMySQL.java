/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.controller.sql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import pe.edu.pucp.steam.biblioteca.controller.dao.LogroDesbloqueadoDAO;
import pe.edu.pucp.steam.biblioteca.model.producto.LogroDesbloqueado;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class LogroDesbloqueadoMySQL implements LogroDesbloqueadoDAO{
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;
    @Override
    public int insertarLogroDesbloqueado(LogroDesbloqueado logro) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_LOGRODESBLOQUEADO"
                    + "(?,?,?)}");
            cs.registerOutParameter("_id_logro_desbloqueado",
                    java.sql.Types.INTEGER);
            cs.setInt("fid_logro", logro.getLogro().getIdLogro());
            cs.setInt("fid_producto_adquirido", logro.getJuego().getIdProductoAdquirido());
            cs.executeUpdate();
            logro.setIdLogroDesbloqueado(cs.getInt("_id_logro_desbloqueado"));
            resultado = logro.getIdLogroDesbloqueado();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public LogroDesbloqueado buscarLogro(int idLogro) {
        LogroDesbloqueado logro = new LogroDesbloqueado();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_LOGRODESBLOQUEADO"
                    + "(?)}");
            cs.setInt("fid_logro", idLogro);
            rs = cs.executeQuery();
            if(rs.next()){
                logro.setIdLogroDesbloqueado(rs.getInt("id_logro_desbloqueado"));
                logro.setFechaDesbloqueo(rs.getDate("fecha_desbloqueo")); 
                logro.setJuego(juego);//TERMINAR DE DESARROLLAR
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return logro;
    }

    @Override
    public int eliminarLogro(LogroDesbloqueado logro) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
