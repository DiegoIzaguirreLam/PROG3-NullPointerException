package pe.edu.pucp.steam.inventario.sql;

import pe.edu.pucp.steam.inventario.dao.InventarioDAO;
import pe.edu.pucp.steam.inventario.model.Inventario;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.CallableStatement;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

public class InventarioMySQL implements InventarioDAO{
    
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int crearInventario(Inventario inventario) {
        int resultado = 0;
        
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{CALL INSERTAR_INVENTARIO(?, ?)}");
            cs.setInt("_id_inventario", inventario.getIdInventario());
            cs.setInt("_cantidad_gemas", inventario.getCantGemas());
            resultado = cs.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        }
        
        return resultado;
    }

    @Override
    public int actualizarInventario(Inventario inventario) {
        int resultado = 0;
        
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{CALL ACTUALIZAR_INVENTARIO(?, ?)}");
            cs.setInt("_id_inventario", inventario.getIdInventario());
            cs.setInt("_cantidad_gemas", inventario.getCantGemas());
            resultado = cs.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        }
        
        return resultado;
    }

    @Override
    public Inventario buscarInventario(int idUsuario) {
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{CALL BUSCAR_INVENTARIO(?)}");
            cs.setInt("_id_inventario", idUsuario);
            rs = cs.executeQuery();
            rs.next();
            // null porque Inventario -> InventarioActivo no es navegable
            return new Inventario(rs.getInt("cantidad_gemas"), null);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        }
        
        return null;
    }
}