package pe.edu.pucp.steam.principal.main;

<<<<<<< HEAD
=======
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import pe.edu.pucp.steam.usuario.dao.UsuarioDAO;
import pe.edu.pucp.steam.usuario.model.Pais;
import pe.edu.pucp.steam.usuario.model.TipoMoneda;
import pe.edu.pucp.steam.usuario.model.Usuario;
import pe.edu.pucp.steam.usuario.sql.UsuarioMySQL;

/**
 *
 * @author GAMER
 */
>>>>>>> f4da093df441c57213195d92563e4f8e620e6e49
public class Principal {
    public static void main(String[] args){
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        UsuarioDAO daoUsuario = new UsuarioMySQL();
        
        Pais pais1 = new Pais("Peru",TipoMoneda.PEN);
        //Pais pais2 = new Pais("Francia",TipoMoneda.EUR);
        
        Usuario usuario1 = new Usuario();
        usuario1.setNombreCuenta("cuenta1");
        usuario1.setNombrePerfil("sofia");
        usuario1.setCorreo("a20210750@pucp.edu.pe");
        usuario1.setTelefono("123456789");
        usuario1.setPassword("password");
        usuario1.setFechaNacimiento(sdf.parse("24-03-1989"));
        usuario1.setVerificado(true);
        usuario1.setExpNivel(4);
        usuario1.setNivel(2);
        usuario1.setExperiencia(5);
        usuario1.setPais(pais1);
        
        int resultado = daoUsuario.crearUsuario(usuario1);
        if(resultado!=0)
            System.out.println("El usuario se ha registrado con exito.");
        else
            System.out.println("Ocurrio un error en el registro.");
        
        
        
        ArrayList<Usuario> usuarios = daoUsuario.listarUsuarios();
        for(Usuario usuario : usuarios){
            System.out.println(usuario.getUID()+ ". " 
                    + usuario.getNombreCuenta()+ " " 
                    + usuario.getPassword());
        }
        
        
        
    }
}
