/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.model;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author GAMER
 */
public class Juego extends Producto{
    private String requisitosMinimos;
    private String requisitosRecomendados;
    private boolean multijugador;
    private ArrayList<Logro> logros;

    public Juego(){}
    
    public Juego(String requisitosMinimos, String requisitosRecomendados, boolean multijugador,
            String titulo, Date fechaPublicacion,
            double precio, String descripcion, double espacioDisco, String logoUrl, String portadaUrl,
            Proveedor proveedor) {
        super(titulo, fechaPublicacion, precio, descripcion, espacioDisco, logoUrl, portadaUrl, proveedor);
        this.requisitosMinimos = requisitosMinimos;
        this.requisitosRecomendados = requisitosRecomendados;
        this.multijugador = multijugador;
    }
    
    public String getRequisitosMinimos() {
        return requisitosMinimos;
    }

    public void setRequisitosMinimos(String requisitosMinimos) {
        this.requisitosMinimos = requisitosMinimos;
    }

    public String getRequisitosRecomendados() {
        return requisitosRecomendados;
    }

    public void setRequisitosRecomendados(String requisitosRecomendados) {
        this.requisitosRecomendados = requisitosRecomendados;
    }

    public boolean isMultijugador() {
        return multijugador;
    }

    public void setMultijugador(boolean multijugador) {
        this.multijugador = multijugador;
    }

    public ArrayList<Logro> getLogros() {
        return logros;
    }

    public void setLogros(ArrayList<Logro> logros) {
        this.logros = logros;
    }
}
