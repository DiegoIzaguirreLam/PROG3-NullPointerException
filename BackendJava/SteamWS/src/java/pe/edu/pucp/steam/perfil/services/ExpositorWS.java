/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.perfil.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.perfil.dao.ExpositorDAO;
import pe.edu.pucp.steam.perfil.model.Expositor;
import pe.edu.pucp.steam.perfil.mysql.ExpositorMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="ExpositorWS", targetNamespace="http://services.softprog.pucp.edu.pe/")
public class ExpositorWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="insertarExpositor")
    public int insertarExpositor(@WebParam(name="expositor") Expositor expositor) {
        int resultado=0;
        try{
            ExpositorDAO expositorDao = new ExpositorMySQL();
            resultado = expositorDao.insertarExpositor(expositor);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="actualizarExpositor")
    public int actualizarExpositor(@WebParam(name="expositor") Expositor expositor) {
        int resultado=0;
        try{
            ExpositorDAO expositorDao = new ExpositorMySQL();
            resultado = expositorDao.actualizarExpositor(expositor);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="ocultarExpositor")
    public int ocultarExpositor(@WebParam(name="expositor") Expositor expositor) {
        int resultado=0;
        try{
            ExpositorDAO expositorDao = new ExpositorMySQL();
            resultado = expositorDao.ocultarExpositor(expositor);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="eliminarExpositor")
    public int eliminarExpositor(@WebParam(name="expositor") Expositor expositor) {
        int resultado=0;
        try{
            ExpositorDAO expositorDao = new ExpositorMySQL();
            resultado = expositorDao.eliminarExpositor(expositor);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="listarExpositores")
    public ArrayList<Expositor> listarExpositores(){
        ArrayList<Expositor> expositores = new ArrayList<>();
        try{
            ExpositorDAO expositorDao = new ExpositorMySQL();
            expositores = expositorDao.listarExpositores();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return expositores;
    }
    
    @WebMethod(operationName="listarExpositoresPerfil")
    public ArrayList<Expositor> listarExpositoresPerfil(@WebParam(name="idPerfil") int idPerfil){
        ArrayList<Expositor> expositores = new ArrayList<>();
        try{
            ExpositorDAO expositorDao = new ExpositorMySQL();
            expositores = expositorDao.listarExpositoresPerfil(idPerfil);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return expositores;
    }
}
