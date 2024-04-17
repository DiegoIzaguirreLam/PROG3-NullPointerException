/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.sql;

<<<<<<< HEAD
import pe.edu.pucp.steam.biblioteca.dao.ProveedorDAO;
=======
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.dao.ProveedorDAO;
import pe.edu.pucp.steam.biblioteca.model.producto.Proveedor;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49

/**
 *
 * @author piero
 */
public class ProveedorMySQL implements ProveedorDAO{
<<<<<<< HEAD
=======
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarProveedor(Proveedor proveedor) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_PROVEEDOR"
                    + "(?,?)}");
            cs.registerOutParameter("_id_proveedor",
                    java.sql.Types.INTEGER);
            cs.setString("_razon_social", proveedor.getRazonSocial());
            cs.executeUpdate();
            proveedor.setIdProveedor(cs.getInt("_id_proveedor"));
            resultado = proveedor.getIdProveedor();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int actualizarProveedor(Proveedor proveedor) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_PROVEEDOR"
                    + "(?,?)}");
            cs.setInt("_id_proveedor", proveedor.getIdProveedor());
            cs.setString("_razon_social", proveedor.getRazonSocial());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int eliminarProveedor(int idProveedor) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_PROVEEDOR"
                    + "(?)}");
            cs.setInt("_id_proveedor", idProveedor);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public ArrayList<Proveedor> listarProveedores() {
        ArrayList<Proveedor> proveedores = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PROVEEDORES}");
            rs = cs.executeQuery();
            while(rs.next()){
                Proveedor proveedor = new Proveedor();
                proveedor.setIdProveedor(rs.getInt("id_proveedor"));
                proveedor.setRazonSocial(rs.getString("razon_social"));
                proveedores.add(proveedor);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return proveedores;
    }
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
    
}
