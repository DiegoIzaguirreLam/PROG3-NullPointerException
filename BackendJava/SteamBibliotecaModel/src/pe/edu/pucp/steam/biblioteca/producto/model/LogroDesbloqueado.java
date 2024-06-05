package pe.edu.pucp.steam.biblioteca.producto.model;

import java.util.Date;

public class LogroDesbloqueado {
    private int idLogroDesbloqueado;
    private Date fechaDesbloqueo;
    private ProductoAdquirido juego;
    private Logro logro;
    private boolean activo;

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

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}