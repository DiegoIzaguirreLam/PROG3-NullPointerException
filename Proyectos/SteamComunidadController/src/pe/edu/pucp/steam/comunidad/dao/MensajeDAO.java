/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.model.Hilo;
import pe.edu.pucp.steam.comunidad.model.Mensaje;

/**
 *
 * @author piero
 */
public interface MensajeDAO {
    int insertarMensaje(Mensaje mensaje);
    ArrayList<Mensaje> mostrarMensajesHilo(Hilo hilo);
    int editarMensaje(Mensaje mensaje);
    int eliminarMensaje(Mensaje mensaje);
    String leerMensaje(Mensaje mensaje);
}
