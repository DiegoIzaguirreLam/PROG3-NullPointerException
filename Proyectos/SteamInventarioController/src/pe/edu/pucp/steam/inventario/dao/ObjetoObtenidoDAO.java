package pe.edu.pucp.steam.inventario.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.inventario.model.ObjetoObtenido;

public interface ObjetoObtenidoDAO {
    int insertarObjeto(ObjetoObtenido objetoObtenido);
    ArrayList<ObjetoObtenido> listarObtenidos(int idUsuario); //Lista los objetos obtenidos del user
}
