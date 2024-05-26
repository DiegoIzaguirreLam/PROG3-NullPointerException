/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.steam.services.main;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.ProductoAdquiridoDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.ProductoAdquirido;
import pe.edu.pucp.steam.biblioteca.producto.mysql.ProductoAdquiridoMySQL;

/**
 *
 * @author Diego
 */
@WebService(serviceName = "ProductoAdquiridoWS")
public class ProductoAdquiridoWS {

    @WebMethod(operationName = "insertarProductoAdquirido")
    public int insertarProductoAdquirido(@WebParam(name = "productoAdquirido") ProductoAdquirido productoAdquirido) {
        int resultado = 0;
        try{
            ProductoAdquiridoDAO daoProductoAdquirido = new ProductoAdquiridoMySQL();
            resultado = daoProductoAdquirido.insertarProductoAdquirido(productoAdquirido);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "actualizarProductoAdquirido")
    public int actualizarProductoAdquirido(@WebParam(name = "productoAdquirido") ProductoAdquirido productoAdquirido) {
        int resultado = 0;
        try{
            ProductoAdquiridoDAO daoProductoAdquirido = new ProductoAdquiridoMySQL();
            resultado = daoProductoAdquirido.actualizarProductoAdquirido(productoAdquirido);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarProductoAdquirido")
    public int eliminarProductoAdquirido(@WebParam(name = "idProductoAdquirido") int idProductoAdquirido) {
        int resultado = 0;
        try{
            ProductoAdquiridoDAO daoProductoAdquirido = new ProductoAdquiridoMySQL();
            resultado = daoProductoAdquirido.eliminarProductoAdquirido(idProductoAdquirido);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "listarProductosAdquiridosPorIdBiblioteca")
    public ArrayList<ProductoAdquirido> listarProductosAdquiridosPorIdBiblioteca(@WebParam(name = "idBiblioteca") int idBiblioteca) {
        ArrayList<ProductoAdquirido> productosAdquiridos = null;
        try{
            ProductoAdquiridoDAO daoProductoAdquirido = new ProductoAdquiridoMySQL();
            productosAdquiridos = daoProductoAdquirido.listarProductosAdquiridosPorIdBiblioteca(idBiblioteca);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return productosAdquiridos;
    }
    
    @WebMethod(operationName = "listarProductosAdquiridosPorIdColeccion")
    public ArrayList<ProductoAdquirido> listarProductosAdquiridosPorIdColeccion(@WebParam(name = "idColeccion") int idColeccion) {
        ArrayList<ProductoAdquirido> productosAdquiridos = null;
        try{
            ProductoAdquiridoDAO daoProductoAdquirido = new ProductoAdquiridoMySQL();
            productosAdquiridos = daoProductoAdquirido.listarProductosAdquiridosPorIdColeccion(idColeccion);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return productosAdquiridos;
    }
    
    @WebMethod(operationName = "buscarProductoAdquirido")
    public ProductoAdquirido buscarProductoAdquirido(@WebParam(name = "idProductoAdquirido") int idProductoAdquirido) {
        ProductoAdquirido productoAdquirido = null;
        try{
            ProductoAdquiridoDAO daoProductoAdquirido = new ProductoAdquiridoMySQL();
            productoAdquirido = daoProductoAdquirido.buscarProductoAdquirido(idProductoAdquirido);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return productoAdquirido;
    }
}
