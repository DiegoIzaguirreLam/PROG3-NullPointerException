package pe.edu.pucp.steam.usuario.personal.mysql;

import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.personal.dao.UsuarioDAO;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;
import java.sql.Connection;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.CallableStatement;
import java.text.SimpleDateFormat;
import java.util.Date;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.usuario.personal.model.Pais;
import pe.edu.pucp.steam.usuario.personal.model.TipoMoneda;

public class UsuarioMySQL implements UsuarioDAO{
    private Connection con;
    private PreparedStatement pst;
    private CallableStatement cs;
    private ResultSet rs;
    @Override
    public int insertarUsuario(Usuario jugador) {
        int resultado = 0;
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call CREAR_USUARIO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            cs.registerOutParameter("_ID_USUARIO", java.sql.Types.INTEGER);
            cs.setString("_NOMBRE_CUENTA", jugador.getNombreCuenta());
            cs.setString("_NOMBRE_PERFIL", jugador.getNombrePerfil());
            cs.setString("_CORREO", jugador.getCorreo());
            cs.setString("_TELEFONO", jugador.getTelefono());
            cs.setString("_CONTRASENIA", jugador.getPassword());
            cs.setInt("_EDAD", jugador.getEdad());
            cs.setDate("_FECHA_NACIMIENTO", new java.sql.Date(jugador.getFechaNacimiento().getTime()));
            cs.setBoolean("_VERIFICADO", true);
            cs.setInt("_EXPERIENCIA_NIVEL", jugador.getExpNivel());
            cs.setInt("_NIVEL", jugador.getNivel());
            cs.setInt("_EXPERIENCIA", jugador.getExperiencia());
            cs.setInt("_FID_PAIS", jugador.getPais().getIdPais());
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
            cs.setInt("_EDAD", jugador.getEdad());
            cs.setDate("_FECHA_NACIMIENTO", new java.sql.Date(jugador.getFechaNacimiento().getTime()));
            cs.setBoolean("_VERIFICADO", jugador.isVerificado());
            cs.setInt("_EXPERIENCIA_NIVEL", jugador.getExpNivel());
            cs.setInt("_NIVEL", jugador.getNivel());
            cs.setInt("_EXPERIENCIA", jugador.getExperiencia());
            cs.setInt("_FID_PAIS", jugador.getPais().getIdPais());
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
                                           rs.getString("CONTRASENIA"),
                                           rs.getInt("EDAD"),
                                           date,
                                           rs.getBoolean("VERIFICADO"),
                                           rs.getInt("EXPERIENCIA_NIVEL"),
                                           rs.getInt("NIVEL"),
                                           rs.getInt("EXPERIENCIA"));
                user.setActivo(true);
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

    @Override
    public Usuario buscarUsuarioPorNombreCuenta(String nombreCuenta) {
        Usuario usuario = null;
        Pais pais = null;
        TipoMoneda moneda = null;
        
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_USUARIO_X_NOMBRE_CUENTA(?)}");
            cs.setString(1, nombreCuenta);
            rs = cs.executeQuery();
            
