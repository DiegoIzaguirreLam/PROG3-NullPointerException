package pe.edu.pucp.steam.perfil.dao;

import java.util.ArrayList;
import pe.edu.pucp.steam.perfil.model.Perfil;

public interface PerfilDAO {
    int crearPerfil(Perfil perfil); //Cuando un user se registre se llamará este método
    int actualizaPerfil(Perfil perfil);
    int ocultarPerfil(Perfil perfil);
    Perfil buscarPerfil(int idUser);
    ArrayList<Perfil> listarPerfiles();
}
