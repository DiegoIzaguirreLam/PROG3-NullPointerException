/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.usuario.personal.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.model.Notificacion;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;

/**
 *
 * @author GAMER
 */
public interface NotificacionDAO {
    int insertarNotificacion(Notificacion notificacion);
    int eliminarNotificacion(int idNotificacion);
    int actualizarNotificacion(Notificacion notificacion);
    ArrayList<Notificacion> listarNotificaciones(int fid_usuario);
    int eliminarNotificacionesPorUsuario (int fid_usuario);
}
