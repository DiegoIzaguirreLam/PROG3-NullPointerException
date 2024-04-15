/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.controller.dao;

import pe.edu.pucp.steam.biblioteca.model.producto.Logro;

/**
 *
 * @author piero
 */
public interface LogroDAO {
    int crearLogro(Logro logro);
    int eliminarLogro(Logro logro);
    int buscarLogro(int idLogro);
}
