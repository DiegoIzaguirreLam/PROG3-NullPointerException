/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.services.main;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.jugador.dao.MedallaDAO;
import pe.edu.pucp.steam.usuario.jugador.model.Medalla;
import pe.edu.pucp.steam.usuario.jugador.mysql.MedallaMySQL;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="MedallaWS")
public class MedallaWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="insertarMedalla")
    public int insertarMedalla(@WebParam(name="medalla") Medalla medalla) {
        int resultado=0;
        try{
            MedallaDAO medallaDao = new MedallaMySQL();
            resultado = medallaDao.insertarMedalla(medalla);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="actualizarMedalla")
    public int actualizarMedalla(@WebParam(name="medalla") Medalla medalla) {
        int resultado=0;
        try{
            MedallaDAO medallaDao = new MedallaMySQL();
            resultado = medallaDao.actualizarMedalla(medalla);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="buscarMedalla")
    public ArrayList<Medalla> buscarMedalla(@WebParam(name="usuario") Usuario usuario) {
        ArrayList<Medalla> medallas = new ArrayList<>();
        try{
            MedallaDAO medallaDao = new MedallaMySQL();
            medallas = medallaDao.listarMedallas(usuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return medallas;
    }
}
