/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.controller.sql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.controller.dao.BibliotecaDAO;
import pe.edu.pucp.steam.biblioteca.controller.dao.ProductoAdquiridoDAO;
import pe.edu.pucp.steam.biblioteca.controller.dao.ProductoDAO;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class ProductoAdquiridoMySQL implements ProductoAdquiridoDAO{
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarProducto(ProductoAdquirido producto) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_PRODUCTOADQUIRIDO"
                    + "(?,?,?)}");
            cs.registerOutParameter("_id_producto_adquirido",
                    java.sql.Types.INTEGER);
            cs.setInt("_fid_biblioteca", producto.getBiblioteca().getIdBiblioteca());
            cs.setInt("_fid_producto", producto.getProducto().getIdProducto());
            cs.executeUpdate();
            producto.setIdProductoAdquirido(cs.getInt("_id_producto_adquirido"));
            resultado = producto.getIdProductoAdquirido();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int actualizarProducto(ProductoAdquirido producto) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_PRODUCTOADQUIRIDO"
                    + "(?,?,?,?,?,?,?,?)}");
            cs.setInt("_id_producto_adquirido", producto.getIdProductoAdquirido());
            cs.setDate("_fecha_adquisicion", new java.sql.Date(producto.getFechaAdquisicion().getTime()));
            cs.setDate("_fecha_ejecucion",new java.sql.Date(producto.getFechaEjecutado().getTime()));
            cs.setTime("_tiempo_uso", java.sql.Time.valueOf(producto.getTiempoUso()));
            cs.setBoolean("_actualizado", producto.isActualizado());
            cs.setBoolean("_oculto", producto.isOculto());
            cs.setInt("_fid_biblioteca", producto.getBiblioteca().getIdBiblioteca());
            cs.setInt("_fid_producto", producto.getProducto().getIdProducto());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int eliminarProducto(int idProducto) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_PRODUCTOADQUIRIDO"
                    + "(?)}");
            cs.setInt("_id_producto_adquirido", idProducto);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }
    
    
    @Override
    public ArrayList<ProductoAdquirido> listarProductosAdquiridos() {
        ArrayList<ProductoAdquirido> productosAdquiridos = new ArrayList<>();
        try{
            int idBiblioteca, idProducto;
            BibliotecaDAO bibliotecaDAO = new BibliotecaMySQL();
            ProductoDAO productoDAO = new ProductoMySQL();
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PRODUCTOSADQUIRIDOS}");
            rs = cs.executeQuery();
            while(rs.next()){
                ProductoAdquirido producto = new ProductoAdquirido();
                producto.setIdProductoAdquirido(rs.getInt("id_producto_adquirido"));
                producto.setFechaAdquisicion(rs.getDate("fecha_adquisicion"));
                producto.setFechaEjecutado(rs.getDate("fecha_ejecucion"));
                producto.setTiempoUso(rs.getTime("tiempo_uso").toLocalTime());
                producto.setActualizado(rs.getBoolean("actualizado"));
                idBiblioteca = rs.getInt("fid_biblioteca");
                idProducto = rs.getInt("fid_producto");
                producto.setBiblioteca(bibliotecaDAO.buscarBiblioteca(idBiblioteca));
                producto.setProducto(productoDAO.buscarProducto(idProducto));
                productosAdquiridos.add(producto);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return productosAdquiridos;
    }

  
}
