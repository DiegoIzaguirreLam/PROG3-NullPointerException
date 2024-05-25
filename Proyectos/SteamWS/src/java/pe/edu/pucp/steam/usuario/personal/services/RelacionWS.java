/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.usuario.personal.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import pe.edu.pucp.steam.usuario.personal.dao.RelacionDAO;
import pe.edu.pucp.steam.usuario.personal.mysql.RelacionMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="RelacionWS")
public class RelacionWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="agregarAmigo")
    public int agregarAmigo(@WebParam(name="idUsuarioA") int idUsuarioA, @WebParam(name="idUsuarioB") int idUsuarioB) {
        int resultado=0;
        try{
            RelacionDAO relacionDao = new RelacionMySQL();
            resultado = relacionDao.agregarAmigo(idUsuarioA, idUsuarioB);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="eliminarAmigo")
    public int eliminarAmigo(@WebParam(name="idUsuarioA") int idUsuarioA, @WebParam(name="idUsuarioB") int idUsuarioB) {
        int resultado=0;
        try{
            RelacionDAO relacionDao = new RelacionMySQL();
            resultado = relacionDao.eliminarAmigo(idUsuarioA, idUsuarioB);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="bloquearUsuario")
    public int bloquearUsuario(@WebParam(name="idUsuarioA") int idUsuarioA, @WebParam(name="idUsuarioB") int idUsuarioB) {
        int resultado=0;
        try{
            RelacionDAO relacionDao = new RelacionMySQL();
            resultado = relacionDao.bloquearUsuario(idUsuarioA, idUsuarioB);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
}