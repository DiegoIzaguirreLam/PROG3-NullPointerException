package pe.edu.pucp.steam.usuario.jugador.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.usuario.jugador.dao.CarteraDAO;
import pe.edu.pucp.steam.usuario.jugador.model.Cartera;

public class CarteraMySQL implements CarteraDAO {
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;
    
    @Override
    public int asignarCarteraUsuario(int uid_usuario) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_CARTERA(?, ?, ?, ?)}");
            cs.registerOutParameter("_ID_CARTERA",
                    java.sql.Types.INTEGER);
            cs.setInt("_FID_USUARIO", uid_usuario);
            cs.setDouble("_FONDOS", 0);
            cs.setInt("_CANT_MOVIMIENTOS", 0);
            cs.executeUpdate();
            resultado = cs.getInt("_ID_CARTERA");
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }
        }
        return resultado;
    }

    @Override
    public int actualizarCartera(Cartera cartera) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_CARTERA(?, ?, ?)}");
            cs.setInt("_ID_CARTERA", cartera.getIdCartera());
            cs.setDouble("_FONDOS", cartera.getFondos());
            cs.setInt("_CANT_MOVIMIENTOS", cartera.getCantMovimientos());
            resultado = cs.executeUpdate();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }
        }
        return resultado;
    }

    @Override
    public Cartera buscarCartera(int uid_usuario) {
        Cartera cartera = new Cartera();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_CARTERA(?)}");
            cs.setInt("_fid_usuario", uid_usuario);
            rs = cs.executeQuery();
            if(rs.next()){
                cartera.setIdCartera(rs.getInt("id_cartera"));
                cartera.setFondos(rs.getDouble("fondos"));
                cartera.setCantMovimientos(rs.getInt("cantidad_movimientos"));
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }
        }
        return cartera;
    }
    
}
