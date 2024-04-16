/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.controller.dao;

import pe.edu.pucp.steam.comunidad.model.Hilo;
import pe.edu.pucp.steam.comunidad.model.Mensaje;

/**
 *
 * @author piero
 */
public interface MensajeDAO {
    int crearMensaje(Mensaje mensaje, Hilo hilo, int idAutor);
    int editarMensaje(Mensaje mensaje , Hilo hilo);
    int eliminarMensaje(Mensaje mensaje);
    String leerMensaje(Mensaje mensaje);
}
