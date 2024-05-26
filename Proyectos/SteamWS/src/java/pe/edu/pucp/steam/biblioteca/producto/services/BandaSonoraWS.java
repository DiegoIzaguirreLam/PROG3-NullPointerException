/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.BandaSonoraDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.BandaSonora;
import pe.edu.pucp.steam.biblioteca.producto.mysql.BandaSonoraMySQL;

/**
 *
 * @author Diego
 */
@WebService(serviceName = "BandaSonoraWS")
public class BandaSonoraWS {
    
    
    @WebMethod(operationName = "insertarBandaSonora")
    public int insertarBandaSonora(@WebParam(name = "bandaSonora") BandaSonora bandaSonora) {
        int resultado = 0;
        try{
            BandaSonoraDAO daoBandaSonora = new BandaSonoraMySQL();
            resultado = daoBandaSonora.insertarBandaSonora(bandaSonora);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "actualizarBandaSonora")
    public int actualizarBandaSonora(@WebParam(name = "bandaSonora") BandaSonora bandaSonora) {
        int resultado = 0;
        try{
            BandaSonoraDAO daoBandaSonora = new BandaSonoraMySQL();
            resultado = daoBandaSonora.actualizarBandaSonora(bandaSonora);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarBandaSonora")
    public int eliminarBandaSonora(@WebParam(name = "idBandaSonora") int idBandaSonora) {
        int resultado = 0;
        try{
            BandaSonoraDAO daoBandaSonora = new BandaSonoraMySQL();
            resultado = daoBandaSonora.eliminarBandaSonora(idBandaSonora);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "listarBandaSonoras")
    public ArrayList<BandaSonora> listarBandaSonoras() {
        ArrayList<BandaSonora> bandasSonoras = null;
        try{
            BandaSonoraDAO daoBandaSonora = new BandaSonoraMySQL();
            bandasSonoras = daoBandaSonora.listarBandaSonoras();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return bandasSonoras;
    }
    
    @WebMethod(operationName = "buscarBandaSonora")
    public BandaSonora buscarBandaSonora(@WebParam(name = "idBandaSonora") int idBandaSonora) {
        BandaSonora bandaSonora = null;
        try{
            BandaSonoraDAO daoBandaSonora = new BandaSonoraMySQL();
            bandaSonora = daoBandaSonora.buscarBandaSonora(idBandaSonora);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return bandaSonora;
    }
}
