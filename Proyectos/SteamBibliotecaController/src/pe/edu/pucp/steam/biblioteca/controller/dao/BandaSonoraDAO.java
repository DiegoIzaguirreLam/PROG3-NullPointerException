/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.controller.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.BandaSonora;

/**
 *
 * @author piero
 */
public interface BandaSonoraDAO {
    int insertarBandaSonora(BandaSonora bandaSonora);
    int actualizarBandaSonora(BandaSonora bandaSonora);
    int eliminarBandaSonora(BandaSonora bandaSonora);
    //BandaSonora buscarBandaSonora(int idBandaSonora);
    ArrayList<BandaSonora> listarBandaSonoras();
}
