/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.dao;

import pe.edu.pucp.steam.biblioteca.model.producto.LogroDesbloqueado;

/**
 *
 * @author piero
 */
public interface LogroDesbloqueadoDAO {
    int desbloquearLogro(LogroDesbloqueado logro);
    LogroDesbloqueado buscarLogro(int idLogro);
    int eliminarLogro(LogroDesbloqueado logro);
}
