/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.producto.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.dao.JuegoDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.Juego;
import pe.edu.pucp.steam.biblioteca.producto.model.Logro;
import pe.edu.pucp.steam.biblioteca.producto.model.Proveedor;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author piero
 */
public class JuegoMySQL implements JuegoDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int insertarJuego(Juego juego) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_JUEGO"
                    + "(?,?,?,?,?,?,?,?,?,?,?)}");
            cs.registerOutParameter("_id_juego",
                    java.sql.Types.INTEGER);
            cs.setInt("_fid_proveedor", juego.getProveedor().getIdProveedor());
            cs.setString("_titulo", juego.getTitulo());
            cs.setDate("_fecha_publicacion",
                       new java.sql.Date(juego.getFechaPublicacion().getTime()));
            cs.setDouble("_precio", juego.getPrecio());
            cs.setString("_descripcion", juego.getDescripcion());
            cs.setDouble("_espacio_disco", juego.getEspacioDisco());
            cs.setBoolean("_activo", true);
            cs.setString("_requisitos_minimos", juego.getRequisitosMinimos());
            cs.setString("_requisitos_recomendados", juego.getRequisitosRecomendados());
            cs.setBoolean("_multijugador", juego.isMultijugador());
            cs.executeUpdate();
            juego.setIdProducto(cs.getInt("_id_juego"));
            resultado = juego.getIdProducto();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int actualizarJuego(Juego juego) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_JUEGO"
                    + "(?,?,?,?,?,?,?,?,?,?,?)}");
            cs.setInt("_id_juego", juego.getIdProducto());
            cs.setInt("_fid_proveedor", juego.getProveedor().getIdProveedor());
            cs.setString("_titulo", juego.getTitulo());
            cs.setDate("_fecha_publicacion",
                       new java.sql.Date(juego.getFechaPublicacion().getTime()));
            cs.setDouble("_precio", juego.getPrecio());
            cs.setString("_descripcion", juego.getDescripcion());
            cs.setDouble("_espacio_disco", juego.getEspacioDisco());
            cs.setBoolean("_activo", juego.isActivo());
            cs.setString("_requisitos_minimos", juego.getRequisitosMinimos());
            cs.setString("_requisitos_recomendados", juego.getRequisitosRecomendados());
            cs.setBoolean("_multijugador", juego.isMultijugador());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public int eliminarJuego(int idJuego) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_JUEGO"
                    + "(?)}");
            cs.setInt("_id_producto", idJuego);
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public ArrayList<Juego> listarJuegos() {
        ArrayList<Juego> juegos = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_JUEGOS}");
            rs = cs.executeQuery();
            while(rs.next()){
                Juego juego = new Juego();
                Proveedor proveedor = new Proveedor();
                juego.setIdProducto(rs.getInt("id_producto"));
                juego.setTitulo(rs.getString("titulo"));
                juego.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                juego.setPrecio(rs.getDouble("precio"));
                juego.setDescripcion(rs.getString("descripcion"));
                juego.setEspacioDisco(rs.getDouble("espacio_disco"));
                juego.setRequisitosMinimos(rs.getString("requisitos_minimos"));
                juego.setRequisitosRecomendados(rs.getString("requisitos_recomendados"));
                juego.setMultijugador(rs.getBoolean("multijugador"));
                proveedor.setIdProveedor(rs.getInt("id_proveedor"));
                proveedor.setRazonSocial(rs.getString("razon_social"));
                juego.setProveedor(proveedor);
                juego.setActivo(true);
                juegos.add(juego);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return juegos;
    }

    @Override
    public ArrayList<Logro> listarLogros(Juego juego) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Juego buscarJuego(int idJuego) {
        Juego juego = new Juego();
        Proveedor proveedor = new Proveedor();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_JUEGO(?)}");
            cs.setInt(1, idJuego);
            rs = cs.executeQuery();
            rs.next();
            juego.setIdProducto(rs.getInt("id_producto"));
            juego.setTitulo(rs.getString("titulo"));
            juego.setFechaPublicacion(rs.getDate("fecha_publicacion"));
            juego.setPrecio(rs.getDouble("precio"));
            juego.setDescripcion(rs.getString("descripcion"));
            juego.setEspacioDisco(rs.getDouble("espacio_disco"));
            juego.setRequisitosMinimos(rs.getString("requisitos_minimos"));
            juego.setRequisitosRecomendados(rs.getString("requisitos_recomendados"));
            juego.setMultijugador(rs.getBoolean("multijugador"));
            juego.setActivo(rs.getBoolean("activo"));
            proveedor.setIdProveedor(rs.getInt("id_proveedor"));
            proveedor.setRazonSocial(rs.getString("razon_social"));
            juego.setProveedor(proveedor);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return juego;
    }

}
