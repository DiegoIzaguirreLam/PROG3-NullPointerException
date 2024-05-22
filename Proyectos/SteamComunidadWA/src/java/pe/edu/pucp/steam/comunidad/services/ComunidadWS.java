/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.comunidad.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import pe.edu.pucp.steam.comunidad.model.*;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="ComunidadWS")
public class ComunidadWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="hello")
    public String hello(@WebParam(name="name") String txt) {
        return "Hello "+txt+" !";
    }
    
}
