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
    int editarForo(Foro foro);
    int eliminarForo(Foro foro);
}
