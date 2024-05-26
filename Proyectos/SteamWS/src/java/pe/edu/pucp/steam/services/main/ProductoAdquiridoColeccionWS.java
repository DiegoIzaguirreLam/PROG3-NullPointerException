package pe.edu.pucp.steam.services.main;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import pe.edu.pucp.steam.biblioteca.coleccion.dao.ProductoAdquiridoColeccionDAO;
import pe.edu.pucp.steam.biblioteca.coleccion.mysql.ProductoAdquiridoColeccionMySQL;

/**
 *
 * @author Diego
 */
@WebService(serviceName = "ProductoAdquiridoColeccionWS")
public class ProductoAdquiridoColeccionWS {
    @WebMethod(operationName="insertarProductoAdquiridoAColeccion")
    public int insertarProductoAdquiridoAColeccion(@WebParam(name = "idColeccion") int idColeccion,
            @WebParam(name = "idProductoAdquirido") int idProductoAdquirido) {
        int resultado = 0;
        try{
            ProductoAdquiridoColeccionDAO daoProductoAdquiridoColeccion = new ProductoAdquiridoColeccionMySQL();
            resultado = daoProductoAdquiridoColeccion.insertarProductoAdquiridoAColeccion(idColeccion, idProductoAdquirido);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName="eliminarProductoAdquiridoDeColeccion")
    public int eliminarProductoAdquiridoDeColeccion(@WebParam(name = "idColeccion") int idColeccion,
            @WebParam(name = "idProductoAdquirido") int idProductoAdquirido) {
        int resultado = 0;
        try{
            ProductoAdquiridoColeccionDAO daoProductoAdquiridoColeccion = new ProductoAdquiridoColeccionMySQL();
            resultado = daoProductoAdquiridoColeccion.eliminarProductoAdquiridoDeColeccion(idColeccion, idProductoAdquirido);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
}
