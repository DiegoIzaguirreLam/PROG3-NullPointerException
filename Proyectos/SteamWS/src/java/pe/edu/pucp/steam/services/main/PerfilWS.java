/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.services.main;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.perfil.dao.PerfilDAO;
import pe.edu.pucp.steam.perfil.model.Perfil;
import pe.edu.pucp.steam.perfil.mysql.PerfilMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="PerfilWS")
public class PerfilWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="asignarPerfilUsuario")
    public int asignarPerfilUsuario(@WebParam(name = "uid_usuario") int uid_usuario) {
        int resultado=0;
        try{
            PerfilDAO perfilDao = new PerfilMySQL();
            resultado = perfilDao.asignarPerfilUsuario(uid_usuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="actualizaPerfil")
    public int actualizaPerfil(@WebParam(name="perfil") Perfil perfil) {
        int resultado=0;
        try{
            PerfilDAO perfilDao = new PerfilMySQL();
            resultado = perfilDao.actualizaPerfil(perfil);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="ocultarPerfil")
    public int ocultarPerfil(@WebParam(name="perfil") Perfil perfil) {
        int resultado=0;
        try{
            PerfilDAO perfilDao = new PerfilMySQL();
            resultado = perfilDao.ocultarPerfil(perfil);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="buscarPerfil")
    public Perfil buscarPerfil(@WebParam(name="idUser") int idUser) {
        Perfil perfil = new Perfil();
        try{
            PerfilDAO perfilDao = new PerfilMySQL();
            perfil = perfilDao.buscarPerfil(idUser);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return perfil;
    }
    
    @WebMethod(operationName="listarPerfiles")
    public ArrayList<Perfil> listarPerfiles(){
        ArrayList<Perfil> perfiles = new ArrayList<>();
        try{
            PerfilDAO expositorDao = new PerfilMySQL();
            perfiles = expositorDao.listarPerfiles();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return perfiles;
    }
}
