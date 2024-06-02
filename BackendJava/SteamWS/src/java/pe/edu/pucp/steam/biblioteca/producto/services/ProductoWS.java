/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.ProductoDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.Etiqueta;
import pe.edu.pucp.steam.biblioteca.producto.model.Producto;
import pe.edu.pucp.steam.biblioteca.producto.mysql.ProductoMySQL;

/**
 *
 * @author Diego
 */
@WebService(serviceName = "ProductoWS", targetNamespace="http://services.softprog.pucp.edu.pe/")
public class ProductoWS {

    @WebMethod(operationName = "listarProductos")
    public ArrayList<Producto> listarProductos() {
        ArrayList<Producto> productos = null;
        try{
            ProductoDAO daoProducto = new ProductoMySQL();
            productos = daoProducto.listarProductos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return productos;
    }
    
    @WebMethod(operationName = "listarProductosPorEtiqueta")
    public ArrayList<Producto> listarProductosPorEtiqueta(@WebParam(name = "etiqueta") Etiqueta etiqueta) {
        ArrayList<Producto> productos = null;
        try{
            ProductoDAO daoProducto = new ProductoMySQL();
            productos = daoProducto.listarProductosPorEtiqueta(etiqueta);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return productos;
    }
    
    
    @WebMethod(operationName = "buscarProducto")
    public Producto buscarProducto(@WebParam(name = "idProducto") int idProducto) {
        Producto producto = null;
        try{
            ProductoDAO daoProducto = new ProductoMySQL();
            producto = daoProducto.buscarProducto(idProducto);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return producto;
    }
    
    @WebMethod(operationName = "listarProductosPorTituloDesarrollador")
    public ArrayList<Producto> listarProductosPorTituloDesarrollador(@WebParam(name = "tituloDesarrollador") String tituloDesarrollador) {
         ArrayList<Producto> productos = null;
        try{
            ProductoDAO daoProducto = new ProductoMySQL();
            productos = daoProducto.listarProductosPorTituloDesarrollador(tituloDesarrollador);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return productos;
    }
}
