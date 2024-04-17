/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.sql;

<<<<<<< HEAD
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.dao.BibliotecaDAO;
import pe.edu.pucp.steam.biblioteca.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.model.Coleccion;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;
=======
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.dao.BibliotecaDAO;
import pe.edu.pucp.steam.biblioteca.dao.ColeccionDAO;
import pe.edu.pucp.steam.biblioteca.dao.ProductoAdquiridoDAO;
import pe.edu.pucp.steam.biblioteca.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.model.Coleccion;
import pe.edu.pucp.steam.biblioteca.model.producto.ProductoAdquirido;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49

/**
 *
 * @author GAMER
 */
public class BibliotecaMySQL implements BibliotecaDAO{
<<<<<<< HEAD

    @Override
    public int crearBiblioteca(Biblioteca biblioteca) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
=======
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    @Override
    public int crearBiblioteca(Biblioteca biblioteca) {
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
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
    }

    @Override
    public Biblioteca buscarBiblioteca(int idUser) {
<<<<<<< HEAD
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int actualizarBiblioteca(Biblioteca biblioteca) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
=======
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
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
    }

    @Override
    public ArrayList<ProductoAdquirido> listarObjetos(Biblioteca biblioteca) {
<<<<<<< HEAD
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Coleccion> listarColeccion(Biblioteca biblioteca) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
=======
        ProductoAdquiridoDAO productoAdquiridoDAO = new ProductoAdquiridoMySQL();
        return productoAdquiridoDAO.listarProductosAdquiridos(biblioteca);
    }

    @Override
    public ArrayList<Coleccion> listarColeccion(int idBiblioteca) {
        ColeccionDAO coleccionDAO = new ColeccionMySQL();
        return coleccionDAO.listarColecciones(idBiblioteca);
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
    }
    
}
