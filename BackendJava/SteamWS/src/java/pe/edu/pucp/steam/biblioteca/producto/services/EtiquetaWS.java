/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.EtiquetaDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.Etiqueta;
import pe.edu.pucp.steam.biblioteca.producto.mysql.EtiquetaMySQL;

/**
 *
 * @author Diego
 */
@WebService(serviceName = "EtiquetaWS", targetNamespace="http://services.softprog.pucp.edu.pe/")
public class EtiquetaWS {
    @WebMethod(operationName = "insertarEtiqueta")
    public int insertarEtiqueta(@WebParam(name = "etiqueta") Etiqueta etiqueta) {
        int resultado = 0;
        try{
            EtiquetaDAO daoBandaSonora = new EtiquetaMySQL();
            resultado = daoBandaSonora.insertarEtiqueta(etiqueta);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "actualizarEtiqueta")
    public int actualizarEtiqueta(@WebParam(name = "etiqueta") Etiqueta etiqueta) {
        int resultado = 0;
        try{
            EtiquetaDAO daoEtiqueta = new EtiquetaMySQL();
            resultado = daoEtiqueta.actualizarEtiqueta(etiqueta);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "listarEtiquetas")
    public ArrayList<Etiqueta> listarEtiquetas() {
        ArrayList<Etiqueta> etiquetas = null;
        try{
            EtiquetaDAO daoEtiqueta = new EtiquetaMySQL();
            etiquetas = daoEtiqueta.listarEtiquetas();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return etiquetas;
    }
    
    @WebMethod(operationName = "eliminarEtiqueta")
    public int eliminarEtiqueta(@WebParam(name = "idEtiqueta") int idEtiqueta) {
        int resultado = 0;
        try{
            EtiquetaDAO daoEtiqueta = new EtiquetaMySQL();
            resultado = daoEtiqueta.eliminarEtiqueta(idEtiqueta);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
}
