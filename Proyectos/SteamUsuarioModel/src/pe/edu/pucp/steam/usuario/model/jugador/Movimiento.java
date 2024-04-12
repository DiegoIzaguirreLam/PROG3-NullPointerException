/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.usuario.model.jugador;

import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.steam.biblioteca.model.producto.Producto;

/**
 *
 * @author GAMER
 */
public class Movimiento {
    private int idMovimiento;
    private String idTransaccion;
    private Date fecha;
    private double monto;
    private TipoMovimiento tipo;
    private MetodoPago metodoPago;
    private Cartera cartera;
    private ArrayList<Producto> producto;
}
