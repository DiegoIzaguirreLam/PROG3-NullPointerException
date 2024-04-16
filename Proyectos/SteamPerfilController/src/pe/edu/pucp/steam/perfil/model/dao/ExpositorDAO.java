/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.perfil.model.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.perfil.model.Expositor;

/**
 *
 * @author piero
 */
public interface ExpositorDAO {
    int crearExpositor(Expositor expositor);
    int actualizaExpositor(Expositor expositor);
    int ocultarExpositor(Expositor expositor);
    int eliminarExpositor(Expositor expositor);
    ArrayList<Expositor> listarExpositores();
    ArrayList<Expositor> listarExpositoresPerfil(int id_perfil);
}
