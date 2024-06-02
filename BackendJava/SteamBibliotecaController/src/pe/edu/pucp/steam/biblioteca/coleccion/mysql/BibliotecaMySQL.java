/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.coleccion.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.coleccion.dao.BibliotecaDAO;
import pe.edu.pucp.steam.biblioteca.coleccion.dao.ColeccionDAO;
import pe.edu.pucp.steam.biblioteca.producto.dao.ProductoAdquiridoDAO;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Coleccion;
import pe.edu.pucp.steam.biblioteca.producto.model.ProductoAdquirido;
import pe.edu.pucp.steam.biblioteca.producto.mysql.ProductoAdquiridoMySQL;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author GAMER
 */
public class BibliotecaMySQL implements BibliotecaDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    @Override
    public int asignarBibliotecaUsuario(int uid_usuario) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_BIBLIOTECA"
                    + "(?,?)}");
            cs.registerOutParameter("_id_biblioteca",
                    java.sql.Types.INTEGER);
            cs.setInt("_fid_usuario", uid_usuario);
            cs.executeUpdate();
            resultado = cs.getInt("_id_biblioteca");
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public Biblioteca buscarBibliotecaPorUID(int UID) {
        Biblioteca biblioteca = new Biblioteca();
        biblioteca.setIdBiblioteca(-1);
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_BIBLIOTECA"
                    + "(?)}");
            cs.setInt("_fid_usuario", UID);
            rs = cs.executeQuery();
            if(rs.next())
                biblioteca.setIdBiblioteca(rs.getInt("id_biblioteca"));
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return biblioteca;
    }

}