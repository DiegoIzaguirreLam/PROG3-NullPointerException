/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.model.producto;

/**
 *
 * @author GAMER
 */
public class Etiqueta {
    private int idEtiqueta;
    private String nombre;
    
    public Etiqueta(){};

    public Etiqueta(int idEtiqueta, String nombre) {
        this.idEtiqueta = idEtiqueta;
        this.nombre = nombre;
    }

    public int getIdEtiqueta() {
        return idEtiqueta;
    }

    public String getNombre() {
        return nombre;
    }

    public void setIdEtiqueta(int idEtiqueta) {
        this.idEtiqueta = idEtiqueta;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    
}
