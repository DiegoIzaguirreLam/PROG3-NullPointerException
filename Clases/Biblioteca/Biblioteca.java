package pe.edu.pucp.steam.biblioteca.model;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.model;

public class Biblioteca {
    private int idBiblioteca;
    private Usuario usuario;
    private ArrayList<Coleccion> colecciones;
    private ArrayList<Estanteria> estanterias;
    private ArrayList<ProductoAdquirido> productos;

    public int getIdBiblioteca() {
        return idBiblioteca;
    }

    public void setIdBiblioteca(int idBiblioteca) {
        this.idBiblioteca = idBiblioteca;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public ArrayList<Coleccion> getColecciones() {
        return colecciones;
    }

    public void setColecciones(ArrayList<Coleccion> colecciones) {
        this.colecciones = colecciones;
    }

    public ArrayList<Estanteria> getEstanterias() {
        return estanterias;
    }

    public void setEstanterias(ArrayList<Estanteria> estanterias) {
        this.estanterias = estanterias;
    }

    public ArrayList<ProductoAdquirido> getProductos() {
        return productos;
    }

    public void setProductos(ArrayList<ProductoAdquirido> productos) {
        this.productos = productos;
    }

}