/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.sql;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.dao.JuegoDAO;
import pe.edu.pucp.steam.biblioteca.dao.LogroDAO;
import pe.edu.pucp.steam.biblioteca.model.producto.Logro;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class LogroMySQL implements LogroDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarLogro(Logro logro) {
       int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_LOGRO"
                    + "(?,?,?,?)}");
            cs.registerOutParameter("_id_logro",
                    java.sql.Types.INTEGER);
            cs.setInt("_fid_juego", logro.getJuego().getIdProducto());
            cs.setString("_nombre", logro.getNombre());
            cs.setString("_descripcion", logro.getDescripcion());
            cs.executeUpdate();
            logro.setIdLogro(cs.getInt("_id_logro"));
            resultado = logro.getIdLogro();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int actualizarLogro(Logro logro) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_LOGRO"
                    + "(?,?,?,?)}");
            cs.setInt("_id_logro", logro.getIdLogro());
            cs.setInt("_fid_juego", logro.getJuego().getIdProducto());
            cs.setString("_nombre", logro.getNombre());
            cs.setString("_descripcion", logro.getDescripcion());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int eliminarLogro(int idLogro) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_LOGRO"
                    + "(?)}");
            cs.setInt("_id_logro", idLogro);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public ArrayList<Logro> listarLogros() {
        ArrayList<Logro> logros = new ArrayList<>();
        try{
            JuegoDAO juegoDAO = new JuegoMySQL();
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_LOGROS}");
            rs = cs.executeQuery();
            int fid_juego;
            while(rs.next()){
                Logro logro = new Logro();
                logro.setIdLogro(rs.getInt("id_logro"));
                logro.setNombre(rs.getString("nombre"));
                logro.setDescripcion(rs.getString("descripcion"));
                fid_juego = rs.getInt("fid_juego");
                logro.setJuego(juegoDAO.buscarJuego(fid_juego));
                logros.add(logro);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return logros;
    }

    @Override
    public Logro buscarLogro(int idLogro) {
        Logro logro = new Logro();
        logro.setIdLogro(-1);
        try{
            JuegoDAO juegoDAO = new JuegoMySQL();
            int fid_juego;
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_LOGRO(?)}");
            cs.setInt("_id_producto_adquirido", idLogro);
            rs = cs.executeQuery();
            if(rs.next()){
                logro.setIdLogro(rs.getInt("id_producto_adquirido"));
                logro.setNombre(rs.getString("nombre"));
                logro.setDescripcion(rs.getString("descripcion"));
                fid_juego = rs.getInt("fid_juego");
                logro.setJuego(juegoDAO.buscarJuego(fid_juego));
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return logro;
    }

}
