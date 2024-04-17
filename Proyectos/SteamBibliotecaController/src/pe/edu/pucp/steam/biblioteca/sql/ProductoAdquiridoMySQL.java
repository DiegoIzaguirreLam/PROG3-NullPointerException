/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.sql;

<<<<<<< HEAD
import pe.edu.pucp.steam.biblioteca.dao.ProductoAdquiridoDAO;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;
=======
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.dao.BibliotecaDAO;
import pe.edu.pucp.steam.biblioteca.dao.ProductoAdquiridoDAO;
import pe.edu.pucp.steam.biblioteca.dao.ProductoDAO;
import pe.edu.pucp.steam.biblioteca.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49

/**
 *
 * @author piero
 */
public class ProductoAdquiridoMySQL implements ProductoAdquiridoDAO{
<<<<<<< HEAD

    @Override
    public int agregarProducto(ProductoAdquirido producto) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int ocultarProducto(ProductoAdquirido producto) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
=======
    private Connection con;
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
    public ArrayList<ProductoAdquirido> listarProductosAdquiridos(Biblioteca biblioteca) {
        ArrayList<ProductoAdquirido> productosAdquiridos = new ArrayList<>();
        try{
            int idProducto;
            ProductoDAO productoDAO = new ProductoMySQL();
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PRODUCTOSADQUIRIDOS(?)}");
            cs.setInt("_id_biblioteca", biblioteca.getIdBiblioteca());
            rs = cs.executeQuery();
            while(rs.next()){
                ProductoAdquirido producto = new ProductoAdquirido();
                producto.setIdProductoAdquirido(rs.getInt("id_producto_adquirido"));
                producto.setFechaAdquisicion(rs.getDate("fecha_adquisicion"));
                producto.setFechaEjecutado(rs.getDate("fecha_ejecucion"));
                producto.setTiempoUso(rs.getTime("tiempo_uso").toLocalTime());
                producto.setActualizado(rs.getBoolean("actualizado"));
                producto.setBiblioteca(biblioteca);
                idProducto = rs.getInt("fid_producto");
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

    @Override
    public ProductoAdquirido buscarProductoAdquirido(int idProductoAdquirido) {
        ProductoAdquirido producto = new ProductoAdquirido();
        try{
            int idBiblioteca, idProducto;
            BibliotecaDAO bibliotecaDAO = new BibliotecaMySQL();
            ProductoDAO productoDAO = new ProductoMySQL();
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_PRODUCTOADQUIRIDO(?)}");
            cs.setInt("_id_producto_adquirido", idProductoAdquirido);
            rs = cs.executeQuery();
            if(rs.next()){
                producto.setIdProductoAdquirido(rs.getInt("id_producto_adquirido"));
                producto.setFechaAdquisicion(rs.getDate("fecha_adquisicion"));
                producto.setFechaEjecutado(rs.getDate("fecha_ejecucion"));
                producto.setTiempoUso(rs.getTime("tiempo_uso").toLocalTime());
                producto.setActualizado(rs.getBoolean("actualizado"));
                idBiblioteca = rs.getInt("fid_biblioteca");
                idProducto = rs.getInt("fid_producto");
                producto.setBiblioteca(bibliotecaDAO.buscarBiblioteca(idBiblioteca));
                producto.setProducto(productoDAO.buscarProducto(idProducto));
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return producto;
    }

  
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
}
