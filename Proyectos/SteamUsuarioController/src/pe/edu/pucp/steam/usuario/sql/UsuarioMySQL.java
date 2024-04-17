/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.usuario.sql;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.dao.UsuarioDAO;
import pe.edu.pucp.steam.usuario.model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.CallableStatement;
import java.text.SimpleDateFormat;
import java.util.Date;
import pe.edu.pucp.steam.dbmanager.config.DBManager;

/**
 *
 * @author GAMER
 */
public class UsuarioMySQL implements UsuarioDAO{
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;
    @Override
    public int crearUsuario(Usuario jugador) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call INSERTAR_USUARIO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            cs.registerOutParameter("_ID_USUARIO", java.sql.Types.INTEGER);
            cs.setString("_NOMBRE_CUENTA", jugador.getNombreCuenta());
            cs.setString("_NOMBRE_PERFIL", jugador.getNombrePerfil());
            cs.setString("_CORREO", jugador.getCorreo());
            cs.setString("_TELEFONO", jugador.getTelefono());
            cs.setString("_CONTRASENIA", jugador.getPassword());
            cs.setInt("__EDAD", jugador.getEdad());
            cs.setDate("_FECHA_NACIMIENTO", new java.sql.Date(jugador.getFechaNacimiento().getTime()));
            cs.setInt("_VERIFICADO", 1);
            cs.setInt("_EXPERIENCIA_NIVEL", jugador.getExpNivel());
            cs.setInt("_NIVEL", jugador.getNivel());
            cs.setInt("_EXPERIENCIA", jugador.getExperiencia());
            pst = con.prepareStatement("SELECT ID_PAIS FROM PAIS WHERE NOMBRE = '" + jugador.getPais().getNombre() + "'");
            rs = pst.executeQuery();
            rs.next();
            cs.setInt("_FID_PAIS", rs.getInt("ID_PAIS"));
            cs.executeUpdate();
            jugador.setUID(cs.getInt("_ID_USUARIO"));
            resultado = jugador.getUID();
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
    public int actualizarUsuario(Usuario jugador) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ACTUALIZAR_USUARIO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            cs.setInt("_ID_USUARIO", jugador.getUID());
            cs.setString("_NOMBRE_CUENTA", jugador.getNombreCuenta());
            cs.setString("_NOMBRE_PERFIL", jugador.getNombrePerfil());
            cs.setString("_CORREO", jugador.getCorreo());
            cs.setString("_TELEFONO", jugador.getTelefono());
            cs.setString("_CONTRASENIA", jugador.getPassword());
            cs.setInt("__EDAD", jugador.getEdad());
            cs.setDate("_FECHA_NACIMIENTO", new java.sql.Date(jugador.getFechaNacimiento().getTime()));
            cs.setBoolean("_VERIFICADO", jugador.isVerificado());
            cs.setInt("_EXPERIENCIA_NIVEL", jugador.getExpNivel());
            cs.setInt("_NIVEL", jugador.getNivel());
            cs.setInt("_EXPERIENCIA", jugador.getExperiencia());
            pst = con.prepareStatement("SELECT ID_PAIS FROM PAIS WHERE NOMBRE = '" + jugador.getPais().getNombre() + "'");
            rs = pst.executeQuery();
            rs.next();
            cs.setInt("_FID_PAIS", rs.getInt("ID_PAIS"));
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
    public int suspenderUsuario(Usuario jugador) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call SUSPENDER_USUARIO(?)}");
            cs.setInt("_ID_USUARIO", jugador.getUID());            
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
    public int eliminarUsuario(Usuario jugador) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call ELIMINAR_USUARIO(?)}");
            cs.setInt("_ID_USUARIO", jugador.getUID());            
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
    public ArrayList<Usuario> listarUsuarios() {
        int resultado = 0;
        ArrayList<Usuario> users = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        Date date = new Date();
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call LISTAR_USUARIO()}");     
            rs = cs.executeQuery();
            while(rs.next()){
                try{date = sdf.parse(rs.getDate("FECHA_NACIMIENTO").toString());}
                catch(Exception ex){System.out.println(ex.getMessage());}
                Usuario user = new Usuario(rs.getInt("UID"),
                                           rs.getString("NOMBRE_CUENTA"), 
                                           rs.getString("NOMBRE_PERFIL"),
                                           rs.getString("CORREO"),
                                           rs.getString("TELEFONO"),
                                           rs.getString("PASSWORD"),
                                           rs.getInt("EDAD"),
                                           date,
                                           rs.getBoolean("VERIFICADO"),
                                           rs.getInt("ACTIVO"),
                                           rs.getInt("EXPERIENCIA_NIVEL"),
                                           rs.getInt("NIVEL"),
                                           rs.getInt("EXPERIENCIA"));
                users.add(user);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){
                System.out.println(ex.getMessage());
            }
        }
        return users;
    }
}
