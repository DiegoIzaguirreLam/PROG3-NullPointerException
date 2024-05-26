/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.services.main;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.dao.TipoMonedaDAO;
import pe.edu.pucp.steam.usuario.personal.model.TipoMoneda;
import pe.edu.pucp.steam.usuario.personal.mysql.TipoMonedaMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="TipoMonedaWS")
public class TipoMonedaWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="insertarTipoMoneda")
    public int insertarTipoMoneda(@WebParam(name="tipoMoneda") TipoMoneda tipoMoneda) {
        int resultado=0;
        try{
            TipoMonedaDAO tipoMonedaDao = new TipoMonedaMySQL();
            resultado = tipoMonedaDao.insertarTipoMoneda(tipoMoneda);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="actualizarTiposMoneda")
    public int actualizarTiposMoneda(@WebParam(name="tipoMoneda") TipoMoneda tipoMoneda) {
        int resultado=0;
        try{
            TipoMonedaDAO tipoMonedaDao = new TipoMonedaMySQL();
            resultado = tipoMonedaDao.actualizarTiposMoneda(tipoMoneda);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="listarTiposMoneda")
    public ArrayList<TipoMoneda> listarTiposMoneda() {
        ArrayList<TipoMoneda> tipos = new ArrayList<>();
        try{
            TipoMonedaDAO tipoMonedaDao = new TipoMonedaMySQL();
            tipos = tipoMonedaDao.listarTiposMoneda();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return tipos;
    }
    
    @WebMethod(operationName="eliminarTipoMoneda")
    public int eliminarTipoMoneda(@WebParam(name="idTipoMoneda") int idTipoMoneda) {
        int resultado=0;
        try{
            TipoMonedaDAO tipoMonedaDao = new TipoMonedaMySQL();
            resultado = tipoMonedaDao.eliminarTipoMoneda(idTipoMoneda);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
}
