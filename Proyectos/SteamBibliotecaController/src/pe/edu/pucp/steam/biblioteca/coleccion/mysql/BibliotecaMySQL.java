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
    public int insertarBiblioteca(Biblioteca biblioteca) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_BIBLIOTECA"
                    + "(?)}");
            cs.setInt("_id_biblioteca", biblioteca.getIdBiblioteca());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public Biblioteca buscarBiblioteca(int idUser) {
        Biblioteca biblioteca = new Biblioteca();
        biblioteca.setIdBiblioteca(-1);
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_BIBLIOTECA"
                    + "(?)}");
            cs.setInt("_id_biblioteca", biblioteca.getIdBiblioteca());
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

    @Override
    public ArrayList<ProductoAdquirido> listarObjetos(Biblioteca biblioteca) {
        ProductoAdquiridoDAO productoAdquiridoDAO = new ProductoAdquiridoMySQL();
        return productoAdquiridoDAO.listarProductosAdquiridos(biblioteca);
    }

    @Override
    public ArrayList<Coleccion> listarColeccion(int idBiblioteca) {
        ColeccionDAO coleccionDAO = new ColeccionMySQL();
        return coleccionDAO.listarColecciones(idBiblioteca);
    }
    
}