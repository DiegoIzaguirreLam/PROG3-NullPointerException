/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.coleccion.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.coleccion.dao.ColeccionDAO;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Coleccion;
import pe.edu.pucp.steam.biblioteca.producto.model.BandaSonora;
import pe.edu.pucp.steam.biblioteca.producto.model.Juego;
import pe.edu.pucp.steam.biblioteca.producto.model.Producto;
import pe.edu.pucp.steam.biblioteca.producto.model.ProductoAdquirido;
import pe.edu.pucp.steam.biblioteca.producto.model.Software;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class ColeccionMySQL implements ColeccionDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int insertarColeccion(Coleccion coleccion) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_COLECCION"
                    + "(?,?,?)}");
            cs.registerOutParameter("_id_coleccion",
                    java.sql.Types.INTEGER);
            cs.setString("_nombre", coleccion.getNombre());
            cs.setInt("_fid_biblioteca", coleccion.getBiblioteca().getIdBiblioteca());
            cs.executeUpdate();
            coleccion.setIdColeccion(cs.getInt("_id_proveedor"));
            resultado = coleccion.getIdColeccion();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int actualizarColeccion(Coleccion coleccion) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_COLECCION"
                    + "(?,?,?)}");
            cs.setInt("_id_coleccion", coleccion.getIdColeccion());
            cs.setString("_nombre", coleccion.getNombre());
            cs.setInt("_fid_biblioteca", coleccion.getBiblioteca().getIdBiblioteca());
            cs.executeUpdate();
            coleccion.setIdColeccion(cs.getInt("_id_proveedor"));
            resultado = coleccion.getIdColeccion();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int eliminarColeccion(int idColeccion) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_COLECCION"
                    + "(?)}");
            cs.setInt("_id_coleccion", idColeccion);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public ArrayList<Coleccion> listarColecciones(int idBiblioteca) {
        ArrayList<Coleccion> colecciones = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_COLECCIONES(?)}");
            cs.setInt("_fid_biblioteca", idBiblioteca);
            rs = cs.executeQuery();
            while(rs.next()){
                Coleccion coleccion = new Coleccion();
                coleccion.setIdColeccion(rs.getInt("id_coleccion"));
                coleccion.setNombre(rs.getString("nombre"));// no devuelve los productos
                coleccion.setActivo(true);
                colecciones.add(coleccion);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return colecciones;
    }

    @Override
    public ArrayList<ProductoAdquirido> listarProductosAdquiridos(int idColeccion) {
        ArrayList<ProductoAdquirido> productosAdquiridos = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PRODUCTOSADQUIRIDOS_COLECCION(?)}");
            cs.setInt("_fid_coleccion", idColeccion);
            rs = cs.executeQuery();
            String tipo;
            while(rs.next()){
                Producto producto;
                tipo = rs.getString("tipo_producto");
                if(tipo.compareTo("JUEGO")==0){
                    producto = new Juego();
                } else if(tipo.compareTo("BANDASONORA")==0){
                    producto = new BandaSonora();
                } else{
                    producto = new Software();
                }
                producto.setTitulo(rs.getString("titulo_producto"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setLogoUrl(rs.getString("logo_url"));
                producto.setPortadaUrl(rs.getString("portada_url"));
                ProductoAdquirido productoAdquirido = new ProductoAdquirido();
                productoAdquirido.setFechaEjecutado(rs.getDate("fecha_ejecucion"));
                productoAdquirido.setTiempoUso(rs.getTime("tiempo_uso").toLocalTime());
                productoAdquirido.setActualizado(rs.getBoolean("actualizado"));// no devuelve los productos
                productoAdquirido.setActivo(true);
                productoAdquirido.setProducto(producto);
                productosAdquiridos.add(productoAdquirido);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return productosAdquiridos;
    }
    
}