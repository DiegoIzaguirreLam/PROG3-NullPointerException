/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.comunidad.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.dao.HiloDAO;
import pe.edu.pucp.steam.comunidad.model.Hilo;
import pe.edu.pucp.steam.comunidad.model.Subforo;
import pe.edu.pucp.steam.comunidad.mysql.HiloMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="HiloWS", targetNamespace="http://services.softprog.pucp.edu.pe/")
public class HiloWS {
    /** This is a sample web service operation */
    @WebMethod(operationName="insertarHilo")
    public int insertarHilo(@WebParam(name="hilo") Hilo hilo) {
        int resultado=0;
        try{
            HiloDAO hiloDao = new HiloMySQL();
            resultado = hiloDao.insertarHilo(hilo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="mostrarHilosSubforo")
    public ArrayList<Hilo> mostrarHilosSubforo(@WebParam(name="subforo") Subforo subforo) {
        ArrayList<Hilo> hilos = new ArrayList<>();
        try{
            HiloDAO hiloDao = new HiloMySQL();
            hilos = hiloDao.mostrarHilosSubforo(subforo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return hilos;
    }
    
    @WebMethod(operationName="editarHilo")
    public int editarHilo(@WebParam(name="hilo") Hilo hilo) {
        int resultado=0;
        try{
            HiloDAO hiloDao = new HiloMySQL();
            resultado = hiloDao.editarHilo(hilo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="eliminarHilo")
    public int eliminarHilo(@WebParam(name="hilo") Hilo hilo) {
        int resultado=0;
        try{
            HiloDAO hiloDao = new HiloMySQL();
            resultado = hiloDao.eliminarHilo(hilo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
}
