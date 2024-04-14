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

    public Movimiento(String idTransaccion, Date fecha, double monto, TipoMovimiento tipo, MetodoPago metodoPago, Cartera cartera, ArrayList<Producto> producto) {
        this.idTransaccion = idTransaccion;
        this.fecha = fecha;
        this.monto = monto;
        this.tipo = tipo;
        this.metodoPago = metodoPago;
        this.cartera = cartera;
        this.producto = producto;
    }

    public int getIdMovimiento() {
        return idMovimiento;
    }

    public void setIdMovimiento(int idMovimiento) {
        this.idMovimiento = idMovimiento;
    }

    public String getIdTransaccion() {
        return idTransaccion;
    }

    public void setIdTransaccion(String idTransaccion) {
        this.idTransaccion = idTransaccion;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public TipoMovimiento getTipo() {
        return tipo;
    }

    public void setTipo(TipoMovimiento tipo) {
        this.tipo = tipo;
    }

    public MetodoPago getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(MetodoPago metodoPago) {
        this.metodoPago = metodoPago;
    }

    public Cartera getCartera() {
        return cartera;
    }

    public void setCartera(Cartera cartera) {
        this.cartera = cartera;
    }

    public ArrayList<Producto> getProducto() {
        return producto;
    }

    public void setProducto(ArrayList<Producto> producto) {
        this.producto = producto;
    }
}
