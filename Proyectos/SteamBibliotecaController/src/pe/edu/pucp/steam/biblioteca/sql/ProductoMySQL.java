/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.sql;

import java.sql.CallableStatement;
import java.sql.Connection;
import pe.edu.pucp.steam.biblioteca.dao.BandaSonoraDAO;
import pe.edu.pucp.steam.biblioteca.dao.JuegoDAO;
import pe.edu.pucp.steam.biblioteca.dao.ProductoDAO;
import pe.edu.pucp.steam.biblioteca.dao.SoftwareDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.BandaSonora;
import pe.edu.pucp.steam.biblioteca.producto.model.Juego;
import pe.edu.pucp.steam.biblioteca.producto.model.Producto;
import pe.edu.pucp.steam.biblioteca.producto.model.Software;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class ProductoMySQL implements ProductoDAO {
    
    private Connection con;
    private CallableStatement cs;

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

    @Override
    public int agregarProductoEtiqueta(int idProducto, int idEtiqueta) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_PRODUCTOETIQUETA"
                    + "(?,?)}");
            cs.setInt("_fid_producto", idProducto);
            cs.setInt("_fid_etiqueta", idEtiqueta);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int eliminarProductoEtiqueta(int idProducto, int idEtiqueta) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_PRODUCTOETIQUETA"
                    + "(?,?)}");
            cs.setInt("_fid_producto", idProducto);
            cs.setInt("_fid_etiqueta", idEtiqueta);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }
    
    
    
}