/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.usuario.personal.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.usuario.personal.dao.PaisDAO;
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
    public int insertarPais(Pais pais) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_PAIS"
                    + "(?,?,?,?)}");
            cs.registerOutParameter("_ID_PAIS",
                    java.sql.Types.INTEGER);
            cs.setString("_NOMBRE", pais.getNombre());
            cs.setString("_CODIGO", pais.getCodigo());
            cs.setInt("_FID_MONEDA", pais.getMoneda().getIdTipoMoneda());
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
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_PAISES()}");
            rs = cs.executeQuery();
            while(rs.next()){
                Pais pais = new Pais();
                TipoMoneda tipoMoneda = new TipoMoneda();
                pais.setIdPais(rs.getInt("id_pais"));
                pais.setNombre(rs.getString("nombre_pais"));
                pais.setCodigo(rs.getString("codigo_pais"));
                pais.setActivo(true);
                
                tipoMoneda.setIdTipoMoneda(rs.getInt("id_tipo_moneda"));
                tipoMoneda.setNombre(rs.getString("nombre_moneda"));
                tipoMoneda.setCodigo(rs.getString("codigo_moneda"));
                tipoMoneda.setCambioDeDolares(rs.getDouble("cambio_de_dolares"));
                tipoMoneda.setFechaCambio(sdf.parse(rs.getDate("fecha_cambio").toString()));
                tipoMoneda.setActivo(rs.getBoolean("moneda_activa"));
                pais.setMoneda(tipoMoneda);
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
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_PAIS(?)}");
            cs.setInt("_ID_PAIS", pais.getIdPais());
            rs = cs.executeQuery();
            rs.next();
            TipoMoneda tipoMoneda = new TipoMoneda();
            pais.setIdPais(rs.getInt("id_pais"));
            pais.setNombre(rs.getString("nombre_pais"));
            pais.setCodigo(rs.getString("codigo_pais"));
            pais.setActivo(true);

            tipoMoneda.setIdTipoMoneda(rs.getInt("id_tipo_moneda"));
            tipoMoneda.setNombre(rs.getString("nombre_moneda"));
            tipoMoneda.setCodigo(rs.getString("codigo_moneda"));
            tipoMoneda.setCambioDeDolares(rs.getDouble("cambio_de_dolares"));
            tipoMoneda.setFechaCambio(sdf.parse(rs.getDate("fecha_cambio").toString()));
            tipoMoneda.setActivo(rs.getBoolean("moneda_activa"));
            pais.setMoneda(tipoMoneda);

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
                    + "(?,?,?,?)}");
            cs.setInt("_id_pais", pais.getIdPais());
            cs.setString("_nombre", pais.getNombre());
            cs.setString("_codigo", pais.getNombre());
            cs.setInt("_fid_moneda", pais.getMoneda().getIdTipoMoneda());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }
    
}
