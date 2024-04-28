/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.usuario.personal.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.model.Pais;

/**
 *
 * @author GAMER
 */
public interface PaisDAO {
    int crearPais(Pais pais);
    ArrayList<Pais> listarPaises();
    int actualizarPais(Pais pais);
    Pais buscarPais(int idPais);
}