            if (rs.next()) {
                usuario = new Usuario();
                pais = new Pais();
                moneda = new TipoMoneda();
                
                usuario.setUID(rs.getInt("UID"));
                usuario.setNombreCuenta(rs.getString("nombre_cuenta"));
                usuario.setNombrePerfil(rs.getString("nombre_perfil"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setPassword(rs.getString("contrasenia"));
                usuario.setEdad(rs.getInt("edad"));
                usuario.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                usuario.setVerificado(rs.getBoolean("verificado"));
                usuario.setExpNivel(rs.getInt("experiencia_nivel"));
                usuario.setExperiencia(rs.getInt("experiencia"));
                usuario.setNivel(rs.getInt("nivel"));
                usuario.setActivo(rs.getBoolean("activo"));
                pais.setIdPais(rs.getInt("fid_pais"));
                pais.setNombre(rs.getString("nombre_pais"));
                moneda.setIdTipoMoneda(rs.getInt("fid_moneda"));
                moneda.setNombre(rs.getString("nombre_moneda"));
                moneda.setCambioDeDolares(rs.getDouble("cambio_de_dolares"));
                moneda.setCodigo(rs.getString("codigo_moneda"));
                pais.setMoneda(moneda);
                usuario.setPais(pais);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return usuario;
    }

    @Override
    public Usuario buscarUsuarioPorId(int uid) {
        Usuario usuario = null;
        Pais pais = null;
        TipoMoneda moneda = null;
        
        try {
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call BUSCAR_USUARIO_POR_ID(?)}");
            
            cs.setInt("_uid", uid);
            
            rs = cs.executeQuery();
            if (rs.next()) {
                usuario = new Usuario();
                pais = new Pais();
                moneda = new TipoMoneda();
        
                usuario.setUID(rs.getInt("UID"));
                usuario.setNombreCuenta(rs.getString("nombre_cuenta"));
                usuario.setNombrePerfil(rs.getString("nombre_perfil"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setPassword(rs.getString("contrasenia"));
                usuario.setEdad(rs.getInt("edad"));
                usuario.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                usuario.setVerificado(rs.getBoolean("verificado"));
                usuario.setExpNivel(rs.getInt("experiencia_nivel"));
                usuario.setExperiencia(rs.getInt("experiencia"));
                usuario.setNivel(rs.getInt("nivel"));
                usuario.setActivo(rs.getBoolean("activo"));
                pais.setIdPais(rs.getInt("fid_pais"));
                pais.setNombre(rs.getString("nombre_pais"));
                moneda.setIdTipoMoneda(rs.getInt("fid_moneda"));
                moneda.setNombre(rs.getString("nombre_moneda"));
                moneda.setCambioDeDolares(rs.getDouble("cambio_de_dolares"));
                moneda.setCodigo(rs.getString("codigo_moneda"));
                pais.setMoneda(moneda);
                usuario.setPais(pais);
            }
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            try{ con.close(); }
            catch(Exception ex)
            { System.out.println(ex.getMessage()); }
        }
        
        return usuario;
    }
    
    @Override
    public Usuario verificarCuenta(String nombreCuenta, String password) {
        Usuario usuario = new Usuario();
        Pais pais = new Pais();
        TipoMoneda moneda = new TipoMoneda();
        usuario.setUID(0);
        try{
            con = DBManager.getInstance().getConnection();
            cs = con.prepareCall("{call VERIFICAR_USUARIO(?,?)}");
            cs.setString(1, nombreCuenta);
            cs.setString(2, password);
            rs = cs.executeQuery();
            if(rs.next()){
                usuario.setUID(rs.getInt("UID"));
                usuario.setNombreCuenta(rs.getString("nombre_cuenta"));
                usuario.setNombrePerfil(rs.getString("nombre_perfil"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setPassword(rs.getString("contrasenia"));
                usuario.setEdad(rs.getInt("edad"));
                usuario.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
                usuario.setVerificado(rs.getBoolean("verificado"));
                usuario.setExpNivel(rs.getInt("experiencia_nivel"));
                usuario.setExperiencia(rs.getInt("experiencia"));
                usuario.setNivel(rs.getInt("nivel"));
                usuario.setActivo(rs.getBoolean("activo"));
                pais.setIdPais(rs.getInt("fid_pais"));
                pais.setNombre(rs.getString("nombre_pais"));
                moneda.setIdTipoMoneda(rs.getInt("fid_moneda"));
                moneda.setNombre(rs.getString("nombre_moneda"));
                moneda.setCambioDeDolares(rs.getDouble("cambio_de_dolares"));
                moneda.setCodigo(rs.getString("codigo_moneda"));
                pais.setMoneda(moneda);
                usuario.setPais(pais);
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            try{con.close();}catch(Exception ex){System.out.println(ex.getMessage());}
        }
        return usuario;
    }
}
