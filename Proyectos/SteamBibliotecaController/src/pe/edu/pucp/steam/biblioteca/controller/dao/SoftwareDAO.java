/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.controller.dao;

import pe.edu.pucp.steam.biblioteca.model.producto.Software;


/**
 *
 * @author piero
 */
public interface SoftwareDAO {
    int crearSoftware(Software software);
    int actualizarSoftware(Software software);
    int ocultarSoftware(Software software);
    Software buscarSoftware(int software);
}
