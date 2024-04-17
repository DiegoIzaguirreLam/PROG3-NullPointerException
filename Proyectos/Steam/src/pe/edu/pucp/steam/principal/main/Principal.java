package pe.edu.pucp.steam.principal.main;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import pe.edu.pucp.steam.biblioteca.model.producto.Juego;
import pe.edu.pucp.steam.biblioteca.sql.JuegoMySQL;
import pe.edu.pucp.steam.usuario.dao.UsuarioDAO;
import pe.edu.pucp.steam.usuario.model.Pais;
import pe.edu.pucp.steam.usuario.model.TipoMoneda;
import pe.edu.pucp.steam.usuario.model.Usuario;
import pe.edu.pucp.steam.usuario.sql.UsuarioMySQL;
import pe.edu.pucp.steam.biblioteca.dao.JuegoDAO;
import pe.edu.pucp.steam.biblioteca.dao.ProveedorDAO;
import pe.edu.pucp.steam.biblioteca.model.producto.Proveedor;
import pe.edu.pucp.steam.biblioteca.sql.ProveedorMySQL;
import pe.edu.pucp.steam.usuario.dao.PaisDAO;
import pe.edu.pucp.steam.usuario.sql.PaisMySQL;

public class Principal {
    public static void main(String[] args) throws Exception {
        // Declaraciones de Variables por Usar
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        UsuarioDAO daoUsuario = new UsuarioMySQL();
        JuegoDAO daoJuego = new JuegoMySQL();
        PaisDAO daoPais = new PaisMySQL();
        ProveedorDAO daoProveedor = new ProveedorMySQL();
        
        //----------------------------------------------------------------------
        // Creación de los países
        System.out.println("Ahora, se van a registrar a los países.");
        Pais pais1 = new Pais("Peru", TipoMoneda.PEN);
        Pais pais2 = new Pais("Francia",TipoMoneda.EUR);
        
        // Inserción de Países en Base de Datos
        int resPais1 = daoPais.crearPais(pais1);
        int resPais2 = daoPais.crearPais(pais2);
        if (resPais1 != 0) {
            System.out.println("El país 1 se ha registrado con exito.");
        } else {
            System.out.println("Ocurrio un error en el registro.");
        }
        if (resPais2 != 0) {
            System.out.println("El país 2 se ha registrado con exito.");
        } else {
            System.out.println("Ocurrio un error en el registro.");
        }
        
        // Mostrar todos los Países en Base de Datos
        System.out.println("Todos los países registrados son:");
        ArrayList<Pais> paises = daoPais.listarPaises();
        for (Pais pais : paises) {
            System.out.println(pais.getIdPais()+ ". "
                               + pais.getNombre()+ " - "
                               + pais.getMoneda());
        }
        System.out.println();
        System.out.println();
        System.out.println();
        
        //----------------------------------------------------------------------
        // Creación de los usuarios
        System.out.println("Ahora, se van a registrar a los usuarios.");
        Usuario usuario1 = new Usuario();
        usuario1.setNombreCuenta("cuenta_sofia");
        usuario1.setNombrePerfil("Sofia");
        usuario1.setCorreo("a20210750@pucp.edu.pe");
        usuario1.setTelefono("123456789");
        usuario1.setPassword("password_sofia");
        usuario1.setEdad(19);
        usuario1.setFechaNacimiento(sdf.parse("24-03-1989"));
        usuario1.setVerificado(true);
        usuario1.setExpNivel(4);
        usuario1.setNivel(2);
        usuario1.setExperiencia(5);
        usuario1.setPais(pais1);
        
        Usuario usuario2 = new Usuario();
        usuario2.setNombreCuenta("cuenta_fabricio");
        usuario2.setNombrePerfil("Fabricio");
        usuario2.setCorreo("a20214115@pucp.edu.pe");
        usuario2.setTelefono("987654321");
        usuario2.setPassword("password_fabricio");
        usuario2.setEdad(20);
        usuario2.setFechaNacimiento(sdf.parse("06-12-2003"));
        usuario2.setVerificado(true);
        usuario2.setExpNivel(1);
        usuario2.setNivel(3);
        usuario2.setExperiencia(4);
        usuario2.setPais(pais2);
        
        // Inserción de Usuarios en Base de Datos
        int resUsuario1 = daoUsuario.crearUsuario(usuario1);
        int resUsuario2 = daoUsuario.crearUsuario(usuario2);
        if (resUsuario1 != 0) {
            System.out.println("El usuario 1 se ha registrado con exito.");
        } else {
            System.out.println("Ocurrio un error en el registro.");
        }
        if (resUsuario2 != 0) {
            System.out.println("El usuario 2 se ha registrado con exito.");
        } else {
            System.out.println("Ocurrio un error en el registro.");
        }
        
        // Mostrar todos los Usuarios en Base de Datos
        System.out.println("Todos los usuarios registrados son:");
        ArrayList<Usuario> usuarios = daoUsuario.listarUsuarios();
        for (Usuario usuario : usuarios) {
            System.out.println(usuario.getUID() + ". "
                               + usuario.getNombreCuenta() + " - "
                               + usuario.getPassword());
        }
<<<<<<< HEAD
        System.out.println();
        System.out.println();
        System.out.println();
        
        //----------------------------------------------------------------------
        // Creación de los Proveedores
        System.out.println("Ahora, se van a registrar a los proveedores.");
        Proveedor proveedor1 = new Proveedor();
        proveedor1.setRazonSocial("Razon Social Proveedor 1");
        
        Proveedor proveedor2 = new Proveedor();
        proveedor2.setRazonSocial("Razon Social Proveedor 2");
        
        // Inserción de Proveedores en Base de Datos
        int resProv1 = daoProveedor.insertarProveedor(proveedor1);
        int resProv2 = daoProveedor.insertarProveedor(proveedor2);
        if (resProv1 != 0) {
            System.out.println("El proveedor 1 se ha registrado con exito.");
        } else {
            System.out.println("Ocurrio un error en el registro.");
        }
        if (resProv2 != 0) {
            System.out.println("El proveedor 2 se ha registrado con exito.");
        } else {
            System.out.println("Ocurrio un error en el registro.");
        }
        
        // Mostrar todos los Proveedores en Base de Datos
        System.out.println("Todos los proveedores registrados son:");
        ArrayList<Proveedor> proveedores = daoProveedor.listarProveedores();
        for (Proveedor proveedor : proveedores) {
            System.out.println(proveedor.getIdProveedor() + ". "
                               + proveedor.getRazonSocial());
        }
        System.out.println();
        System.out.println();
        System.out.println();
        
        //----------------------------------------------------------------------
        // Creación de los juegos
        System.out.println("Ahora, se van a registrar a los juegos.");
=======
        
        
        // CRUD JUEGO
        JuegoDAO daoJuego = new JuegoMySQL();
>>>>>>> 17454bc88d4a63c5a4c5ef37fa40b8992b216e25
        Juego juego1 = new Juego();
        juego1.setTitulo("Juego 1");
        juego1.setFechaPublicacion(sdf.parse("01-01-0001"));
        juego1.setDescripcion("Descripción del Juego 1");
        juego1.setRequisitosMinimos("Core i5 10th Generation");
        juego1.setRequisitosRecomendados("Core i7 12th Generation");
        juego1.setMultijugador(true);
        juego1.setProveedor(proveedor1);
        
        Juego juego2 = new Juego();
        juego2.setTitulo("Juego 2");
        juego2.setFechaPublicacion(sdf.parse("02-02-0002"));
        juego2.setDescripcion("Descripción del Juego 2");
        juego2.setRequisitosMinimos("Core i3 10th Generation");
        juego2.setRequisitosRecomendados("Core i9 12th Generation");
        juego2.setMultijugador(true);
        juego2.setProveedor(proveedor2);
        
        // Inserción de Juegos en Base de Datos
        int resJuego1 = daoJuego.insertarJuego(juego1);
        int resJuego2 = daoJuego.insertarJuego(juego2);
        if (resJuego1 != 0) {
            System.out.println("El juego 1 se ha registrado con exito.");
        } else {
            System.out.println("Ocurrio un error en el registro.");
        }
        if (resJuego2 != 0) {
            System.out.println("El juego 2 se ha registrado con exito.");
        } else {
            System.out.println("Ocurrio un error en el registro.");
        }
        
        // Mostrar todos los Juegos en Base de Datos
        System.out.println("Todos los juegos registrados son:");
        ArrayList<Juego> juegos = daoJuego.listarJuegos();
        for (Juego juego : juegos) {
            System.out.println(juego.getIdProducto() + ". "
                               + juego.getTitulo() + " - "
                               + juego.getRequisitosMinimos()+ " - "
                               + juego.getRequisitosRecomendados());
        }
    }
}