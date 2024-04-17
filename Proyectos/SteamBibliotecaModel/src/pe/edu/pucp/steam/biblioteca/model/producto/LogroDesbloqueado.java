/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.model.producto;

import java.util.Date;

/**
 *
 * @author GAMER
 */
public class LogroDesbloqueado {
    private int idLogroDesbloqueado;
    private Date fechaDesbloqueo;
    private ProductoAdquirido juego;
    private Logro logro;

    public LogroDesbloqueado() {}
    
    public LogroDesbloqueado(Date fechaDesbloqueo, ProductoAdquirido juego, Logro logro) {
        this.fechaDesbloqueo = fechaDesbloqueo;
        this.juego = juego;
        this.logro = logro;
    }

    public int getIdLogroDesbloqueado() {
        return idLogroDesbloqueado;
    }

    public void setIdLogroDesbloqueado(int idLogroDesbloqueado) {
        this.idLogroDesbloqueado = idLogroDesbloqueado;
    }

    public Date getFechaDesbloqueo() {
        return fechaDesbloqueo;
    }

    public void setFechaDesbloqueo(Date fechaDesbloqueo) {
        this.fechaDesbloqueo = fechaDesbloqueo;
    }

    public ProductoAdquirido getJuego() {
        return juego;
    }

    public void setJuego(ProductoAdquirido juego) {
        this.juego = juego;
    }

    public Logro getLogro() {
        return logro;
    }

    public void setLogro(Logro logro) {
        this.logro = logro;
    }
}
