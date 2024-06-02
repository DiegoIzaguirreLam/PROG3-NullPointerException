/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.perfil.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.perfil.dao.ComentarioDAO;
import pe.edu.pucp.steam.perfil.model.Comentario;
import pe.edu.pucp.steam.perfil.model.Perfil;
import pe.edu.pucp.steam.perfil.mysql.ComentarioMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="ComentarioWS", targetNamespace="http://services.softprog.pucp.edu.pe/")
public class ComentarioWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="insertarComentario")
    public int insertarComentario(@WebParam(name="comentario") Comentario comentario) {
        int resultado=0;
        try{
            ComentarioDAO comentarioDao = new ComentarioMySQL();
            resultado = comentarioDao.insertarComentario(comentario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="actualizarComentario")
    public int actualizarComentario(@WebParam(name="comentario") Comentario comentario) {
        int resultado=0;
        try{
            ComentarioDAO comentarioDao = new ComentarioMySQL();
            resultado = comentarioDao.actualizarComentario(comentario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="ocultarComentario")
    public int ocultarComentario(@WebParam(name="comentario") Comentario comentario) {
        int resultado=0;
        try{
            ComentarioDAO comentarioDao = new ComentarioMySQL();
            resultado = comentarioDao.ocultarComentario(comentario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="listarComentarios")
    public ArrayList<Comentario> listarComentarios(){
        ArrayList<Comentario> comentarios = new ArrayList<>();
        try{
            ComentarioDAO comentarioDao = new ComentarioMySQL();
            comentarios = comentarioDao.listarComentarios();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return comentarios;
    }
    
    @WebMethod(operationName="listarComentariosPerfil")
    public ArrayList<Comentario> listarComentariosPerfil(@WebParam(name="idPerfil") int idPerfil){
        ArrayList<Comentario> comentarios = new ArrayList<>();
        try{
            ComentarioDAO comentarioDao = new ComentarioMySQL();
            comentarios = comentarioDao.listarComentariosPerfil(idPerfil);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return comentarios;
    }
}
