/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import pe.edu.pucp.steam.biblioteca.producto.dao.ProductoEtiquetaDAO;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author Diego
 */
public class ProductoEtiquetaMySQL implements ProductoEtiquetaDAO{
    
    
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int agregarProductoEtiqueta(int idProducto, int idEtiqueta) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_PRODUCTOETIQUETA"
                    + "(?,?)}");
            cs.setInt("_fid_producto", idProducto);
            cs.setInt("_fid_etiqueta", idEtiqueta);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int eliminarProductoEtiqueta(int idProducto, int idEtiqueta) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_PRODUCTOETIQUETA"
                    + "(?,?)}");
            cs.setInt("_fid_producto", idProducto);
            cs.setInt("_fid_etiqueta", idEtiqueta);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }
}
