/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.usuario.personal.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.dao.PaisDAO;
import pe.edu.pucp.steam.usuario.personal.model.Pais;
import pe.edu.pucp.steam.usuario.personal.mysql.PaisMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="PaisWS")
public class PaisWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="insertarPais")
    public int insertarPais(@WebParam(name="pais") Pais pais) {
        int resultado=0;
        try{
            PaisDAO paisDao = new PaisMySQL();
            resultado = paisDao.insertarPais(pais);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="actualizarPais")
    public int actualizarPais(@WebParam(name="pais") Pais pais) {
        int resultado=0;
        try{
            PaisDAO paisDao = new PaisMySQL();
            resultado = paisDao.actualizarPais(pais);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="listarNotificaciones")
    public ArrayList<Pais> listarNotificaciones() {
        ArrayList<Pais> paises = new ArrayList<>();
        try{
            PaisDAO paisDao = new PaisMySQL();
            paises = paisDao.listarPaises();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return paises;
    }
    
    @WebMethod(operationName="buscarPais")
    public Pais buscarPais(@WebParam(name="idPais") int idPais) {
        Pais pais = new Pais();
        try{
            PaisDAO paisDao = new PaisMySQL();
            pais = paisDao.buscarPais(idPais);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return pais;
    }
}
