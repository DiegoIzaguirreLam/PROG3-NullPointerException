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
import pe.edu.pucp.steam.usuario.dao.PaisDAO;
import pe.edu.pucp.steam.usuario.personal.model.Pais;
import pe.edu.pucp.steam.usuario.personal.model.TipoMoneda;

/**
 *
 * @author GAMER
 */
public class PaisMySQL implements PaisDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int crearPais(Pais pais) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_PAIS"
                    + "(?,?,?)}");
            cs.registerOutParameter("_ID_PAIS",
                    java.sql.Types.INTEGER);
            cs.setString("_NOMBRE", pais.getNombre());
            cs.setString("_MONEDA", pais.getMoneda().toString());
            cs.executeUpdate();
            pais.setIdPais(cs.getInt("_ID_PAIS"));
            resultado = pais.getIdPais();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public ArrayList<Pais> listarPaises() {
        ArrayList<Pais> paises = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PAISES()}");
            rs = cs.executeQuery();
            while(rs.next()){
                Pais pais = new Pais();
                pais.setIdPais(rs.getInt("id_pais"));
                pais.setNombre(rs.getString("nombre"));
                pais.setMoneda(TipoMoneda.valueOf(rs.getString("moneda")));
                paises.add(pais);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return paises;
    }

    @Override
    public Pais buscarPais(int idPais) {
        Pais pais = new Pais();
        pais.setIdPais(-1);
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_PAIS(?)}");
            cs.setInt("_ID_PAIS", pais.getIdPais());
            rs = cs.executeQuery();
            rs.next();
            pais.setIdPais(rs.getInt("id_pais"));
            pais.setNombre(rs.getString("nombre"));
            pais.setMoneda(TipoMoneda.valueOf(rs.getString("moneda")));
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return pais;
    }

    @Override
    public int actualizarPais(Pais pais) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_PAIS"
                    + "(?,?,?)}");
            cs.setInt("_id_pais", pais.getIdPais());
            cs.setString("_nombre", pais.getNombre());
            cs.setString("_titulo", pais.getMoneda().toString());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }
    
}
