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
import pe.edu.pucp.steam.biblioteca.controller.dao.BandaSonoraDAO;
import pe.edu.pucp.steam.biblioteca.controller.dao.JuegoDAO;
import pe.edu.pucp.steam.biblioteca.controller.dao.ProductoDAO;
import pe.edu.pucp.steam.biblioteca.controller.dao.SoftwareDAO;
import pe.edu.pucp.steam.biblioteca.model.producto.BandaSonora;
import pe.edu.pucp.steam.biblioteca.model.producto.Juego;
import pe.edu.pucp.steam.biblioteca.model.producto.Producto;
import pe.edu.pucp.steam.biblioteca.model.producto.Software;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class ProductoMySQL implements ProductoDAO {
    
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;
    
    /*
    @Override
    public int crearProducto(Producto producto) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int eliminarProducto(Producto producto) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Producto> listarProducto() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }*/

    @Override
    public Producto buscarProducto(int idProducto) {
        JuegoDAO juegoDAO = new JuegoMySQL();
        BandaSonoraDAO bandaSonoraDAO = new BandaSonoraMySQL();
        SoftwareDAO softwareDAO = new SoftwareMySQL();
        
        Juego juego = juegoDAO.buscarJuego(idProducto);
        if (juego.getIdProducto() == idProducto) {
            return juego;
        }
        Software software = softwareDAO.buscarSoftware(idProducto);
        if (software.getIdProducto() == idProducto) {
            return software;
        }
        BandaSonora banda = bandaSonoraDAO.buscarBandaSonora(idProducto);
        if (banda.getIdProducto() == idProducto)
            return banda;
        juego = new Juego();
        juego.setIdProducto(-1);
        return juego;
    }
    
}
