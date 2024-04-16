/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.controller.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.model.Hilo;
import pe.edu.pucp.steam.comunidad.model.Mensaje;
import pe.edu.pucp.steam.comunidad.model.Subforo;

/**
 *
 * @author piero
 */
public interface HiloDAO {
    int crearHilo(Hilo hilo, Subforo subforo, int idUsuario);
    ArrayList<Mensaje> mostrarMensajesHilo(Hilo hilo);
    int editarHilo(Hilo hilo, Subforo subforo);
    int eliminarHilo(Hilo hilo);
}
