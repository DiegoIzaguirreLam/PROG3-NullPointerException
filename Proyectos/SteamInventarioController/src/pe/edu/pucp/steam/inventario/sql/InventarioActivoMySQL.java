package pe.edu.pucp.steam.inventario.sql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.inventario.dao.InventarioActivoDAO;
import pe.edu.pucp.steam.inventario.model.Inventario;
import pe.edu.pucp.steam.inventario.model.InventarioActivo;
import pe.edu.pucp.steam.inventario.model.ObjetoObtenido;

public class InventarioActivoMySQL implements InventarioActivoDAO {
    
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int crearInventarioActivo(InventarioActivo inventario) {
        int resultado = 0;
        
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{CALL INSERTAR_INVENTARIO_ACTIVO(?, ?, ?)}");
            cs.registerOutParameter("_id_activo", java.sql.Types.INTEGER);
            cs.setInt("_nro_objetos", inventario.getnObjetos());
            cs.setInt("_fid_inventario", inventario.getInventario().getIdInventario());
            resultado = cs.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        }
        
        return resultado;
    }

    @Override
    public ArrayList<ObjetoObtenido> listarObjetos(int idInventarioActivo) {
        ArrayList<ObjetoObtenido> lista = new ArrayList<>();

        try {
            con = DBManager.getInstance().getConnection();
            
            cs = con.prepareCall("{CALL LISTAR_OBJETOS_INVENTARIO_ACTIVO(?)}");
            cs.setInt("_id_activo", idInventarioActivo);
            rs = cs.executeQuery();
            
            while (rs.next()) {
                ObjetoObtenido objeto = new ObjetoObtenido(
                        rs.getInt("id_objeto_obtenido"),
                        rs.getDate("fecha_obtencion"),
                        null);
                lista.add(objeto);
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        }

        return lista;

    }

    @Override
    public InventarioActivo buscarInventario(int idActivo) {
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{CALL BUSCAR_INVENTARIO_ACTIVO(?)}");
            cs.setInt("_id_activo", idActivo);
            rs = cs.executeQuery();
            rs.next();
            return new InventarioActivo(idActivo, 0, null, null, null);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        }

        return null;
    }
}