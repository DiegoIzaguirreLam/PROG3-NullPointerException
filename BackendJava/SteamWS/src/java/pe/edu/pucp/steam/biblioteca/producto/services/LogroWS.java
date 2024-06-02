/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.LogroDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.Logro;
import pe.edu.pucp.steam.biblioteca.producto.mysql.LogroMySQL;

/**
 *
 * @author Diego
 */
@WebService(serviceName = "LogroWS", targetNamespace="http://services.softprog.pucp.edu.pe/")
public class LogroWS {
    @WebMethod(operationName = "insertarLogro")
    public int insertarLogro(@WebParam(name = "logro") Logro logro) {
        int resultado = 0;
        try{
            LogroDAO daoLogro = new LogroMySQL();
            resultado = daoLogro.insertarLogro(logro);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "actualizarLogro")
    public int actualizarLogro(@WebParam(name = "logro") Logro logro) {
        int resultado = 0;
        try{
            LogroDAO daoLogro = new LogroMySQL();
            resultado = daoLogro.actualizarLogro(logro);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarLogro")
    public int eliminarLogro(@WebParam(name = "idLogro") int idLogro) {
        int resultado = 0;
        try{
            LogroDAO daoLogro = new LogroMySQL();
            resultado = daoLogro.eliminarLogro(idLogro);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "listarLogros")
    public ArrayList<Logro> listarLogros() {
        ArrayList<Logro> logros = null;
        try{
            LogroDAO daoLogro = new LogroMySQL();
            logros = daoLogro.listarLogros();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return logros;
    }
    
    @WebMethod(operationName = "buscarLogro")
    public Logro buscarLogro(@WebParam(name = "idLogro") int idLogro) {
        Logro logro = null;
        try{
            LogroDAO daoLogro = new LogroMySQL();
            logro = daoLogro.buscarLogro(idLogro);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return logro;
    }
    
    @WebMethod(operationName = "listarLogrosPorIdJuego")
    public ArrayList<Logro> listarLogrosPorIdJuego(@WebParam(name = "idJuego") int idJuego) {
        ArrayList<Logro> logros = null;
        try{
            LogroDAO daoLogro = new LogroMySQL();
            logros = daoLogro.listarLogrosPorIdJuego(idJuego);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return logros;
    }
}
