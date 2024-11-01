package pe.edu.pucp.steam.usuario.personal.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.dao.RelacionDAO;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;
import pe.edu.pucp.steam.usuario.personal.mysql.RelacionMySQL;

@WebService(serviceName="RelacionWS",
            targetNamespace="http://services.softprog.pucp.edu.pe/")
public class RelacionWS {

    @WebMethod(operationName="agregarAmigo")
    public int agregarAmigo(
            @WebParam(name="idUsuarioActuador") int idUsuarioActuador,
            @WebParam(name="idUsuarioDestino") int idUsuarioDestino) {
        int resultado = 0;
        
        try {
            RelacionDAO relacionDao = new RelacionMySQL();
            resultado = relacionDao.agregarAmigo(idUsuarioActuador,
                                                 idUsuarioDestino);
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }
        
        return resultado;
    }
    
    @WebMethod(operationName="eliminarAmigo")
    public int eliminarAmigo(
            @WebParam(name="idUsuarioActuador") int idUsuarioActuador,
            @WebParam(name="idUsuarioDestino") int idUsuarioDestino) {
        int resultado=0;
        
        try {
            RelacionDAO relacionDao = new RelacionMySQL();
            resultado = relacionDao.eliminarAmigo(idUsuarioActuador,
                                                  idUsuarioDestino);
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }
        
        return resultado;
    }
    
    @WebMethod(operationName="bloquearUsuario")
    public int bloquearUsuario(
            @WebParam(name="idUsuarioActuador") int idUsuarioActuador,
            @WebParam(name="idUsuarioDestino") int idUsuarioDestino) {
        int resultado=0;
        
        try {
            RelacionDAO relacionDao = new RelacionMySQL();
            resultado = relacionDao.bloquearUsuario(idUsuarioActuador,
                                                    idUsuarioDestino);
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }
        
        return resultado;
    }
}