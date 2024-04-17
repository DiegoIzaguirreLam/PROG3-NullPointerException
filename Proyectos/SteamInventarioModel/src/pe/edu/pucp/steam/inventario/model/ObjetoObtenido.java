package pe.edu.pucp.steam.inventario.model;

import java.util.Date;

public class ObjetoObtenido {
    private int idObtenido; //El id lo genera el codigo
    private Date fechaObtencion;
    private Objeto objeto;

    public ObjetoObtenido(int idObtenido, Date fechaObtencion, Objeto objeto) {
        this.idObtenido = idObtenido;
        this.fechaObtencion = fechaObtencion;
        this.objeto = objeto;
    }

    public int getIdObtenido() {
        return idObtenido;
    }

    public void setIdObtenido(int idObtenido) {
        this.idObtenido = idObtenido;
    }

    public Date getFechaObtencion() {
        return fechaObtencion;
    }

    public void setFechaObtencion(Date fechaObtencion) {
        this.fechaObtencion = fechaObtencion;
    }

    public Objeto getObjeto() {
        return objeto;
    }

    public void setObjeto(Objeto objeto) {
        this.objeto = objeto;
    }
}
