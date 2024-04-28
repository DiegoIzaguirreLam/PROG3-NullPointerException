/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.model.Logro;

/**
 *
 * @author piero
 */
public interface LogroDAO {
    int insertarLogro(Logro logro);
    int actualizarLogro(Logro logro);
    int eliminarLogro(int idLogro);
    ArrayList<Logro> listarLogros();
    Logro buscarLogro(int idLogro);
}
