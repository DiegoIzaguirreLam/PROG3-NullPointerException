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
import pe.edu.pucp.steam.biblioteca.controller.dao.SoftwareDAO;
import pe.edu.pucp.steam.biblioteca.model.producto.Software;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class SoftwareMySQL implements SoftwareDAO{
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet st;
    
    @Override
    public int insertarSoftware(Software software) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_SOFTWARE"
                    + "(?,?,?,?,?,?,?,?,?)}");
            cs.registerOutParameter("_id_software",
                    java.sql.Types.INTEGER);
            cs.setInt("_fid_proveedor", software.getProveedor().getIdProveedor());
            cs.setString("_titulo", software.getTitulo());
            cs.setDouble("_precio", software.getPrecio());
            cs.setString("_descripcion", software.getDescripcion());
            cs.setDouble("_espacio_disco", software.getEspacioDisco());
            cs.setBoolean("_oculto", software.isOculto());
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
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int eliminarSoftware(Software software) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Software> listarSoftware() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Software buscarSoftware(int software) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
