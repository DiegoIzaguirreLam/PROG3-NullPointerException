/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.comunidad.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.dao.ForoUsuarioDAO;
import pe.edu.pucp.steam.comunidad.model.Foro;
import pe.edu.pucp.steam.comunidad.mysql.ForoUsuarioMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="ForoUsuario")
public class ForoUsuario {

    /** This is a sample web service operation */
    @WebMethod(operationName="crearRelacion")
    public int crearRelacion(@WebParam(name="idForo") int idForo, @WebParam(name="idUsuario") int idUsuario) {
        int resultado=0;
        try{
            ForoUsuarioDAO foroUsuarioDao = new ForoUsuarioMySQL();
            resultado = foroUsuarioDao.crearRelacion(idForo, idUsuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }

    @WebMethod(operationName="suscribirRelacion")
    public int suscribirRelacion(@WebParam(name="idForo") int idForo, @WebParam(name="idUsuario") int idUsuario) {
        int resultado=0;
        try{
            ForoUsuarioDAO foroUsuarioDao = new ForoUsuarioMySQL();
            resultado = foroUsuarioDao.suscribirRelacion(idForo, idUsuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="eliminarRelacion")
    public int eliminarRelacion(@WebParam(name="idForo") int idForo, @WebParam(name="idUsuario") int idUsuario) {
        int resultado=0;
        try{
            ForoUsuarioDAO foroUsuarioDao = new ForoUsuarioMySQL();
            resultado = foroUsuarioDao.eliminarRelacion(idForo, idUsuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="listarSuscritos")
    public ArrayList<Foro> listarSuscritos(@WebParam(name="idUsuario") int idUsuario) {
        ArrayList<Foro> foros = new ArrayList<>();
        try{
            ForoUsuarioDAO foroUsuarioDao = new ForoUsuarioMySQL();
            foros = foroUsuarioDao.listarSuscritos(idUsuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return foros;
    }
}
