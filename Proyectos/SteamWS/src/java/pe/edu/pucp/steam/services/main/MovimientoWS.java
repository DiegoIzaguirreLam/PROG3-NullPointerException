/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */

package pe.edu.pucp.steam.services.main;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.jugador.dao.MovimientoDAO;
import pe.edu.pucp.steam.usuario.jugador.model.Cartera;
import pe.edu.pucp.steam.usuario.jugador.model.Movimiento;
import pe.edu.pucp.steam.usuario.jugador.mysql.MovimientoMySQL;

/**
 *
 * @author GAMER
 */
@WebService(serviceName="MovimientoWS")
public class MovimientoWS {

    /** This is a sample web service operation */
    @WebMethod(operationName="insertarMovimiento")
    public int insertarMovimiento(@WebParam(name="movimiento") Movimiento movimiento) {
        int resultado=0;
        try{
            MovimientoDAO movimientoDao = new MovimientoMySQL();
            resultado = movimientoDao.insertarMovimiento(movimiento);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="listarMovimientos")
    public ArrayList<Movimiento> listarMovimientos(@WebParam(name="cartera") Cartera cartera) {
        ArrayList<Movimiento> movimientos = new ArrayList<>();
        try{
            MovimientoDAO movimientoDao = new MovimientoMySQL();
            movimientos = movimientoDao.listarMovimientos(cartera);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return movimientos;
    }
    
    @WebMethod(operationName="buscarMovimiento")
    public Movimiento buscarMovimiento(@WebParam(name="idMovimiento") int idMovimiento) {
        Movimiento movimiento = new Movimiento();
        try{
            MovimientoDAO movimientoDao = new MovimientoMySQL();
            movimiento = movimientoDao.buscarMovimiento(idMovimiento);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return movimiento;
    }
}
