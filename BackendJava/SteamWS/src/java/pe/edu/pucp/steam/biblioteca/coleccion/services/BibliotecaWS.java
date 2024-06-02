/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.coleccion.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import pe.edu.pucp.steam.biblioteca.coleccion.dao.BibliotecaDAO;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.coleccion.mysql.BibliotecaMySQL;

/**
 *
 * @author Diego
 */
@WebService(serviceName = "BibliotecaWS", targetNamespace="http://services.softprog.pucp.edu.pe/")
public class BibliotecaWS {

    @WebMethod(operationName = "asignarBibliotecaUsuario")
    public int asignarBibliotecaUsuario(@WebParam(name = "uid_usuario") int uid_usuario) { // le crea una biblioteca al usuario y retorna el num
        int resultado=0;
        try{
            BibliotecaDAO bibliotecaDAO = new BibliotecaMySQL();
            resultado = bibliotecaDAO.asignarBibliotecaUsuario(uid_usuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "buscarBibliotecaPorUID")
    public Biblioteca buscarBiblioteca(@WebParam(name = "buscarBibliotecaPorUID") int UID) { // le crea una biblioteca al usuario y retorna el num
        Biblioteca biblioteca = null;
        try{
            BibliotecaDAO bibliotecaDAO = new BibliotecaMySQL();
            biblioteca = bibliotecaDAO.buscarBibliotecaPorUID(UID);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return biblioteca;
    }
    
    
}
