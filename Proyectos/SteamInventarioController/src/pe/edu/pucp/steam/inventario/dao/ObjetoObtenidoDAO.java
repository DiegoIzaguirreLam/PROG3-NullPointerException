<<<<<<< HEAD
=======
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
package pe.edu.pucp.steam.inventario.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.inventario.model.ObjetoObtenido;

<<<<<<< HEAD
public interface ObjetoObtenidoDAO {
    int insertarObjeto(ObjetoObtenido objetoObtenido);
    ArrayList<ObjetoObtenido> listarObtenidos(int idUsuario); //Lista los objetos obtenidos del user
=======
/**
 *
 * @author piero
 */
public interface ObjetoObtenidoDAO {
    int obtenerObjeto(ObjetoObtenido objetoObtenido);
    ArrayList<ObjetoObtenido> listarObtenidos(int idUsuario); //Lista los objetos obtenidos del user
    int eliminarObjeto(ObjetoObtenido objetoObtenido);
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
}
