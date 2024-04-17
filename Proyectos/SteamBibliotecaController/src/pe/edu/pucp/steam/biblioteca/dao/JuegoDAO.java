package pe.edu.pucp.steam.biblioteca.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.Juego;
import pe.edu.pucp.steam.biblioteca.model.producto.Logro;

public interface JuegoDAO {
    int insertarJuego(Juego juego);
    int actualizarJuego(Juego juego);
    int eliminarJuego(int idJuego);
    ArrayList<Juego> listarJuegos();
    ArrayList<Logro> listarLogros(Juego juego);
    Juego buscarJuego(int idJuego);
}
