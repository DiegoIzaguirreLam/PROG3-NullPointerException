/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import pe.edu.pucp.steam.biblioteca.producto.dao.ProductoEtiquetaDAO;
import pe.edu.pucp.steam.biblioteca.producto.mysql.ProductoEtiquetaMySQL;

/**
 *
 * @author Diego
 */
@WebService(serviceName = "ProductoEtiquetaWS")
public class ProductoEtiquetaWS {
    
    @WebMethod(operationName = "agregarProductoEtiqueta")
    public int agregarProductoEtiqueta(@WebParam(name = "idProducto") int idProducto,
            @WebParam(name = "idEtiqueta") int idEtiqueta) {
        int resultado = 0;
        try{
            ProductoEtiquetaDAO daoProductoEtiqueta = new ProductoEtiquetaMySQL();
            resultado = daoProductoEtiqueta.agregarProductoEtiqueta(idProducto, idEtiqueta);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarProductoEtiqueta")
    public int eliminarProductoEtiqueta(@WebParam(name = "idProducto") int idProducto,
            @WebParam(name = "idEtiqueta") int idEtiqueta) {
        int resultado = 0;
        try{
            ProductoEtiquetaDAO daoProductoEtiqueta = new ProductoEtiquetaMySQL();
            resultado = daoProductoEtiqueta.eliminarProductoEtiqueta(idProducto, idEtiqueta);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    
}
