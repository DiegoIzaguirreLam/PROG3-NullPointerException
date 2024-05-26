/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.coleccion.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.coleccion.dao.ColeccionDAO;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Coleccion;
import pe.edu.pucp.steam.biblioteca.coleccion.mysql.ColeccionMySQL;

/**
 *
 * @author Diego
 */
@WebService(serviceName = "ColeccionWS")
public class ColeccionWS {
    @WebMethod(operationName="insertarColeccion")
    public int insertarColeccion(@WebParam(name = "coleccion") Coleccion coleccion) {
        int resultado = 0;
        try{
            ColeccionDAO daoColeccion = new ColeccionMySQL();
            resultado = daoColeccion.insertarColeccion(coleccion);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="actualizarColeccion")
    public int actualizarColeccion(@WebParam(name = "coleccion") Coleccion coleccion) {
        int resultado = 0;
        try{
            ColeccionDAO daoColeccion = new ColeccionMySQL();
            resultado = daoColeccion.actualizarColeccion(coleccion);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="eliminarColeccion")
    public int eliminarColeccion(@WebParam(name = "idColeccion") int idColeccion) {
        int resultado = 0;
        try{
            ColeccionDAO daoColeccion = new ColeccionMySQL();
            resultado = daoColeccion.eliminarColeccion(idColeccion);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "listarColeccionesPorBiblioteca")
    public ArrayList<Coleccion> listarColeccionesPorBiblioteca(@WebParam(name = "idBiblioteca") int idBiblioteca) {
        ArrayList<Coleccion> colecciones = null;
        try{
            ColeccionDAO daoColeccion = new ColeccionMySQL();
            colecciones = daoColeccion.listarColeccionesPorBiblioteca(idBiblioteca);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return colecciones;
    }
    
}
