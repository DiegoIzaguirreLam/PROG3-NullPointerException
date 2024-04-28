/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.EtiquetaDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.Etiqueta;
import pe.edu.pucp.steam.biblioteca.producto.model.Producto;
import pe.edu.pucp.steam.biblioteca.producto.model.ProductoAdquirido;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class EtiquetaMySQL implements EtiquetaDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarEtiqueta(Etiqueta etiqueta) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_ETIQUETA"
                    + "(?,?)}");
            cs.registerOutParameter("_id_etiqueta",
                    java.sql.Types.INTEGER);
            cs.setString("_nombre", etiqueta.getNombre());
            cs.executeUpdate();
            etiqueta.setIdEtiqueta(cs.getInt("_id_etiqueta"));
            resultado = etiqueta.getIdEtiqueta();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int actualizarEtiqueta(Etiqueta etiqueta) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_ETIQUETA"
                    + "(?,?)}");
            cs.setInt("_id_etiqueta", etiqueta.getIdEtiqueta());
            cs.setString("_nombre", etiqueta.getNombre());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public ArrayList<Etiqueta> listarEtiquetas() {
        ArrayList<Etiqueta> etiquetas = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_ETIQUETAS}");
            rs = cs.executeQuery();
            while(rs.next()){
                Etiqueta etiqueta = new Etiqueta();
                etiqueta.setIdEtiqueta(rs.getInt("id_etiqueta"));
                etiqueta.setNombre(rs.getString("nombre"));
                etiquetas.add(etiqueta);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return etiquetas;
    }

    @Override
    public ArrayList<Producto> listarProductos(Etiqueta etiqueta) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<ProductoAdquirido> listarAdquiridos(Etiqueta etiqueta) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int eliminarEtiqueta(int idEtiqueta) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_ETIQUETA"
                    + "(?)}");
            cs.setInt("_id_etiqueta", idEtiqueta);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

}