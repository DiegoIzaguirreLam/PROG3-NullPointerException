/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.model.LogroDesbloqueado;

/**
 *
 * @author piero
 */
public interface LogroDesbloqueadoDAO {
    int insertarLogroDesbloqueado(LogroDesbloqueado logro);
    int actualizarLogroDesbloqueado(LogroDesbloqueado logro);
    int eliminarLogroDesbloqueado(int idLogroDesbloqueado);
    ArrayList<LogroDesbloqueado> listarLogrosDesbloqueadosProductoAdquirido(int idProductoAdquirido);
    ArrayList<LogroDesbloqueado> listarLogrosPorUsuario(int idUsuario);
}
