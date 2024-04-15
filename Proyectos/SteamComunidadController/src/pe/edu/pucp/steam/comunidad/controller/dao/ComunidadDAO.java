/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.controller.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.model.Foro;
import pe.edu.pucp.steam.comunidad.model.Hilo;
import pe.edu.pucp.steam.comunidad.model.Mensaje;
import pe.edu.pucp.steam.comunidad.model.Subforo;

/**
 *
 * @author GAMER
 */
public interface ComunidadDAO {
    int crearForo(Foro foro);
    int crearSubforo(Subforo subforo);
    int crearHilo(Hilo hilo);
    int crearMensaje(Mensaje mensaje);
    ArrayList<Mensaje> mostrarMensajesHilo(Hilo hilo);
    ArrayList<Hilo> mostrarHilosSubforo(Subforo subforo);
    ArrayList<Subforo> mostrarSubforosForo(Foro foro);
    int editarMensaje(Mensaje mensaje);
    int editarHilo(Hilo hilo);
    int editarForo(Foro foro);
    int editarSubforo(Subforo subforo);
    int eliminarMensaje(Mensaje mensaje);
    int eliminarHilo(Hilo hilo);
    int eliminarSubforo(Subforo subforo);
    int eliminarForo(Foro foro);
}
