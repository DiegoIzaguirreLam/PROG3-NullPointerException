/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.model.BandaSonora;

/**
 *
 * @author piero
 */
public interface BandaSonoraDAO {
    int insertarBandaSonora(BandaSonora bandaSonora);
    int actualizarBandaSonora(BandaSonora bandaSonora);
    int eliminarBandaSonora(int idBandaSonora);
    ArrayList<BandaSonora> listarBandaSonoras();
    BandaSonora buscarBandaSonora(int idBandaSonora);
}
