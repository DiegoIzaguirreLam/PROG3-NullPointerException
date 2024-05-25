/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.comunidad.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import pe.edu.pucp.steam.comunidad.dao.GestorSancionesDAO;
import pe.edu.pucp.steam.comunidad.model.GestorSanciones;
import pe.edu.pucp.steam.comunidad.mysql.GestorSancionesMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="GestorSancionesWS")
public class GestorSancionesWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="insertarGestor")
    public int insertarGestor(@WebParam(name="gestor") GestorSanciones gestor) {
        int resultado=0;
        try{
            GestorSancionesDAO gestorDao = new GestorSancionesMySQL();
            resultado = gestorDao.insertarGestor(gestor);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="actualizarGestor")
    public int actualizarGestor(@WebParam(name="gestor") GestorSanciones gestor) {
        int resultado=0;
        try{
            GestorSancionesDAO gestorDao = new GestorSancionesMySQL();
            resultado = gestorDao.actualizarGestor(gestor);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="buscarGestor")
    public GestorSanciones buscarGestor(@WebParam(name="idUsuario")int idUsuario){
        GestorSanciones gestor = new GestorSanciones();
        try{
            GestorSancionesDAO gestorDao = new GestorSancionesMySQL();
            gestor = gestorDao.buscarGestor(idUsuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return gestor;
    }
}
