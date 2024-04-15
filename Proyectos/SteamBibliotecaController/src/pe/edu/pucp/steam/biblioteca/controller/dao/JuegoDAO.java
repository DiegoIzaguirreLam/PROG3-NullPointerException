/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.controller.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.Juego;
import pe.edu.pucp.steam.biblioteca.model.producto.Logro;

/**
 *
 * @author piero
 */
public interface JuegoDAO {
    int crearJuego(Juego juego);
    int actualizarJuego(Juego juego);
    int ocultarJuego(Juego juego);
    ArrayList<Logro> listarLogros(Juego juego);
    Juego buscarJuego(int idJuego);
}
