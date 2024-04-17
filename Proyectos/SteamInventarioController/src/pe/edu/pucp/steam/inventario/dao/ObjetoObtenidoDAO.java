/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.inventario.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.inventario.model.ObjetoObtenido;

/**
 *
 * @author piero
 */
public interface ObjetoObtenidoDAO {
    int obtenerObjeto(ObjetoObtenido objetoObtenido);
    ArrayList<ObjetoObtenido> listarObtenidos(int idUsuario); //Lista los objetos obtenidos del user
    int eliminarObjeto(ObjetoObtenido objetoObtenido);
}
