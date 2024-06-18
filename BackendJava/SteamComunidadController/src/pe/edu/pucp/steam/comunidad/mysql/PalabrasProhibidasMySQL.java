/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package pe.edu.pucp.steam.comunidad.mysql;

import pe.edu.pucp.steam.comunidad.dao.PalabrasProhibidasDAO;
import java.sql.ResultSet;
import java.sql.CallableStatement;
import java.sql.Connection;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

public class PalabrasProhibidasMySQL implements PalabrasProhibidasDAO{
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;
    @Override
    public boolean buscarPalabra(String palabra) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_PALABRA(?)}");
            cs.setString(1, palabra);
            rs = cs.executeQuery();
            if(rs.next()){
                resultado = rs.getInt("id_palabra");
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return resultado!=0;
    }

}
