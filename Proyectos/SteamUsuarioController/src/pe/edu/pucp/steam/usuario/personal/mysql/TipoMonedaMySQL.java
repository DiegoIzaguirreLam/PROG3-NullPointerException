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
import pe.edu.pucp.steam.usuario.personal.dao.TipoMonedaDAO;
import pe.edu.pucp.steam.usuario.personal.model.Pais;
import pe.edu.pucp.steam.usuario.personal.model.TipoMoneda;

/**
 *
 * @author Diego
 */
public class TipoMonedaMySQL implements TipoMonedaDAO{
private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarTipoMoneda(TipoMoneda tipoMoneda) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_TIPOMONEDA"
                    + "(?,?,?,?)}");
            cs.registerOutParameter("_id_tipo_moneda",
                    java.sql.Types.INTEGER);
            cs.setString("_nombre", tipoMoneda.getNombre());
            cs.setString("_codigo", tipoMoneda.getCodigo());
            cs.setDouble("_cambio_de_dolares", tipoMoneda.getCambioDeDolares());
            cs.executeUpdate();
            tipoMoneda.setIdTipoMoneda(cs.getInt("_id_tipo_moneda"));
            resultado = tipoMoneda.getIdTipoMoneda();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public ArrayList<TipoMoneda> listarTiposMoneda() {
        ArrayList<TipoMoneda> tipoMonedas = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_TIPOMONEDAS()}");
            rs = cs.executeQuery();
            while(rs.next()){
                TipoMoneda tipoMoneda = new TipoMoneda();
                tipoMoneda.setIdTipoMoneda(rs.getInt("id_tipo_moneda"));
                tipoMoneda.setNombre(rs.getString("nombre"));
                tipoMoneda.setCodigo(rs.getString("codigo"));
                tipoMoneda.setCambioDeDolares(rs.getDouble("cambio_de_dolares"));
                tipoMoneda.setFechaCambio(sdf.parse(rs.getDate("fecha_cambio").toString()));
                tipoMoneda.setActivo(true);
                tipoMonedas.add(tipoMoneda);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return tipoMonedas;
    }

    @Override
    public int actualizarTiposMoneda(TipoMoneda tipoMoneda) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_TIPOMONEDA"
                    + "(?,?,?,?)}");
            cs.setInt("_id_tipo_moneda", tipoMoneda.getIdTipoMoneda());
            cs.setString("_nombre", tipoMoneda.getNombre());
            cs.setString("_codigo", tipoMoneda.getCodigo());
            cs.setDouble("_cambio_de_dolares", tipoMoneda.getCambioDeDolares());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;        
    }

    @Override
    public int eliminarTipoMoneda(int idTipoMoneda) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_TIPOMONEDA"
                    + "(?)}");
            cs.setInt("_id_tipo_moneda", idTipoMoneda);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }
    
}
