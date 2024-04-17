/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.controller.sql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.controller.dao.ColeccionDAO;
import pe.edu.pucp.steam.biblioteca.model.Coleccion;
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
                colecciones.add(coleccion);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return colecciones;
    }
    
}
