/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.controller.dao;

import pe.edu.pucp.steam.biblioteca.model.producto.BandaSonora;

/**
 *
 * @author piero
 */
public interface BandaSonoraDAO {
    int crearBandaSonora(BandaSonora bandaSonora);
    int actualizarBandaSonora(BandaSonora bandaSonora);
    int ocultarBandaSonora(BandaSonora bandaSonora);
    BandaSonora buscarBandaSonora(int idBandaSonora);
}
