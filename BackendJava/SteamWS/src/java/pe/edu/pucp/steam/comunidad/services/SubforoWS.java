/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.comunidad.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.dao.SubforoDAO;
import pe.edu.pucp.steam.comunidad.model.Foro;
import pe.edu.pucp.steam.comunidad.model.Subforo;
import pe.edu.pucp.steam.comunidad.mysql.SubforoMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="SubforoWS", targetNamespace="http://services.softprog.pucp.edu.pe/")
public class SubforoWS {
    /** This is a sample web service operation */
    @WebMethod(operationName="insertarSubforo")
    public int insertarSubforo(@WebParam(name="subforo") Subforo subforo) {
        int resultado=0;
        try{
            SubforoDAO subforoDao = new SubforoMySQL();
            resultado = subforoDao.insertarSubforo(subforo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="mostrarSubforosForo")
    public ArrayList<Subforo> mostrarSubforosForo(@WebParam(name="foro") Foro foro) {
        ArrayList<Subforo> subforos = new ArrayList<>();
        try{
            SubforoDAO subforoDao = new SubforoMySQL();
            subforos = subforoDao.mostrarSubforosForo(foro);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return subforos;
    }
    
    @WebMethod(operationName="editarSubforo")
    public int editarSubforo(@WebParam(name="subforo") Subforo subforo) {
        int resultado=0;
        try{
            SubforoDAO subforoDao = new SubforoMySQL();
            resultado = subforoDao.editarSubforo(subforo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="eliminarSubforo")
    public int eliminarSubforo(@WebParam(name="subforo") Subforo subforo) {
        int resultado=0;
        try{
            SubforoDAO subforoDao = new SubforoMySQL();
            resultado = subforoDao.eliminarSubforo(subforo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
}
