package pe.edu.pucp.steam.principal.main;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.Juego;
import pe.edu.pucp.steam.biblioteca.sql.JuegoMySQL;
import pe.edu.pucp.steam.comunidad.dao.MensajeDAO;
import pe.edu.pucp.steam.comunidad.model.Mensaje;
import pe.edu.pucp.steam.comunidad.sql.MensajeMySQL;
import pe.edu.pucp.steam.usuario.dao.UsuarioDAO;
import pe.edu.pucp.steam.usuario.model.Pais;
import pe.edu.pucp.steam.usuario.model.TipoMoneda;
import pe.edu.pucp.steam.usuario.model.Usuario;
import pe.edu.pucp.steam.usuario.sql.UsuarioMySQL;
import pe.edu.pucp.steam.biblioteca.dao.JuegoDAO;

public class Principal {
    public static void main(String[] args) throws Exception {
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

        // CRUD PARA USUARIO
        UsuarioDAO daoUsuario = new UsuarioMySQL();

        Pais pais1 = new Pais("Peru", TipoMoneda.PEN);
        //Pais pais2 = new Pais("Francia",TipoMoneda.EUR);

        Usuario usuario1 = new Usuario();
        usuario1.setNombreCuenta("cuenta1");
        usuario1.setNombrePerfil("sofia");
        usuario1.setCorreo("a20210750@pucp.edu.pe");
        usuario1.setTelefono("123456789");
        usuario1.setPassword("password");
        usuario1.setEdad(19);
        usuario1.setFechaNacimiento(sdf.parse("24-03-1989"));
        usuario1.setVerificado(true);
        usuario1.setExpNivel(4);
        usuario1.setNivel(2);
        usuario1.setExperiencia(5);
        usuario1.setPais(pais1);

        int resultado = daoUsuario.crearUsuario(usuario1);
        if (resultado != 0) {
            System.out.println("El usuario se ha registrado con exito.");
        } else {
            System.out.println("Ocurrio un error en el registro.");
        }

        ArrayList<Usuario> usuarios = daoUsuario.listarUsuarios();
        for (Usuario usuario : usuarios) {
            System.out.println(usuario.getUID() + ". "
                               + usuario.getNombreCuenta() + " "
                               + usuario.getPassword());
        }

        // CRUD JUEGO
        JuegoDAO daoJuego = new JuegoMySQL();
        Juego juego1 = new Juego();

        // CRUD MENSAJE
        MensajeDAO daoMensaje = new MensajeMySQL();
        Mensaje mensaje1 = new Mensaje();
    }
}