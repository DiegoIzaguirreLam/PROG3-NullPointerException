/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.perfil.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="PerfilWS")
public class PerfilWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="hello")
    public String hello(@WebParam(name="name") String txt) {
        return "Hello "+txt+" !";
    }
}
