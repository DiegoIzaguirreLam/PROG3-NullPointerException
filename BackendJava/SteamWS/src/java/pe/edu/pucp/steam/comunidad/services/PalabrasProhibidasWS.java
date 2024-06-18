/*
 * @author sofia
 */

package pe.edu.pucp.steam.comunidad.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import pe.edu.pucp.steam.comunidad.dao.PalabrasProhibidasDAO;
import pe.edu.pucp.steam.comunidad.mysql.PalabrasProhibidasMySQL;

@WebService(serviceName="PalabrasProhibidasWS", targetNamespace="http://services.softprog.pucp.edu.pe/")
public class PalabrasProhibidasWS {
    @WebMethod(operationName="buscarPalabraProhibida")
    public boolean buscarPalabraProhibida(@WebParam(name="palabra") String palabra) {
        boolean resultado=false;
        try{
            PalabrasProhibidasDAO daoPProhibidas = new PalabrasProhibidasMySQL();
            resultado = daoPProhibidas.buscarPalabra(palabra);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
}
