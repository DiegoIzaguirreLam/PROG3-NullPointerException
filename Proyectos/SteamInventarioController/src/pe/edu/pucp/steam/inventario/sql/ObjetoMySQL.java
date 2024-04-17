<<<<<<< HEAD
package pe.edu.pucp.steam.inventario.sql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.inventario.dao.ObjetoDAO;
import pe.edu.pucp.steam.inventario.model.Objeto;

public class ObjetoMySQL implements ObjetoDAO{
    
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int crearObjeto(Objeto objeto) {
        int resultado = 0;

        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{CALL INSERTAR_OBJETO(?, ?, ?)}");
            cs.registerOutParameter("_id_objeto", java.sql.Types.INTEGER);
            cs.setString("_nombre", objeto.getNombre());
            cs.setInt("_fid_juego", 0);
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
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.inventario.sql;

import pe.edu.pucp.steam.inventario.dao.ObjetoDAO;
import pe.edu.pucp.steam.inventario.model.Objeto;

/**
 *
 * @author piero
 */
public class ObjetoMySQL implements ObjetoDAO{

    @Override
    public int crearObjeto(Objeto objeto) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
    }

    @Override
    public int actualizarObjeto(Objeto objeto) {
<<<<<<< HEAD
        int resultado = 0;
        
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{CALL ACTUALIZAR_OBJETO(?, ?, ?)}");
            cs.setInt("_id_inventario", objeto.getIdObjeto());
            cs.setString("_nombre", objeto.getNombre());
            cs.setInt("_fid_juego", 0);
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
}
=======
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int eliminarObjeto(Objeto objeto) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int buscarObjeto(int idObjeto) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49