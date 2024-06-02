/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.comunidad.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.dao.MensajeDAO;
import pe.edu.pucp.steam.comunidad.model.Hilo;
import pe.edu.pucp.steam.comunidad.model.Mensaje;
import pe.edu.pucp.steam.comunidad.mysql.MensajeMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="MensajeWS", targetNamespace="http://services.softprog.pucp.edu.pe/")
public class MensajeWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="insertarMensaje")
    public int insertarMensaje(@WebParam(name="mensaje") Mensaje mensaje) {
        int resultado=0;
        try{
            MensajeDAO mensajeDao = new MensajeMySQL();
            resultado = mensajeDao.insertarMensaje(mensaje);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="mostrarMensajesHilo")
    public ArrayList<Mensaje> mostrarMensajesHilo(@WebParam(name="hilo") Hilo hilo) {
        ArrayList<Mensaje> mensajes = new ArrayList<>();
        try{
            MensajeDAO hiloDao = new MensajeMySQL();
            mensajes = hiloDao.mostrarMensajesHilo(hilo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return mensajes;
    }
    
    @WebMethod(operationName="editarMensaje")
    public int editarMensaje(@WebParam(name="mensaje") Mensaje mensaje) {
        int resultado=0;
        try{
            MensajeDAO mensajeDao = new MensajeMySQL();
            resultado = mensajeDao.editarMensaje(mensaje);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="eliminarMensaje")
    public int eliminarMensaje(@WebParam(name="mensaje") Mensaje mensaje) {
        int resultado=0;
        try{
            MensajeDAO mensajeDao = new MensajeMySQL();
            resultado = mensajeDao.eliminarMensaje(mensaje);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
}
