/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.usuario.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.model.Usuario;
import pe.edu.pucp.steam.usuario.model.jugador.Medalla;

/**
 *
 * @author GAMER
 */
public interface MedallaDAO {
    int crearMedalla(Medalla medalla);
    int actualizarMedalla(Medalla medalla);
    ArrayList<Medalla> listarMedallas(Usuario usuario);
}
