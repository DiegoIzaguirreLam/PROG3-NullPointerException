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
public class ObjetoUsable extends Objeto{
    private TipoUsable tipo;

    public ObjetoUsable(TipoUsable tipo, String nombre, Juego tematica, ArrayList<ObjetoObtenido> obtenidos) {
        super(nombre, tematica, obtenidos);
        this.tipo = tipo;
    }

    public TipoUsable getTipo() {
        return tipo;
    }

    public void setTipo(TipoUsable tipo) {
        this.tipo = tipo;
    }
    
    
}
