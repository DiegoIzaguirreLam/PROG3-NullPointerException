/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.ProductoAdquiridoDAO;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.producto.model.BandaSonora;
import pe.edu.pucp.steam.biblioteca.producto.model.Juego;
import pe.edu.pucp.steam.biblioteca.producto.model.Producto;
import pe.edu.pucp.steam.biblioteca.producto.model.ProductoAdquirido;
import pe.edu.pucp.steam.biblioteca.producto.model.Proveedor;
import pe.edu.pucp.steam.biblioteca.producto.model.Software;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class ProductoAdquiridoMySQL implements ProductoAdquiridoDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarProductoAdquirido(ProductoAdquirido producto) {
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
    public int actualizarProductoAdquirido(ProductoAdquirido producto) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_PRODUCTOADQUIRIDO"
                    + "(?,?,?,?,?,?,?,?)}");
            cs.setInt("_id_producto_adquirido", producto.getIdProductoAdquirido());
            cs.setDate("_fecha_adquisicion", new java.sql.Date(producto.getFechaAdquisicion().getTime()));
            cs.setDate("_fecha_ejecucion",new java.sql.Date(producto.getFechaEjecutado().getTime()));
            cs.setTime("_tiempo_uso", new java.sql.Time(producto.getTiempoUso().getTime()));
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
    public int eliminarProductoAdquirido(int idProductoAdquirido) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_PRODUCTOADQUIRIDO"
                    + "(?)}");
            cs.setInt("_id_producto_adquirido", idProductoAdquirido);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }
    
    
    @Override
    public ArrayList<ProductoAdquirido> listarProductosAdquiridosPorIdBiblioteca(int idBiblioteca) {
        ArrayList<ProductoAdquirido> productosAdquiridos = new ArrayList<>();
        try{
            String tipo;
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PRODUCTOSADQUIRIDOS_X_ID_BIBLIOTECA(?)}");
            cs.setInt("_id_biblioteca", idBiblioteca);
            rs = cs.executeQuery();
            while(rs.next()){
                ProductoAdquirido productoAdquirido = new ProductoAdquirido();
                Producto producto = null;
                Proveedor proveedor = new Proveedor();
                Biblioteca biblioteca = new Biblioteca();
                
                productoAdquirido.setIdProductoAdquirido(rs.getInt("id_producto_adquirido"));
                productoAdquirido.setFechaAdquisicion(rs.getDate("fecha_adquisicion"));
                productoAdquirido.setFechaEjecutado(rs.getDate("fecha_ejecucion"));
                productoAdquirido.setTiempoUso(rs.getTime("tiempo_uso"));
                productoAdquirido.setActualizado(rs.getBoolean("actualizado"));
                productoAdquirido.setOculto(rs.getBoolean("oculto"));
                
                tipo = rs.getString("tipo_producto");
                if (tipo.compareTo("JUEGO") == 0) {
                    producto = new Juego();
                    ((Juego)producto).setRequisitosMinimos(rs.getString("requisitos_minimos"));
                    ((Juego)producto).setRequisitosRecomendados(rs.getString("requisitos_recomendados"));
                    ((Juego)producto).setMultijugador(rs.getBoolean("multijugador"));
                } else if (tipo.compareTo("BANDASONORA") == 0) {
                    producto = new BandaSonora();
                    ((BandaSonora)producto).setArtista(rs.getString("artista"));
                    ((BandaSonora)producto).setCompositor(rs.getString("compositor"));
                    ((BandaSonora)producto).setDuracion(rs.getTime("duracion"));
                } else if (tipo.compareTo("SOFTWARE") == 0) {
                    producto = new Software();
                    ((Software)producto).setRequisitos(rs.getString("requisitos"));
                    ((Software)producto).setLicencia(rs.getString("licencia"));
                }
                producto.setIdProducto(rs.getInt("id_producto"));
                producto.setTitulo(rs.getString("titulo"));
                producto.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setEspacioDisco(rs.getDouble("espacio_disco"));
                producto.setLogoUrl(rs.getString("logo_url"));
                producto.setPortadaUrl(rs.getString("portada_url"));
                producto.setActivo(true);

                proveedor.setIdProveedor(rs.getInt("id_proveedor"));
                proveedor.setRazonSocial(rs.getString("razon_social"));
                proveedor.setActivo(rs.getBoolean("proveedor_activo"));
                producto.setProveedor(proveedor);
                
                biblioteca.setIdBiblioteca(rs.getInt("id_biblioteca"));
                productoAdquirido.setBiblioteca(biblioteca);
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

    @Override
    public ProductoAdquirido buscarProductoAdquirido(int idProductoAdquirido) {
        ProductoAdquirido productoAdquirido = new ProductoAdquirido();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_PRODUCTOADQUIRIDO(?)}");
            cs.setInt("_id_producto_adquirido", idProductoAdquirido);
            rs = cs.executeQuery();
            if(rs.next()){
                String tipo;
                Producto producto = null;
                Proveedor proveedor = new Proveedor();
                Biblioteca biblioteca = new Biblioteca();
                
                productoAdquirido.setIdProductoAdquirido(rs.getInt("id_producto_adquirido"));
                productoAdquirido.setFechaAdquisicion(rs.getDate("fecha_adquisicion"));
                productoAdquirido.setFechaEjecutado(rs.getDate("fecha_ejecucion"));
                productoAdquirido.setTiempoUso(rs.getTime("tiempo_uso"));
                productoAdquirido.setActualizado(rs.getBoolean("actualizado"));
                productoAdquirido.setOculto(rs.getBoolean("oculto"));
                
                tipo = rs.getString("tipo_producto");
                if (tipo.compareTo("JUEGO") == 0) {
                    producto = new Juego();
                    ((Juego)producto).setRequisitosMinimos(rs.getString("requisitos_minimos"));
                    ((Juego)producto).setRequisitosRecomendados(rs.getString("requisitos_recomendados"));
                    ((Juego)producto).setMultijugador(rs.getBoolean("multijugador"));
                } else if (tipo.compareTo("BANDASONORA") == 0) {
                    producto = new BandaSonora();
                    ((BandaSonora)producto).setArtista(rs.getString("artista"));
                    ((BandaSonora)producto).setCompositor(rs.getString("compositor"));
                    ((BandaSonora)producto).setDuracion(rs.getTime("duracion"));
                } else if (tipo.compareTo("SOFTWARE") == 0) {
                    producto = new Software();
                    ((Software)producto).setRequisitos(rs.getString("requisitos"));
                    ((Software)producto).setLicencia(rs.getString("licencia"));
                }
                producto.setIdProducto(rs.getInt("id_producto"));
                producto.setTitulo(rs.getString("titulo"));
                producto.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setEspacioDisco(rs.getDouble("espacio_disco"));
                producto.setLogoUrl(rs.getString("logo_url"));
                producto.setPortadaUrl(rs.getString("portada_url"));
                producto.setActivo(true);

                proveedor.setIdProveedor(rs.getInt("id_proveedor"));
                proveedor.setRazonSocial(rs.getString("razon_social"));
                proveedor.setActivo(rs.getBoolean("proveedor_activo"));
                producto.setProveedor(proveedor);
                
                biblioteca.setIdBiblioteca(rs.getInt("id_biblioteca"));
                productoAdquirido.setBiblioteca(biblioteca);
                productoAdquirido.setProducto(producto);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return productoAdquirido;
    }

    @Override
    public ArrayList<ProductoAdquirido> listarProductosAdquiridosPorIdColeccion(int idColeccion) {
        ArrayList<ProductoAdquirido> productosAdquiridos = new ArrayList<>();
        try{
            String tipo;
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PRODUCTOSADQUIRIDOS_X_ID_COLECCION(?)}");
            cs.setInt("_id_coleccion", idColeccion);
            rs = cs.executeQuery();
            while(rs.next()){
                ProductoAdquirido productoAdquirido = new ProductoAdquirido();
                Producto producto = null;
                Proveedor proveedor = new Proveedor();
                Biblioteca biblioteca = new Biblioteca();
                
                productoAdquirido.setIdProductoAdquirido(rs.getInt("id_producto_adquirido"));
                productoAdquirido.setFechaAdquisicion(rs.getDate("fecha_adquisicion"));
                productoAdquirido.setFechaEjecutado(rs.getDate("fecha_ejecucion"));
                productoAdquirido.setTiempoUso(rs.getTime("tiempo_uso"));
                productoAdquirido.setActualizado(rs.getBoolean("actualizado"));
                productoAdquirido.setOculto(rs.getBoolean("oculto"));
                
                tipo = rs.getString("tipo_producto");
                if (tipo.compareTo("JUEGO") == 0) {
                    producto = new Juego();
                    ((Juego)producto).setRequisitosMinimos(rs.getString("requisitos_minimos"));
                    ((Juego)producto).setRequisitosRecomendados(rs.getString("requisitos_recomendados"));
                    ((Juego)producto).setMultijugador(rs.getBoolean("multijugador"));
                } else if (tipo.compareTo("BANDASONORA") == 0) {
                    producto = new BandaSonora();
                    ((BandaSonora)producto).setArtista(rs.getString("artista"));
                    ((BandaSonora)producto).setCompositor(rs.getString("compositor"));
                    ((BandaSonora)producto).setDuracion(rs.getTime("duracion"));
                } else if (tipo.compareTo("SOFTWARE") == 0) {
                    producto = new Software();
                    ((Software)producto).setRequisitos(rs.getString("requisitos"));
                    ((Software)producto).setLicencia(rs.getString("licencia"));
                }
                producto.setIdProducto(rs.getInt("id_producto"));
                producto.setTitulo(rs.getString("titulo"));
                producto.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setEspacioDisco(rs.getDouble("espacio_disco"));
                producto.setLogoUrl(rs.getString("logo_url"));
                producto.setPortadaUrl(rs.getString("portada_url"));
                producto.setActivo(true);

                proveedor.setIdProveedor(rs.getInt("id_proveedor"));
                proveedor.setRazonSocial(rs.getString("razon_social"));
                proveedor.setActivo(rs.getBoolean("proveedor_activo"));
                producto.setProveedor(proveedor);
                
                biblioteca.setIdBiblioteca(rs.getInt("id_biblioteca"));
                productoAdquirido.setBiblioteca(biblioteca);
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
