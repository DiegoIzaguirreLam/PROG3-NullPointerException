/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.mysql;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.JuegoDAO;
import pe.edu.pucp.steam.biblioteca.producto.dao.LogroDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.Juego;
import pe.edu.pucp.steam.biblioteca.producto.model.Logro;
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
                    + "(?,?,?,?,?)}");
            cs.registerOutParameter("_id_logro",
                    java.sql.Types.INTEGER);
            cs.setString("_nombre", logro.getNombre());
            cs.setString("_descripcion", logro.getDescripcion());
            cs.setBoolean("_activo", true);
            cs.setInt("_fid_juego", logro.getJuego().getIdProducto());
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
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_LOGROS}");
            rs = cs.executeQuery();
            while(rs.next()){
                Logro logro = new Logro();
                Juego juego = new Juego();
                logro.setIdLogro(rs.getInt("id_logro"));
                logro.setNombre(rs.getString("nombre_logro"));
                logro.setDescripcion(rs.getString("descripcion_logro"));
                juego.setIdProducto(rs.getInt("id_producto"));
                juego.setTitulo(rs.getString("titulo"));
                juego.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                juego.setPrecio(rs.getDouble("precio"));
                juego.setDescripcion(rs.getString("descripcion_producto"));
                juego.setEspacioDisco(rs.getDouble("espacio_disco"));
                juego.setActivo(rs.getBoolean("producto_activo"));
                juego.setMultijugador(rs.getBoolean("multijugador"));
                juego.setRequisitosMinimos(rs.getString("requisitos_minimos"));
                juego.setRequisitosRecomendados(rs.getString("requisitos_recomendados"));
                logro.setActivo(true);
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
        Juego juego = new Juego();
        logro.setIdLogro(-1);
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_LOGRO(?)}");
            cs.setInt("_id_logro", idLogro);
            rs = cs.executeQuery();
            if(rs.next()){
                logro.setIdLogro(rs.getInt("id_logro"));
                logro.setNombre(rs.getString("nombre_logro"));
                logro.setDescripcion(rs.getString("descripcion_logro"));
                logro.setActivo(rs.getBoolean("logro_activo"));
                juego.setIdProducto(rs.getInt("id_producto"));
                juego.setTitulo(rs.getString("titulo"));
                juego.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                juego.setPrecio(rs.getDouble("precio"));
                juego.setDescripcion(rs.getString("descripcion_producto"));
                juego.setEspacioDisco(rs.getDouble("espacio_disco"));
                juego.setActivo(rs.getBoolean("producto_activo"));
                juego.setMultijugador(rs.getBoolean("multijugador"));
                juego.setRequisitosMinimos(rs.getString("requisitos_minimos"));
                juego.setRequisitosRecomendados(rs.getString("requisitos_recomendados"));
                logro.setJuego(juego);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return logro;
    }
    
    @Override
    public ArrayList<Logro> listarLogrosPorIdJuego(int idJuego) {
        ArrayList<Logro> logros = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_LOGROS_X_ID_JUEGO(?)}");
            cs.setInt("_id_juego", idJuego);
            rs = cs.executeQuery();
            while(rs.next()){
                Logro logro = new Logro();
                Juego juego = new Juego();
                logro.setIdLogro(rs.getInt("id_logro"));
                logro.setNombre(rs.getString("nombre_logro"));
                logro.setDescripcion(rs.getString("descripcion_logro"));
                juego.setIdProducto(rs.getInt("id_producto"));
                juego.setTitulo(rs.getString("titulo"));
                juego.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                juego.setPrecio(rs.getDouble("precio"));
                juego.setDescripcion(rs.getString("descripcion_producto"));
                juego.setEspacioDisco(rs.getDouble("espacio_disco"));
                juego.setActivo(rs.getBoolean("producto_activo"));
                juego.setMultijugador(rs.getBoolean("multijugador"));
                juego.setRequisitosMinimos(rs.getString("requisitos_minimos"));
                juego.setRequisitosRecomendados(rs.getString("requisitos_recomendados"));
                logro.setActivo(true);
                logros.add(logro);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return logros;
    }
}