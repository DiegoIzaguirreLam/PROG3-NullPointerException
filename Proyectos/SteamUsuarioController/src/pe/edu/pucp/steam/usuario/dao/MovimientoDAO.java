/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.usuario.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.jugador.model.Cartera;
import pe.edu.pucp.steam.usuario.jugador.model.Movimiento;

/**
 *
 * @author GAMER
 */
public interface MovimientoDAO {
    int crearMovimiento(Movimiento movimiento);
    ArrayList<Movimiento> listarMovimientos(Cartera cartera);
    Movimiento buscarMovimiento(int idMovimiento);
}
