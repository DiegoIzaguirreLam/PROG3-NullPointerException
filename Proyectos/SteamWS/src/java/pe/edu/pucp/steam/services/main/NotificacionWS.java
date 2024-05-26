/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.services.main;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.dao.NotificacionDAO;
import pe.edu.pucp.steam.usuario.personal.model.Notificacion;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;
import pe.edu.pucp.steam.usuario.personal.mysql.NotificacionMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="NotificacionWS")
public class NotificacionWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="insertarNotificacion")
    public int insertarNotificacion(@WebParam(name="notificacion") Notificacion notificacion) {
        int resultado=0;
        try{
            NotificacionDAO notifiacionDao = new NotificacionMySQL();
            resultado = notifiacionDao.insertarNotificacion(notificacion);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="actualizarNotificacion")
    public int actualizarNotificacion(@WebParam(name="notificacion") Notificacion notificacion) {
        int resultado=0;
        try{
            NotificacionDAO notifiacionDao = new NotificacionMySQL();
            resultado = notifiacionDao.actualizarNotificacion(notificacion);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="eliminarNotificacion")
    public int eliminarNotificacion(@WebParam(name="notificacion") Notificacion notificacion) {
        int resultado=0;
        try{
            NotificacionDAO notifiacionDao = new NotificacionMySQL();
            resultado = notifiacionDao.eliminarNotificacion(notificacion);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="listarNotificaciones")
    public ArrayList<Notificacion> listarNotificaciones(@WebParam(name="usuario") Usuario usuario) {
        ArrayList<Notificacion> notificaciones = new ArrayList<>();
        try{
            NotificacionDAO notifiacionDao = new NotificacionMySQL();
            notificaciones = notifiacionDao.listarNotificaciones(usuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return notificaciones;
    }
}
