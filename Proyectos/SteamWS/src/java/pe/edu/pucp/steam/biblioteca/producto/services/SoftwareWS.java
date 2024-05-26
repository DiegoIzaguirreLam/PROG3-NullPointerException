/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.SoftwareDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.Software;
import pe.edu.pucp.steam.biblioteca.producto.mysql.SoftwareMySQL;

/**
 *
 * @author Diego
 */
@WebService(serviceName = "SoftwareWS")
public class SoftwareWS {
    @WebMethod(operationName = "insertarSoftware")
    public int insertarSoftware(@WebParam(name = "software") Software software) {
        int resultado = 0;
        try{
            SoftwareDAO daoSoftware = new SoftwareMySQL();
            resultado = daoSoftware.insertarSoftware(software);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "actualizarSoftware")
    public int actualizarSoftware(@WebParam(name = "software") Software software) {
        int resultado = 0;
        try{
            SoftwareDAO daoSoftware = new SoftwareMySQL();
            resultado = daoSoftware.actualizarSoftware(software);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarSoftware")
    public int eliminarSoftware(@WebParam(name = "idSoftware") int idSoftware) {
        int resultado = 0;
        try{
            SoftwareDAO daoSoftware = new SoftwareMySQL();
            resultado = daoSoftware.eliminarSoftware(idSoftware);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "listarSoftwares")
    public ArrayList<Software> listarSoftwares() {
        ArrayList<Software> bandasSonoras = null;
        try{
            SoftwareDAO daoSoftware = new SoftwareMySQL();
            bandasSonoras = daoSoftware.listarSoftware();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return bandasSonoras;
    }
    
    @WebMethod(operationName = "buscarSoftware")
    public Software buscarSoftware(@WebParam(name = "idSoftware") int idSoftware) {
        Software software = null;
        try{
            SoftwareDAO daoSoftware = new SoftwareMySQL();
            software = daoSoftware.buscarSoftware(idSoftware);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return software;
    }
}
