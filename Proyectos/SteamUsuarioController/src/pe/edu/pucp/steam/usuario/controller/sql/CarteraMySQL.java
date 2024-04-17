/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.usuario.controller.sql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.usuario.controller.dao.CarteraDAO;
import pe.edu.pucp.steam.usuario.model.jugador.Cartera;

/**
 *
 * @author GAMER
 */
public class CarteraMySQL implements CarteraDAO{
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;
    @Override
    public int crearCartera(Cartera cartera) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_CARTERA(?, ?, ?)}");
            cs.setInt("_ID_CARTERA", cartera.getIdCartera());
            cs.setDouble("_FONDOS", cartera.getFondos());
            cs.setInt("_CANT_MOVIMIENTOS", cartera.getCantMovimientos());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }
        }
        return resultado;
    }

    @Override
    public int actualizarCartera(Cartera cartera) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_CARTERA(?, ?, ?)}");
            cs.setInt("_ID_CARTERA", cartera.getIdCartera());
            cs.setDouble("_FONDOS", cartera.getFondos());
            cs.setInt("_CANT_MOVIMIENTOS", cartera.getCantMovimientos());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }
        }
        return resultado;
    }

    @Override
    public Cartera buscarCartera(int idCartera) {
        Cartera cartera = new Cartera();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_USUARIO(?, ?, ?)}");
            cs.setInt("_ID_CARTERA", idCartera);
            rs = cs.executeQuery();
            rs.next();
            cartera.setIdCartera(rs.getInt("ID_CARTERA"));
            cartera.setFondos(rs.getDouble("FONDOS"));
            cartera.setCantMovimientos(rs.getInt("CANT_MOVIMIENTOS"));
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }
        }
        return cartera;
    }
    
}
