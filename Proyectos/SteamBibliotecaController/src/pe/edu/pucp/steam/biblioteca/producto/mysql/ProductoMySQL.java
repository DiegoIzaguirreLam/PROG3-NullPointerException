/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import pe.edu.pucp.steam.biblioteca.producto.dao.BandaSonoraDAO;
import pe.edu.pucp.steam.biblioteca.producto.dao.JuegoDAO;
import pe.edu.pucp.steam.biblioteca.producto.dao.ProductoDAO;
import pe.edu.pucp.steam.biblioteca.producto.dao.SoftwareDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.BandaSonora;
import pe.edu.pucp.steam.biblioteca.producto.model.Juego;
import pe.edu.pucp.steam.biblioteca.producto.model.Producto;
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
    public Producto buscarProducto(int idProducto) {
        String tipo;
        Producto producto = new Juego();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PRODUCTOS}");
            rs = cs.executeQuery();
            rs.next();
            tipo = rs.getString("tipo_producto");
            if(tipo.compareTo("JUEGO")==0){
                ((Juego)producto).setRequisitosMinimos(rs.getString("requisitos_minimos"));
                ((Juego)producto).setRequisitosRecomendados(rs.getString("requisitos_recomendados"));
                ((Juego)producto).setMultijugador(rs.getBoolean("multijugador"));
            } else if(tipo.compareTo("BANDASONORA")==0){
                producto = new BandaSonora();
                ((BandaSonora)producto).setArtista(rs.getString("artista"));
                ((BandaSonora)producto).setCompositor(rs.getString("compositor"));
                ((BandaSonora)producto).setDuracion(rs.getTime("duracion").toLocalTime());
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
            producto.setActivo(rs.getBoolean("activo_producto"));
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        } finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return producto;
    }

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