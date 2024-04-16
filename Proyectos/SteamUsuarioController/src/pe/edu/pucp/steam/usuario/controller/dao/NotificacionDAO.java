/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.usuario.controller.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.model.Notificacion;
import pe.edu.pucp.steam.usuario.model.Usuario;

/**
 *
 * @author GAMER
 */
public interface NotificacionDAO {
    int crearNotificacion(Notificacion notificacion);
    int eliminarNotificacion(Notificacion notificacion);
    int verNotificacion(Notificacion notificacion);
    ArrayList<Notificacion> listarNotificaciones(Usuario usuario);
}
