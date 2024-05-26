/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.steam.services.main;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.JuegoDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.Juego;
import pe.edu.pucp.steam.biblioteca.producto.mysql.JuegoMySQL;

/**
 *
 * @author Diego
 */
@WebService(serviceName = "JuegoWS")
public class JuegoWS {

    @WebMethod(operationName = "insertarJuego")
    public int insertarJuego(@WebParam(name = "juego") Juego juego) {
        int resultado = 0;
        try{
            JuegoDAO daoJuego = new JuegoMySQL();
            resultado = daoJuego.insertarJuego(juego);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "actualizarJuego")
    public int actualizarJuego(@WebParam(name = "juego") Juego juego) {
        int resultado = 0;
        try{
            JuegoDAO daoJuego = new JuegoMySQL();
            resultado = daoJuego.actualizarJuego(juego);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarJuego")
    public int eliminarJuego(@WebParam(name = "idJuego") int idJuego) {
        int resultado = 0;
        try{
            JuegoDAO daoJuego = new JuegoMySQL();
            resultado = daoJuego.eliminarJuego(idJuego);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "listarJuegos")
    public ArrayList<Juego> listarJuegos() {
        ArrayList<Juego> juegos = null;
        try{
            JuegoDAO daoJuego = new JuegoMySQL();
            juegos = daoJuego.listarJuegos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return juegos;
    }
    
    @WebMethod(operationName = "buscarJuego")
    public Juego buscarJuego(@WebParam(name = "idJuego") int idJuego) {
        Juego juego = null;
        try{
            JuegoDAO daoJuego = new JuegoMySQL();
            juego = daoJuego.buscarJuego(idJuego);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return juego;
    }
}
