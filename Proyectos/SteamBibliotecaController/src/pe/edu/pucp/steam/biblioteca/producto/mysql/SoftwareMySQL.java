/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.SoftwareDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.Proveedor;
import pe.edu.pucp.steam.biblioteca.producto.model.Software;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class SoftwareMySQL implements SoftwareDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarSoftware(Software software) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_SOFTWARE"
                    + "(?,?,?,?,?,?,?,?,?,?)}");
            cs.registerOutParameter("_id_software",
                    java.sql.Types.INTEGER);
            cs.setInt("_fid_proveedor", software.getProveedor().getIdProveedor());
            cs.setString("_titulo", software.getTitulo());
            cs.setDate("_fecha_publicacion", new java.sql.Date(software.getFechaPublicacion().getTime()));
            cs.setDouble("_precio", software.getPrecio());
            cs.setString("_descripcion", software.getDescripcion());
            cs.setDouble("_espacio_disco", software.getEspacioDisco());
            cs.setBoolean("_activo", true);
            cs.setString("_requisitos", software.getRequisitos());
            cs.setString("_licencia", software.getLicencia());
            cs.executeUpdate();
            software.setIdProducto(cs.getInt("_id_software"));
            resultado = software.getIdProducto();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int actualizarSoftware(Software software) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_SOFTWARE"
                    + "(?,?,?,?,?,?,?,?,?,?)}");
            cs.setInt("_id_software", software.getIdProducto());
            cs.setInt("_fid_proveedor", software.getProveedor().getIdProveedor());
            cs.setString("_titulo", software.getTitulo());
            cs.setDate("_fecha_publicacion", new java.sql.Date(software.getFechaPublicacion().getTime()));
            cs.setDouble("_precio", software.getPrecio());
            cs.setString("_descripcion", software.getDescripcion());
            cs.setDouble("_espacio_disco", software.getEspacioDisco());
            cs.setBoolean("_activo", software.isActivo());
            cs.setString("_requisitos", software.getRequisitos());
            cs.setString("_licencia", software.getLicencia());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int eliminarSoftware(int idSoftware) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_SOFTWARE"
                    + "(?)}");
            cs.setInt("_id_producto", idSoftware);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public ArrayList<Software> listarSoftware() {
        ArrayList<Software> softwares = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_SOFTWARES}");
            rs = cs.executeQuery();
            while(rs.next()){
                Software software = new Software();
                Proveedor proveedor = new Proveedor();
                software.setIdProducto(rs.getInt("id_producto"));
                software.setTitulo(rs.getString("titulo"));
                software.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                software.setPrecio(rs.getDouble("precio"));
                software.setDescripcion(rs.getString("descripcion"));
                software.setEspacioDisco(rs.getDouble("espacio_disco"));
                software.setRequisitos(rs.getString("requisitos"));
                software.setLicencia(rs.getString("licencia"));
                proveedor.setIdProveedor(rs.getInt("id_proveedor"));
                proveedor.setRazonSocial(rs.getString("razon_social"));
                software.setProveedor(proveedor);
                software.setActivo(true);
                softwares.add(software);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return softwares;
    }

    @Override
    public Software buscarSoftware(int idSoftware) {
        Software software = new Software();
        Proveedor proveedor = new Proveedor();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_SOFTWARE(?)}");
            cs.setInt(1, idSoftware);
            rs = cs.executeQuery();
            rs.next();
            software.setIdProducto(rs.getInt("id_producto"));
            software.setTitulo(rs.getString("titulo"));
            software.setFechaPublicacion(rs.getDate("fecha_publicacion"));
            software.setPrecio(rs.getDouble("precio"));
            software.setDescripcion(rs.getString("descripcion"));
            software.setEspacioDisco(rs.getDouble("espacio_disco"));
            software.setRequisitos(rs.getString("requisitos"));
            software.setLicencia(rs.getString("licencia"));
            software.setActivo(rs.getBoolean("activo"));
            proveedor.setIdProveedor(rs.getInt("id_proveedor"));
            proveedor.setRazonSocial(rs.getString("razon_social"));
            software.setProveedor(proveedor);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return software;
    }

}
