/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.producto.dao.LogroDAO;
import pe.edu.pucp.steam.biblioteca.producto.dao.LogroDesbloqueadoDAO;
import pe.edu.pucp.steam.biblioteca.producto.dao.ProductoAdquiridoDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.Logro;
import pe.edu.pucp.steam.biblioteca.producto.model.LogroDesbloqueado;
import pe.edu.pucp.steam.biblioteca.producto.model.ProductoAdquirido;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class LogroDesbloqueadoMySQL implements LogroDesbloqueadoDAO{
    private Connection con;
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
    public int actualizarLogroDesbloqueado(LogroDesbloqueado logro) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_LOGRODESBLOQUEADO"
                    + "(?,?)}");
            cs.setInt("_id_logro_desbloqueado", logro.getIdLogroDesbloqueado());
            cs.setDate("_fecha_desbloqueo", new java.sql.Date(logro.getFechaDesbloqueo().getTime()));
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }
    
    @Override
    public int eliminarLogroDesbloqueado(int idLogroDesbloqueado) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_LOGRODESBLOQUEADO"
                    + "(?)}");
            cs.setInt("fid_logro", idLogroDesbloqueado);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public ArrayList<LogroDesbloqueado> listarLogrosDesbloqueadosProductoAdquirido(int idProductoAdquirido) {
        ArrayList<LogroDesbloqueado> logrosDesbloqueados = new ArrayList<>(); 
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_LOGRODESBLOQUEADOPRODUCTO"
                    + "(?)}");
            cs.setInt("_id_producto_adquirido", idProductoAdquirido);
            rs = cs.executeQuery();
            while(rs.next()){
                LogroDesbloqueado logroDesbloqueado = new LogroDesbloqueado(); 
                Logro logro = new Logro();
                logroDesbloqueado.setIdLogroDesbloqueado(rs.getInt("id_logro_desbloqueado"));
                logroDesbloqueado.setFechaDesbloqueo(rs.getDate("fecha_desbloqueo")); 
                
                logro.setIdLogro(rs.getInt("id_logro"));
                logro.setNombre(rs.getString("nombre_logro"));
                logro.setDescripcion(rs.getString("descripcion_logro"));
                logroDesbloqueado.setLogro(logro);
                logroDesbloqueado.setJuego(null);
                logrosDesbloqueados.add(logroDesbloqueado);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return logrosDesbloqueados;
    }
}