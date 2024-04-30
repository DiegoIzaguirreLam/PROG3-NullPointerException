/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.mysql;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import pe.edu.pucp.steam.biblioteca.producto.dao.BandaSonoraDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.BandaSonora;
import pe.edu.pucp.steam.biblioteca.producto.model.Proveedor;
import pe.edu.pucp.steam.dbmanager.config.DBManager;


/**
 *
 * @author piero
 */
public class BandaSonoraMySQL implements BandaSonoraDAO{
    
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarBandaSonora(BandaSonora bandaSonora) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_BANDASONORA"
                    + "(?,?,?,?,?,?,?,?,?,?,?)}");
            cs.registerOutParameter("_id_banda_sonora",
                    java.sql.Types.INTEGER);
            cs.setInt("_fid_proveedor", bandaSonora.getProveedor().getIdProveedor());
            cs.setString("_titulo", bandaSonora.getTitulo());
            cs.setDate("_fecha_publicacion", new java.sql.Date(bandaSonora.getFechaPublicacion().getTime()));
            cs.setDouble("_precio", bandaSonora.getPrecio());
            cs.setString("_descripcion", bandaSonora.getDescripcion());
            cs.setDouble("_espacio_disco", bandaSonora.getEspacioDisco());
            cs.setBoolean("_activo", true);
            cs.setString("_artista", bandaSonora.getArtista());
            cs.setString("_compositor", bandaSonora.getCompositor());
            cs.setTime("_duracion", java.sql.Time.valueOf(bandaSonora.getDuracion()));
            cs.executeUpdate();
            bandaSonora.setIdProducto(cs.getInt("_id_banda_sonora"));
            resultado = bandaSonora.getIdProducto();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int actualizarBandaSonora(BandaSonora bandaSonora) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_BANDASONORA"
                    + "(?,?,?,?,?,?,?,?,?,?,?)}");
            cs.setInt("_id_banda_sonora", bandaSonora.getIdProducto());
            cs.setInt("_fid_proveedor", bandaSonora.getProveedor().getIdProveedor());
            cs.setString("_titulo", bandaSonora.getTitulo());
            cs.setDate("_fecha_publicacion", new java.sql.Date(bandaSonora.getFechaPublicacion().getTime()));
            cs.setDouble("_precio", bandaSonora.getPrecio());
            cs.setString("_descripcion", bandaSonora.getDescripcion());
            cs.setDouble("_espacio_disco", bandaSonora.getEspacioDisco());
            cs.setBoolean("_activo", bandaSonora.isActivo());
            cs.setString("_artista", bandaSonora.getArtista());
            cs.setString("_compositor", bandaSonora.getCompositor());
            cs.setTime("_duracion", java.sql.Time.valueOf(bandaSonora.getDuracion()));
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int eliminarBandaSonora(int idBandaSonora) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_BANDASONORA"
                    + "(?)}");
            cs.setInt("_id_producto", idBandaSonora);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public ArrayList<BandaSonora> listarBandaSonoras() {
        ArrayList<BandaSonora> bandasSonoras = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_BANDASSONORAS}");
            rs = cs.executeQuery();
            while(rs.next()){
                BandaSonora bandaSonora = new BandaSonora();
                Proveedor proveedor = new Proveedor();
                bandaSonora.setIdProducto(rs.getInt("id_producto"));
                bandaSonora.setTitulo(rs.getString("titulo"));
                bandaSonora.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                bandaSonora.setPrecio(rs.getDouble("precio"));
                bandaSonora.setDescripcion(rs.getString("descripcion"));
                bandaSonora.setEspacioDisco(rs.getDouble("espacio_disco"));
                bandaSonora.setArtista(rs.getString("artista"));
                bandaSonora.setCompositor(rs.getString("compositor"));
                bandaSonora.setDuracion(rs.getTime("duracion").toLocalTime());
                proveedor.setIdProveedor(rs.getInt("id_proveedor"));
                proveedor.setRazonSocial(rs.getString("razon_social"));
                bandaSonora.setProveedor(proveedor);
                bandaSonora.setActivo(true);
                bandasSonoras.add(bandaSonora);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return bandasSonoras;
    }

    @Override
    public BandaSonora buscarBandaSonora(int idBandaSonora) {
        BandaSonora bandaSonora = new BandaSonora();
        Proveedor proveedor = new Proveedor();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_BANDASONORA(?)}");
            cs.setInt(1, idBandaSonora);
            rs = cs.executeQuery();
            rs.next();
            bandaSonora.setIdProducto(rs.getInt("id_producto"));
            bandaSonora.setTitulo(rs.getString("titulo"));
            bandaSonora.setFechaPublicacion(rs.getDate("fecha_publicacion"));
            bandaSonora.setPrecio(rs.getDouble("precio"));
            bandaSonora.setDescripcion(rs.getString("descripcion"));
            bandaSonora.setEspacioDisco(rs.getDouble("espacio_disco"));
            bandaSonora.setArtista(rs.getString("artista"));
            bandaSonora.setCompositor(rs.getString("compositor"));
            bandaSonora.setDuracion(rs.getTime("duracion").toLocalTime());
            bandaSonora.setActivo(rs.getBoolean("activo"));
            proveedor.setIdProveedor(rs.getInt("id_proveedor"));
            proveedor.setRazonSocial(rs.getString("razon_social"));
            bandaSonora.setActivo(true);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return bandaSonora;
    }

}



