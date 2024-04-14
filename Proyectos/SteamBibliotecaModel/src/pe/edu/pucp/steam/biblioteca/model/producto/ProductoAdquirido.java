/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.model.producto;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.steam.biblioteca.model.IConsultable;

/**
 *
 * @author GAMER
 */
public class ProductoAdquirido implements IConsultable{
    private int idProductoAdquirido;
    private Date fechaAdquisicion;
    private Date fechaEjecutado;
    private LocalTime tiempoUso;
    private boolean actualizado;
    private Producto producto;
    private ArrayList<LogroDesbloqueado> desbloqueados;

    @Override
    public void consultarDatos() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
