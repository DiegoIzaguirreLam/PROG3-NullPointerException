/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.model;

import java.time.LocalTime;
import java.util.Date;

/**
 *
 * @author GAMER
 */
public class BandaSonora extends Producto{
    private String artista;
    private String compositor;
    private LocalTime duracion;

    public BandaSonora(String artista, String compositor, LocalTime duracion, String titulo, Date fechaPublicacion, double precio, String descripcion, double espacioDisco, Proveedor proveedor) {
        super(titulo, fechaPublicacion, precio, descripcion, espacioDisco, proveedor);
        this.artista = artista;
        this.compositor = compositor;
        this.duracion = duracion;
    }

    public BandaSonora(){}

    public String getArtista() {
        return artista;
    }

    public void setArtista(String artista) {
        this.artista = artista;
    }

    public String getCompositor() {
        return compositor;
    }

    public void setCompositor(String compositor) {
        this.compositor = compositor;
    }

    public LocalTime getDuracion() {
        return duracion;
    }

    public void setDuracion(LocalTime duracion) {
        this.duracion = duracion;
    }

    
}