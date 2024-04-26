/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.usuario.sql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.usuario.dao.MedallaDAO;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;
import pe.edu.pucp.steam.usuario.jugador.model.Medalla;

/**
 *
 * @author GAMER
 */
public class MedallaMySQL implements MedallaDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int crearMedalla(Medalla medalla) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_MEDALLA"
                    + "(?,?,?)}");
            cs.registerOutParameter("_ID_MEDALLA",
                    java.sql.Types.INTEGER);
            cs.setString("_NOMBRE", medalla.getNombre());
            cs.setInt("_EXPERIENCIA", medalla.getExperiencia());
            cs.executeUpdate();
            medalla.setIdMedalla(cs.getInt("_ID_MEDALLA"));
            resultado = medalla.getIdMedalla();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int actualizarMedalla(Medalla medalla) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_MEDALLA"
                    + "(?,?,?)}");
            cs.setInt("_ID_MEDALLA", medalla.getIdMedalla());
            cs.setString("_NOMBRE", medalla.getNombre());
            cs.setInt("_EXPERIENCIA", medalla.getExperiencia());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public ArrayList<Medalla> listarMedallas(Usuario usuario) {
        ArrayList<Medalla> medallas = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_MEDALLAS()}");
            rs = cs.executeQuery();
            while(rs.next()){
                Medalla medalla = new Medalla();
                medalla.setIdMedalla(rs.getInt("id_medalla"));
                medalla.setNombre(rs.getString("nombre"));
                medalla.setExperiencia(rs.getInt("experiencia"));
                medallas.add(medalla);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return medallas;
    }
    
}
