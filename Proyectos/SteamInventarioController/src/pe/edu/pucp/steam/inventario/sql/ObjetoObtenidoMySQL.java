<<<<<<< HEAD
package pe.edu.pucp.steam.inventario.sql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.inventario.dao.ObjetoObtenidoDAO;
import pe.edu.pucp.steam.inventario.model.ObjetoObtenido;

public class ObjetoObtenidoMySQL implements ObjetoObtenidoDAO {
    
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarObjeto(ObjetoObtenido objetoObtenido) {
        int resultado = 0;
        
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{CALL INSERTAR_OBJETO_OBTENIDO(?, ?, ?, ?)}");
            cs.registerOutParameter("_id_objeto", java.sql.Types.INTEGER);
            cs.setDate("_fecha_obtencion",
                       new java.sql.Date(
                               objetoObtenido.getFechaObtencion().getTime()));
            cs.setInt("_fid_activo", 1);
            cs.setInt("_fid_objeto", objetoObtenido.getObjeto().getIdObjeto());
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

import java.util.ArrayList;
import pe.edu.pucp.steam.inventario.dao.ObjetoObtenidoDAO;
import pe.edu.pucp.steam.inventario.model.ObjetoObtenido;

/**
 *
 * @author piero
 */
public class ObjetoObtenidoMySQL implements ObjetoObtenidoDAO{

    @Override
    public int obtenerObjeto(ObjetoObtenido objetoObtenido) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
    }

    @Override
    public ArrayList<ObjetoObtenido> listarObtenidos(int idUsuario) {
<<<<<<< HEAD
        
        ArrayList<ObjetoObtenido> objetos = new ArrayList<>();
        
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{CALL LISTAR_OBJETOS_OBTENIDOS(?)}");
            cs.setInt("_id_usuario", idUsuario);
            rs = cs.executeQuery();
            
            while (rs.next())
                objetos.add(new ObjetoObtenido(idUsuario,
                        rs.getDate("fecha_obtencion"), null));
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        }
        
        return objetos;
    }
}
=======
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int eliminarObjeto(ObjetoObtenido objetoObtenido) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
