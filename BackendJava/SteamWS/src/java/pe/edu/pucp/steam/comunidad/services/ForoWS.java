/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.comunidad.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.model.Foro;
import pe.edu.pucp.steam.comunidad.dao.ForoDAO;
import pe.edu.pucp.steam.comunidad.mysql.ForoMySQL;
/**
 *
 * @author GAMER
 */
@WebService(serviceName="ForoWS", targetNamespace="http://services.softprog.pucp.edu.pe/")
public class ForoWS {
    /** This is a sample web service operation */
    @WebMethod(operationName="insertarForo")
    public int insertarForo(@WebParam(name="foro") Foro foro) {
        int resultado=0;
        try{
            ForoDAO foroDao = new ForoMySQL();
            resultado = foroDao.insertarForo(foro);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="listarForos")
    public ArrayList<Foro> listarForos() {
        ArrayList<Foro> foros = new ArrayList<>();
        try{
            ForoDAO foroDao = new ForoMySQL();
            foros = foroDao.listarForos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return foros;
    }
    
    @WebMethod(operationName="editarForo")
    public int editarForo(@WebParam(name="foro") Foro foro) {
        int resultado=0;
        try{
            ForoDAO foroDao = new ForoMySQL();
            resultado = foroDao.insertarForo(foro);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="eliminarForo")
    public int eliminarForo(@WebParam(name="foro") Foro foro) {
        int resultado=0;
        try{
            ForoDAO foroDao = new ForoMySQL();
            resultado = foroDao.insertarForo(foro);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="buscarForos")
    public ArrayList<Foro> buscarForos(@WebParam(name="nombre") String nombre) {
        ArrayList<Foro> foros = new ArrayList<>();
        try{
            ForoDAO foroDao = new ForoMySQL();
            foros = foroDao.buscarForos(nombre);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return foros;
    }
    
    @WebMethod(operationName="listarCreados")
    public ArrayList<Foro> listarCreados(@WebParam(name="nombre") int idUser) {
        ArrayList<Foro> foros = new ArrayList<>();
        try{
            ForoDAO foroDao = new ForoMySQL();
            foros = foroDao.listarCreados(idUser);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return foros;
    }
    
    @WebMethod(operationName="listarForosSuscritos")
    public ArrayList<Foro> listarForosSuscritos(@WebParam(name="nombre") int idUser) {
        ArrayList<Foro> foros = new ArrayList<>();
        try{
            ForoDAO foroDao = new ForoMySQL();
            foros = foroDao.listarSuscritos(idUser);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return foros;
    }
}
