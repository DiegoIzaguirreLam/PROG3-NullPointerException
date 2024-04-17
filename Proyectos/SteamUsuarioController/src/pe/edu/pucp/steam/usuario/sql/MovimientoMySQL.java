/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.usuario.sql;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.dao.MovimientoDAO;
import pe.edu.pucp.steam.usuario.model.jugador.Cartera;
import pe.edu.pucp.steam.usuario.model.jugador.Movimiento;

/**
 *
 * @author GAMER
 */
public class MovimientoMySQL implements MovimientoDAO{

    @Override
    public int crearMovimiento(Movimiento movimiento) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Movimiento> listarMovimientos(Cartera cartera) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Movimiento buscarMovimiento(int idMovimiento) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
