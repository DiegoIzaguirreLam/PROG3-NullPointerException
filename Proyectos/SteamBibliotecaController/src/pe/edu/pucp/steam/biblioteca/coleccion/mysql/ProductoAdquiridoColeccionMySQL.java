/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.coleccion.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.coleccion.dao.ProductoAdquiridoColeccionDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.BandaSonora;
import pe.edu.pucp.steam.biblioteca.producto.model.Juego;
import pe.edu.pucp.steam.biblioteca.producto.model.Producto;
import pe.edu.pucp.steam.biblioteca.producto.model.ProductoAdquirido;
import pe.edu.pucp.steam.biblioteca.producto.model.Software;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author Diego
 */
public class ProductoAdquiridoColeccionMySQL implements ProductoAdquiridoColeccionDAO {
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarProductoAdquiridoAColeccion(int idColeccion, int idProductoAdquirido) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_PRODUCTOADQUIRIDO_COLECCION"
                    + "(?,?)}");
            cs.setInt("_fid_coleccion", idColeccion);
            cs.setInt("_fid_producto_adquirido", idProductoAdquirido);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int eliminarProductoAdquiridoDeColeccion(int idColeccion, int idProductoAdquirido) {
        int resultado = 0;
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_PRODUCTOADQUIRIDO_COLECCION"
                    + "(?,?)}");
            cs.setInt("_fid_coleccion", idColeccion);
            cs.setInt("_fid_producto_adquirido", idProductoAdquirido);
            resultado = cs.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try { con.close(); } catch (Exception ex) { System.out.println(ex.getMessage()); }
        }
        return resultado;
    }
    
    
}
