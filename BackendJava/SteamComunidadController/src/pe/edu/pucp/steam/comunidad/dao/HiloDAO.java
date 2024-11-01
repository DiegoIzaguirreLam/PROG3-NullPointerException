/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.model.Hilo;
import pe.edu.pucp.steam.comunidad.model.Subforo;


/**
 *
 * @author piero
 */
public interface HiloDAO {
    int insertarHilo(Hilo hilo);
    ArrayList<Hilo> mostrarHilosSubforo(Subforo subforo);
    int editarHilo(Hilo hilo);
    int eliminarHilo(Hilo hilo);
}
