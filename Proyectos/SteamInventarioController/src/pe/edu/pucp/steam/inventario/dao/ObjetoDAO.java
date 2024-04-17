<<<<<<< HEAD
=======
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
package pe.edu.pucp.steam.inventario.dao;

import pe.edu.pucp.steam.inventario.model.Objeto;

<<<<<<< HEAD
public interface ObjetoDAO {
    int crearObjeto(Objeto objeto);
    int actualizarObjeto(Objeto objeto);
=======
/**
 *
 * @author piero
 */
public interface ObjetoDAO {
    int crearObjeto(Objeto objeto);
    int actualizarObjeto(Objeto objeto);
    int eliminarObjeto(Objeto objeto);
    int buscarObjeto(int idObjeto);
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
}
