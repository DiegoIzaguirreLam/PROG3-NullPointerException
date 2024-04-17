/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.Software;


/**
 *
 * @author piero
 */
public interface SoftwareDAO {
    int insertarSoftware(Software software);
    int actualizarSoftware(Software software);
    int eliminarSoftware(Software software);
    ArrayList<Software> listarSoftware();
    Software buscarSoftware(int software);
}
