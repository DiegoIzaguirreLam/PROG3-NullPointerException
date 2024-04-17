<<<<<<< HEAD
=======
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
package pe.edu.pucp.steam.inventario.sql;

import pe.edu.pucp.steam.inventario.dao.InventarioDAO;
import pe.edu.pucp.steam.inventario.model.Inventario;
<<<<<<< HEAD
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
=======

/**
 *
 * @author GAMER
 */
public class InventarioMySQL implements InventarioDAO{

    @Override
    public int crearInventario(Inventario inventario) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
    }

    @Override
    public int actualizarInventario(Inventario inventario) {
<<<<<<< HEAD
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
=======
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
    }

    @Override
    public Inventario buscarInventario(int idUsuario) {
<<<<<<< HEAD
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
=======
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    
}
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
