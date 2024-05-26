/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.steam.services.main;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.LogroDesbloqueadoDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.LogroDesbloqueado;
import pe.edu.pucp.steam.biblioteca.producto.mysql.LogroDesbloqueadoMySQL;

/**
 *
 * @author Diego
 */
@WebService(serviceName = "LogroDesbloqueadoWS")
public class LogroDesbloqueadoWS {

    @WebMethod(operationName = "insertarLogroDesbloqueado")
    public int insertarLogroDesbloqueado(@WebParam(name = "logroDesbloqueado") LogroDesbloqueado logroDesbloqueado) {
        int resultado = 0;
        try{
            LogroDesbloqueadoDAO daoLogroDesbloqueado = new LogroDesbloqueadoMySQL();
            resultado = daoLogroDesbloqueado.insertarLogroDesbloqueado(logroDesbloqueado);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "actualizarLogroDesbloqueado")
    public int actualizarLogroDesbloqueado(@WebParam(name = "logroDesbloqueado") LogroDesbloqueado logroDesbloqueado) {
        int resultado = 0;
        try{
            LogroDesbloqueadoDAO daoLogroDesbloqueado = new LogroDesbloqueadoMySQL();
            resultado = daoLogroDesbloqueado.actualizarLogroDesbloqueado(logroDesbloqueado);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarLogroDesbloqueado")
    public int eliminarLogroDesbloqueado(@WebParam(name = "idLogroDesbloqueado") int idLogroDesbloqueado) {
        int resultado = 0;
        try{
            LogroDesbloqueadoDAO daoLogroDesbloqueado = new LogroDesbloqueadoMySQL();
            resultado = daoLogroDesbloqueado.eliminarLogroDesbloqueado(idLogroDesbloqueado);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "listarLogrosDesbloqueadosProductoAdquirido")
    public ArrayList<LogroDesbloqueado> listarLogrosDesbloqueadosProductoAdquirido(@WebParam(name = "idProductoAdquirido") int idProductoAdquirido) {
        ArrayList<LogroDesbloqueado> logrosDesbloqueados = null;
        try{
            LogroDesbloqueadoDAO daoLogroDesbloqueado = new LogroDesbloqueadoMySQL();
            logrosDesbloqueados = daoLogroDesbloqueado.listarLogrosDesbloqueadosProductoAdquirido(idProductoAdquirido);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return logrosDesbloqueados;
    }
}
