/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.inventario.controller.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.inventario.model.Objeto;
import pe.edu.pucp.steam.inventario.model.ObjetoObtenido;

/**
 *
 * @author GAMER
 */
public interface InventarioDAO {
    int crearObjeto(Objeto objeto);
    int obtenerObjeto(ObjetoObtenido objetoObtenido);
    int actualizarObjeto(Objeto objeto);
    int eliminarObjeto(Objeto objeto);
    ArrayList<ObjetoObtenido> listarObtenidos(int idUsuario); //Lista los objetos obtenidos del user
}
