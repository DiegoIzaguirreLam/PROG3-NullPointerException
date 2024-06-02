/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.comunidad.model.Foro;

/**
 *
 * @author piero
 */
public interface ForoDAO {
    int insertarForo(Foro foro);
    ArrayList<Foro> listarForos();
    ArrayList<Foro> buscarForos(String nombre);
    ArrayList<Foro> listarCreados(int idUser);
    ArrayList<Foro> listarSuscritos(int idUser);
    int editarForo(Foro foro);
    int eliminarForo(Foro foro);
}
