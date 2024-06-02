/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.usuario.personal.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.model.TipoMoneda;

/**
 *
 * @author Diego
 */
public interface TipoMonedaDAO {
    int insertarTipoMoneda(TipoMoneda tipoMoneda);
    ArrayList<TipoMoneda> listarTiposMoneda();
    int actualizarTiposMoneda(TipoMoneda tipoMoneda);
    int eliminarTipoMoneda(int idTipoMoneda);
}
