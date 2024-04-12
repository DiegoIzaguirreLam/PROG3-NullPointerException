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
abstract public class Objeto {
    private String nombre;
    private Juego tematica;
    private int idObjeto;
    private ArrayList<ObjetoObtenido> obtenidos;
}
