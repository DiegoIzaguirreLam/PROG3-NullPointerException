/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.usuario.jugador.dao;

import pe.edu.pucp.steam.usuario.jugador.model.Cartera;

/**
 *
 * @author GAMER
 */
public interface CarteraDAO {
    int crearCartera(Cartera cartera);
    int actualizarCartera(Cartera cartera);
    Cartera buscarCartera(int idCartera);
}
