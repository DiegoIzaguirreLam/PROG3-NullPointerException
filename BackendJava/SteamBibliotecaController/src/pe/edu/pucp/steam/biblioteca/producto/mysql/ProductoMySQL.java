/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.ProductoDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.BandaSonora;
import pe.edu.pucp.steam.biblioteca.producto.model.Etiqueta;
import pe.edu.pucp.steam.biblioteca.producto.model.Juego;
import pe.edu.pucp.steam.biblioteca.producto.model.Producto;
import pe.edu.pucp.steam.biblioteca.producto.model.Proveedor;
import pe.edu.pucp.steam.biblioteca.producto.model.Software;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class ProductoMySQL implements ProductoDAO {
    
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public Producto buscarProducto(int idProducto){
        String tipo;
        Producto producto = null;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_PRODUCTO}");
            cs.setInt("_id_producto", idProducto);
            rs = cs.executeQuery();
            if(rs.next()){
                tipo = rs.getString("tipo_producto");
                Proveedor proveedor = new Proveedor();
                if(tipo.compareTo("JUEGO")==0){
                    producto = new Juego();
                    ((Juego)producto).setRequisitosMinimos(rs.getString("requisitos_minimos"));
                    ((Juego)producto).setRequisitosRecomendados(rs.getString("requisitos_recomendados"));
                    ((Juego)producto).setMultijugador(rs.getBoolean("multijugador"));
                } else if(tipo.compareTo("BANDASONORA")==0){
                    producto = new BandaSonora();
                    ((BandaSonora)producto).setArtista(rs.getString("artista"));
                    ((BandaSonora)producto).setCompositor(rs.getString("compositor"));
                    ((BandaSonora)producto).setDuracion(rs.getTime("duracion"));
                } else if(tipo.compareTo("SOFTWARE")==0){
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
            }
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        } finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return producto;
    }
    
    @Override
    public ArrayList<Producto> listarProductos() {
        String tipo;
        ArrayList<Producto> productos = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PRODUCTOS}");
            rs = cs.executeQuery();
            while(rs.next()){
                tipo = rs.getString("tipo_producto");
                Producto producto = null;
                Proveedor proveedor = new Proveedor();
                if(tipo.compareTo("JUEGO")==0){
                    producto = new Juego();
                    ((Juego)producto).setRequisitosMinimos(rs.getString("requisitos_minimos"));
                    ((Juego)producto).setRequisitosRecomendados(rs.getString("requisitos_recomendados"));
                    ((Juego)producto).setMultijugador(rs.getBoolean("multijugador"));
                } else if(tipo.compareTo("BANDASONORA")==0){
                    producto = new BandaSonora();
                    ((BandaSonora)producto).setArtista(rs.getString("artista"));
                    ((BandaSonora)producto).setCompositor(rs.getString("compositor"));
                    ((BandaSonora)producto).setDuracion(rs.getTime("duracion"));
                } else if(tipo.compareTo("SOFTWARE")==0){
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
                productos.add(producto);
            }
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        } finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return productos;
    }

    @Override
    public ArrayList<Producto> listarProductosPorEtiqueta(Etiqueta etiqueta) {
        String tipo;
        ArrayList<Producto> productos = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PRODUCTOS_X_ETIQUETA(?)}");
            cs.setInt("_id_etiqueta", etiqueta.getIdEtiqueta());
            rs = cs.executeQuery();
            while(rs.next()){
                tipo = rs.getString("tipo_producto");
                Producto producto = null;
                Proveedor proveedor = new Proveedor();
                if(tipo.compareTo("JUEGO")==0){
                    producto = new Juego();
                    ((Juego)producto).setRequisitosMinimos(rs.getString("requisitos_minimos"));
                    ((Juego)producto).setRequisitosRecomendados(rs.getString("requisitos_recomendados"));
                    ((Juego)producto).setMultijugador(rs.getBoolean("multijugador"));
                } else if(tipo.compareTo("BANDASONORA")==0){
                    producto = new BandaSonora();
                    ((BandaSonora)producto).setArtista(rs.getString("artista"));
                    ((BandaSonora)producto).setCompositor(rs.getString("compositor"));
                    ((BandaSonora)producto).setDuracion(rs.getTime("duracion"));
                } else if(tipo.compareTo("SOFTWARE")==0){
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
                productos.add(producto);
            }
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        } finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return productos;
    }

    @Override
    public ArrayList<Producto> listarProductosPorTituloDesarrollador(String nombre) {
        String tipo;
        ArrayList<Producto> productos = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PRODUCTOS_X_TITULO_DESARROLLADOR(?)}");
            cs.setString("_nombre", nombre);
            rs = cs.executeQuery();
            while(rs.next()){
                tipo = rs.getString("tipo_producto");
                Producto producto = null;
                Proveedor proveedor = new Proveedor();
                if(tipo.compareTo("JUEGO")==0){
                    producto = new Juego();
                    ((Juego)producto).setRequisitosMinimos(rs.getString("requisitos_minimos"));
                    ((Juego)producto).setRequisitosRecomendados(rs.getString("requisitos_recomendados"));
                    ((Juego)producto).setMultijugador(rs.getBoolean("multijugador"));
                } else if(tipo.compareTo("BANDASONORA")==0){
                    producto = new BandaSonora();
                    ((BandaSonora)producto).setArtista(rs.getString("artista"));
                    ((BandaSonora)producto).setCompositor(rs.getString("compositor"));
                    ((BandaSonora)producto).setDuracion(rs.getTime("duracion"));
                } else if(tipo.compareTo("SOFTWARE")==0){
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
                productos.add(producto);
            }
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        } finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return productos;
    }

    @Override
    public ArrayList<Integer> listarIdProductosDestacados() {
        ArrayList<Integer> idDestacados = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PRODUCTOS_DESTACADOS}");
            rs = cs.executeQuery();
            while(rs.next()){
                Integer id = rs.getInt("fid_producto");
                idDestacados.add(id);
            }
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        } finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return idDestacados;
    }
    
}