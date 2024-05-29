/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.services.main;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import pe.edu.pucp.steam.usuario.jugador.dao.CarteraDAO;
import pe.edu.pucp.steam.usuario.jugador.model.Cartera;
import pe.edu.pucp.steam.usuario.jugador.mysql.CarteraMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="CarteraWS")
public class CarteraWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="asignarCarteraUsuario")
    public int asignarCarteraUsuario(@WebParam(name = "uid_usuario") int uid_usuario) {
        int resultado=0;
        try{
            CarteraDAO carteraDao = new CarteraMySQL();
            resultado = carteraDao.asignarCarteraUsuario(uid_usuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="actualizarCartera")
    public int actualizarCartera(@WebParam(name="cartera") Cartera cartera) {
        int resultado=0;
        try{
            CarteraDAO carteraDao = new CarteraMySQL();
            resultado = carteraDao.actualizarCartera(cartera);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="buscarCartera")
    public Cartera buscarCartera(@WebParam(name="cartera") int idUsuario) {
        Cartera cartera = new Cartera();
        try{
            CarteraDAO carteraDao = new CarteraMySQL();
            cartera = carteraDao.buscarCartera(idUsuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return cartera;
    }
}
