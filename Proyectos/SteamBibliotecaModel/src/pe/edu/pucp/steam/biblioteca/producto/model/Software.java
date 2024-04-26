/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.model;

import java.util.Date;

/**
 *
 * @author GAMER
 */
public class Software extends Producto{
    private String requisitos;
    private String licencia;

    public Software(){}
    
    public Software(String requisitos, String licencia, String titulo, Date fechaPublicacion, double precio, String descripcion, double espacioDisco, boolean oculto, Proveedor proveedor) {
        super(titulo, fechaPublicacion, precio, descripcion, espacioDisco, oculto, proveedor);
        this.requisitos = requisitos;
        this.licencia = licencia;
    }

    public String getRequisitos() {
        return requisitos;
    }

    public void setRequisitos(String requisitos) {
        this.requisitos = requisitos;
    }

    public String getLicencia() {
        return licencia;
    }

    public void setLicencia(String licencia) {
        this.licencia = licencia;
    }
}
