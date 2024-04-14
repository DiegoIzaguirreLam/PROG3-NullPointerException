/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.inventario.model;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.Juego;

/**
 *
 * @author GAMER
 */
public class Cromo extends Objeto{
    private String url;

    public Cromo(String url, String nombre, Juego tematica, ArrayList<ObjetoObtenido> obtenidos) {
        super(nombre, tematica, obtenidos);
        this.url = url;
    }
    
    
}
