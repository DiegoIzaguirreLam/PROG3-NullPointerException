/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.services.main;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.dao.UsuarioDAO;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;
import pe.edu.pucp.steam.usuario.personal.mysql.UsuarioMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="UsuarioWS")
public class UsuarioWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="insertarUsuario")
    public int insertarUsuario(@WebParam(name="jugador") Usuario jugador) {
        int resultado=0;
        try{
            UsuarioDAO usuarioDao = new UsuarioMySQL();
            resultado = usuarioDao.insertarUsuario(jugador);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="actualizarUsuario")
    public int actualizarUsuario(@WebParam(name="jugador") Usuario jugador) {
        int resultado=0;
        try{
            UsuarioDAO usuarioDao = new UsuarioMySQL();
            resultado = usuarioDao.actualizarUsuario(jugador);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="suspenderUsuario")
    public int suspenderUsuario(@WebParam(name="jugador") Usuario jugador) {
        int resultado=0;
        try{
            UsuarioDAO usuarioDao = new UsuarioMySQL();
            resultado = usuarioDao.suspenderUsuario(jugador);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="eliminarUsuario")
    public int eliminarUsuario(@WebParam(name="jugador") Usuario jugador) {
        int resultado=0;
        try{
            UsuarioDAO usuarioDao = new UsuarioMySQL();
            resultado = usuarioDao.eliminarUsuario(jugador);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="listarUsuarios")
    public ArrayList<Usuario> listarUsuarios() {
        ArrayList<Usuario> usuarios = new ArrayList<>();
        try{
            UsuarioDAO usuarioDao = new UsuarioMySQL();
            usuarios = usuarioDao.listarUsuarios();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return usuarios;
    }
}
