/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.ProveedorDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.Proveedor;
import pe.edu.pucp.steam.biblioteca.producto.mysql.ProveedorMySQL;

/**
 *
 * @author Diego
 */
@WebService(serviceName = "ProveedorWS", targetNamespace="http://services.softprog.pucp.edu.pe/")
public class ProveedorWS {

    @WebMethod(operationName = "insertarProveedor")
    public int insertarProveedor(@WebParam(name = "proveedor") Proveedor proveedor) {
        int resultado = 0;
        try{
            ProveedorDAO daoProveedor = new ProveedorMySQL();
            resultado = daoProveedor.insertarProveedor(proveedor);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "actualizarProveedor")
    public int actualizarProveedor(@WebParam(name = "proveedor") Proveedor proveedor) {
        int resultado = 0;
        try{
            ProveedorDAO daoProveedor = new ProveedorMySQL();
            resultado = daoProveedor.actualizarProveedor(proveedor);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarProveedor")
    public int eliminarProveedor(@WebParam(name = "idProveedor") int idProveedor) {
        int resultado = 0;
        try{
            ProveedorDAO daoProveedor = new ProveedorMySQL();
            resultado = daoProveedor.eliminarProveedor(idProveedor);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "listarProveedores")
    public ArrayList<Proveedor> listarProveedores() {
        ArrayList<Proveedor> proveedores = null;
        try{
            ProveedorDAO daoProveedor = new ProveedorMySQL();
            proveedores = daoProveedor.listarProveedores();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return proveedores;
    }
}
