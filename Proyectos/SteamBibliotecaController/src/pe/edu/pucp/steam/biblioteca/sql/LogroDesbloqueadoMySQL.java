/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.sql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.dao.LogroDAO;
import pe.edu.pucp.steam.biblioteca.dao.LogroDesbloqueadoDAO;
import pe.edu.pucp.steam.biblioteca.dao.ProductoAdquiridoDAO;
import pe.edu.pucp.steam.biblioteca.model.producto.LogroDesbloqueado;
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
    public ArrayList<LogroDesbloqueado> listarLogrosProductoAdquirido(int idProductoAdquirido) {
        ArrayList<LogroDesbloqueado> logrosDesbloqueados = new ArrayList<>(); 
        try{
            int fid_logro, fid_producto_adquirido;
            LogroDAO logroDAO = new LogroMySQL();
            ProductoAdquiridoDAO productoAdquiridoDAO = new ProductoAdquiridoMySQL();
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_LOGRODESBLOQUEADOPRODUCTO"
                    + "(?)}");
            cs.setInt("_id_producto_adquirido", idProductoAdquirido);
            rs = cs.executeQuery();
            while(rs.next()){
                LogroDesbloqueado logroDesbloqueado = new LogroDesbloqueado(); 
                logroDesbloqueado.setIdLogroDesbloqueado(rs.getInt("id_logro_desbloqueado"));
                logroDesbloqueado.setFechaDesbloqueo(rs.getDate("fecha_desbloqueo")); 
                fid_producto_adquirido = rs.getInt("fid_producto_adquirido");
                fid_logro = rs.getInt("fid_logro");
                logroDesbloqueado.setJuego(productoAdquiridoDAO.buscarProductoAdquirido(fid_producto_adquirido));
                logroDesbloqueado.setLogro(logroDAO.buscarLogro(fid_logro));
                logrosDesbloqueados.add(logroDesbloqueado);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return logrosDesbloqueados;
    }
    
    @Override
    public LogroDesbloqueado buscarLogro(int idLogroDesbloqueado) {
        LogroDesbloqueado logroDesbloqueado = new LogroDesbloqueado(); 
        logroDesbloqueado.setIdLogroDesbloqueado(-1);
        try{
            int fid_logro, fid_producto_adquirido;
            LogroDAO logroDAO = new LogroMySQL();
            ProductoAdquiridoDAO productoAdquiridoDAO = new ProductoAdquiridoMySQL();
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_LOGRODESBLOQUEADO"
                    + "(?)}");
            cs.setInt("fid_logro", idLogroDesbloqueado);
            rs = cs.executeQuery();
            if(rs.next()){
                logroDesbloqueado.setIdLogroDesbloqueado(rs.getInt("id_logro_desbloqueado"));
                logroDesbloqueado.setFechaDesbloqueo(rs.getDate("fecha_desbloqueo")); 
                fid_producto_adquirido = rs.getInt("fid_producto_adquirido");
                fid_logro = rs.getInt("fid_logro");
                logroDesbloqueado.setJuego(productoAdquiridoDAO.buscarProductoAdquirido(fid_producto_adquirido));
                logroDesbloqueado.setLogro(logroDAO.buscarLogro(fid_logro));
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return logroDesbloqueado;
    }

    @Override
    public int eliminarLogro(int idLogroDesbloqueado) {
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

    
    
}