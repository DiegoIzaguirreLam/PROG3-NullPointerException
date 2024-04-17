/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.inventario.dao;

import pe.edu.pucp.steam.inventario.model.Objeto;

/**
 *
 * @author piero
 */
public interface ObjetoDAO {
    int crearObjeto(Objeto objeto);
    int actualizarObjeto(Objeto objeto);
    int eliminarObjeto(Objeto objeto);
    int buscarObjeto(int idObjeto);
}
