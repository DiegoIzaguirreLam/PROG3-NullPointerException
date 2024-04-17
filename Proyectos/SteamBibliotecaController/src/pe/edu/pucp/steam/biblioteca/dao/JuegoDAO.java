/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.Juego;
import pe.edu.pucp.steam.biblioteca.model.producto.Logro;

/**
 *
 * @author piero
 */
public interface JuegoDAO {
    int insertarJuego(Juego juego);
    int actualizarJuego(Juego juego);
    int eliminarJuego(Juego juego);
    ArrayList<Juego> listarJuegos();
    ArrayList<Logro> listarLogros(Juego juego);
    Juego buscarJuego(int idJuego);
}
