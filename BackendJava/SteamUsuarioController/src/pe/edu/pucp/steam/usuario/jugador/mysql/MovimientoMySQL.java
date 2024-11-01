/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.usuario.jugador.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.producto.model.Producto;
import pe.edu.pucp.steam.biblioteca.producto.model.ProductoAdquirido;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.usuario.jugador.dao.MovimientoDAO;
import pe.edu.pucp.steam.usuario.jugador.model.Cartera;
import pe.edu.pucp.steam.usuario.jugador.model.MetodoPago;
import pe.edu.pucp.steam.usuario.jugador.model.Movimiento;
import pe.edu.pucp.steam.usuario.jugador.model.TipoMovimiento;

/**
 *
 * @author GAMER
 */
public class MovimientoMySQL implements MovimientoDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int insertarMovimiento(Movimiento movimiento) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_MOVIMIENTO"
                    + "(?,?,?,?,?,?,?)}");
            cs.registerOutParameter("_ID_MOVIMIENTO",
                    java.sql.Types.INTEGER);
            cs.setString("_ID_TRANSACCION", movimiento.getIdTransaccion());
            cs.setDate("_FECHA_TRANSACCION", new java.sql.Date(movimiento.getFecha().getTime()));
            cs.setDouble("_MONTO", movimiento.getMonto());
            cs.setString("_TIPO", movimiento.getTipo().toString());
            MetodoPago metodoPago = movimiento.getMetodoPago();
            if(metodoPago!=null) cs.setString("_METODO_PAGO", metodoPago.toString());
            else cs.setString("_METODO_PAGO", null);
            cs.setInt("_FID_CARTERA", movimiento.getCartera().getIdCartera());
            cs.executeUpdate();
            movimiento.setIdMovimiento(cs.getInt("_ID_MOVIMIENTO"));
            if(movimiento.getTipo()==TipoMovimiento.RETIRO){
                ArrayList<ProductoAdquirido> pAs = movimiento.getProducto();
                for(ProductoAdquirido pA : pAs){
                    cs = con.prepareCall("{call INSERTAR_PRODUCTOADQUIRIDO"
                        + "(?,?,?,?)}");
                    cs.registerOutParameter("_id_producto_adquirido",
                            java.sql.Types.INTEGER);
                    cs.setInt("_fid_biblioteca", pA.getBiblioteca().getIdBiblioteca());
                    cs.setInt("_fid_producto", pA.getProducto().getIdProducto());
                    cs.setInt("_fid_movimiento", movimiento.getIdMovimiento());
                    cs.executeUpdate();
                    pA.setIdProductoAdquirido(cs.getInt("_id_producto_adquirido"));
                }
            }
            resultado = movimiento.getIdMovimiento();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado;
    }

    @Override
    public ArrayList<Movimiento> listarMovimientos(Cartera cartera) {
        ArrayList<Movimiento> movimientos = new ArrayList<>();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_MOVIMIENTOS(?)}");
            cs.setInt("_FID_CARTERA", cartera.getIdCartera());
            rs = cs.executeQuery();
            while(rs.next()){
                Movimiento movimiento = new Movimiento();
                movimiento.setIdMovimiento(rs.getInt("id_movimiento"));
                movimiento.setIdTransaccion(rs.getString("id_transaccion"));
                movimiento.setFecha(rs.getDate("fecha"));
                movimiento.setMonto(rs.getDouble("monto"));
                movimiento.setTipo(TipoMovimiento.valueOf(rs.getString("tipo")));
                if(movimiento.getTipo()==TipoMovimiento.DEPOSITO) movimiento.setMetodoPago(MetodoPago.valueOf(rs.getString("metodo_pago")));
                movimiento.setCartera(new Cartera());
                movimiento.getCartera().setIdCartera(rs.getInt("fid_cartera"));
                movimientos.add(movimiento);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return movimientos;
    }

    @Override
    public Movimiento buscarMovimiento(int idMovimiento) {
        Movimiento movimiento = new Movimiento();
        movimiento.setIdMovimiento(-1);
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_MOVIMIENTO(?)}");
            cs.setInt("_ID_MOVIMIENTO", idMovimiento);
            rs = cs.executeQuery();
            rs.next();
            movimiento.setIdMovimiento(rs.getInt("id_movimiento"));
            movimiento.setIdTransaccion(rs.getString("id_transaccion"));
            movimiento.setFecha(rs.getDate("fecha"));
            movimiento.setMonto(rs.getDouble("monto"));
            movimiento.setTipo(TipoMovimiento.valueOf(rs.getString("tipo")));
            movimiento.setMetodoPago(MetodoPago.valueOf(rs.getString("metodo_pago")));
            movimiento.setCartera(new Cartera());
            movimiento.getCartera().setIdCartera(rs.getInt("fid_cartera"));
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return movimiento;
    }
    
}
