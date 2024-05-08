package pe.edu.pucp.steam.principal.main;

import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.steam.biblioteca.coleccion.dao.BibliotecaDAO;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Biblioteca;
import pe.edu.pucp.steam.biblioteca.coleccion.mysql.BibliotecaMySQL;
import pe.edu.pucp.steam.biblioteca.producto.dao.BandaSonoraDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.Juego;
import pe.edu.pucp.steam.biblioteca.producto.mysql.JuegoMySQL;
import pe.edu.pucp.steam.usuario.personal.dao.UsuarioDAO;
import pe.edu.pucp.steam.usuario.personal.model.Pais;
import pe.edu.pucp.steam.usuario.personal.model.TipoMoneda;
import pe.edu.pucp.steam.usuario.personal.model.Usuario;
import pe.edu.pucp.steam.usuario.personal.mysql.UsuarioMySQL;
import pe.edu.pucp.steam.biblioteca.producto.dao.JuegoDAO;
import pe.edu.pucp.steam.biblioteca.producto.dao.LogroDAO;
import pe.edu.pucp.steam.biblioteca.producto.dao.ProveedorDAO;
import pe.edu.pucp.steam.biblioteca.producto.dao.SoftwareDAO;
import pe.edu.pucp.steam.biblioteca.producto.model.BandaSonora;
import pe.edu.pucp.steam.biblioteca.producto.model.Logro;
import pe.edu.pucp.steam.biblioteca.producto.model.Proveedor;
import pe.edu.pucp.steam.biblioteca.producto.model.Software;
import pe.edu.pucp.steam.biblioteca.producto.mysql.BandaSonoraMySQL;
import pe.edu.pucp.steam.biblioteca.producto.mysql.LogroMySQL;
import pe.edu.pucp.steam.biblioteca.producto.mysql.ProveedorMySQL;
import pe.edu.pucp.steam.biblioteca.producto.mysql.SoftwareMySQL;
import pe.edu.pucp.steam.usuario.personal.dao.PaisDAO;
import pe.edu.pucp.steam.usuario.personal.dao.TipoMonedaDAO;
import pe.edu.pucp.steam.usuario.personal.mysql.PaisMySQL;
import pe.edu.pucp.steam.usuario.personal.mysql.TipoMonedaMySQL;

public class Principal {
    public static void main(String[] args) throws Exception {
        
        // Declaraciones de Variables por Usar
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        String logoUrl, portadaUrl;        
        UsuarioDAO daoUsuario = new UsuarioMySQL();
        JuegoDAO daoJuego = new JuegoMySQL();
        TipoMonedaDAO daoTipoMoneda = new TipoMonedaMySQL();
        PaisDAO daoPais = new PaisMySQL();
        ProveedorDAO daoProveedor = new ProveedorMySQL();
        
        TipoMoneda sol = new TipoMoneda("Sol", "PEN", 3.73, new Date());
        TipoMoneda euro = new TipoMoneda("Euro", "EUR", 0.91, new Date());
        daoTipoMoneda.insertarTipoMoneda(sol);
        daoTipoMoneda.insertarTipoMoneda(euro);
        //----------------------------------------------------------------------
        // Creación de los países
        System.out.println("Ahora, se van a registrar a los países.");
        Pais pais1 = new Pais("Peru", "PER", sol);
        Pais pais2 = new Pais("Francia", "FR", euro);
        
        // Inserción de Países en Base de Datos
        int resPais1 = daoPais.insertarPais(pais1);
        int resPais2 = daoPais.insertarPais(pais2);
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
            System.out.println(pais.getIdPais()+ ". " + pais.getNombre()+ " - " + pais.getCodigo() + ". Moneda: " + pais.getMoneda().getCodigo() + " - Cambio de dolares: " +
                                       pais.getMoneda().getCambioDeDolares());
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
        int resUsuario1 = daoUsuario.insertarUsuario(usuario1);
        int resUsuario2 = daoUsuario.insertarUsuario(usuario2);
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
        
        
        // CRUD JUEGO
        logoUrl = "https://w7.pngwing.com/pngs/612/26/png-transparent-controller-gamepad-xbox-video-games-computer-game-icon.png";
        portadaUrl = "https://static.vecteezy.com/system/resources/thumbnails/013/381/423/small/game-console-joystick-glowing-neon-buttons-signs-bright-signboard-light-banner-easy-to-edit-illustration-vector.jpg";
        Juego juego1 = new Juego();
        juego1.setTitulo("Juego 1");
        juego1.setFechaPublicacion(sdf.parse("01-01-0001"));
        juego1.setDescripcion("Descripción del Juego 1");
        juego1.setRequisitosMinimos("Core i5 10th Generation");
        juego1.setRequisitosRecomendados("Core i7 12th Generation");
        juego1.setMultijugador(true);
        juego1.setLogoUrl(logoUrl);
        juego1.setPortadaUrl(portadaUrl);
        juego1.setActivo(true);
        juego1.setProveedor(proveedor1);
        
        logoUrl = "https://upload.wikimedia.org/wikipedia/en/0/0a/Flappy_Bird_icon.png";
        portadaUrl = "https://www.cnet.com/a/img/resize/1eb18178ce2eae10df475b4ebb62d8308a7fe6c8/hub/2014/02/14/341f3067-b0b5-11e3-a24e-d4ae52e62bcc/Flappy_Bird_Nick_02.jpg?auto=webp&fit=crop&height=675&width=1200";
        Juego juego2 = new Juego();
        juego2.setTitulo("Juego 2");
        juego2.setFechaPublicacion(sdf.parse("02-02-2024"));
        juego2.setDescripcion("Descripción del Juego 2");
        juego2.setRequisitosMinimos("Core i3 8th Generation");
        juego2.setRequisitosRecomendados("Core i9 12th Generation");
        juego2.setMultijugador(true);
        juego2.setLogoUrl(logoUrl);
        juego2.setPortadaUrl(portadaUrl);
        juego2.setActivo(true);
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
        //BANDA SONORA
        BandaSonoraDAO daoBandaSonora = new BandaSonoraMySQL();
        logoUrl = "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/d0/02/e3/d002e325-299d-f87f-a737-7d7ad3c628ae/840095520225.jpg/1200x1200bf-60.jpg";
        portadaUrl = "https://cdn.cloudflare.steamstatic.com/steam/apps/598190/header.jpg?t=1581550241";
        BandaSonora bandaSonora = new BandaSonora("Christopher Larkin", "Christopher Larkin", LocalTime.of(1, 4, 20), "Hollow Knight - Official Soundtrack", sdf.parse("20-04-2024"), 0, 
                "Soundtrack Oficial del juego Hollow Knight, captura una vasta parte del mundo subterráneo del juego", 0,
                logoUrl, portadaUrl, proveedor1);
        if(daoBandaSonora.insertarBandaSonora(bandaSonora)!=0){
            System.out.println("La banda sonora fue registrada con éxito");
        }
        else{
            System.out.println("Hay un error en el registro");
        }
        ArrayList<BandaSonora> bandas = daoBandaSonora.listarBandaSonoras();
        for(BandaSonora banda : bandas){
            System.out.println(banda.getIdProducto() + ". " + banda.getTitulo() + " - " +
                    banda.getDuracion().toString()+ " - " + banda.getArtista() + " - " + banda.getDescripcion());
            System.out.println(sdf.format(banda.getFechaPublicacion()));
        }
        
        if(daoBandaSonora.eliminarBandaSonora(2)==0){
            System.out.println("se elimino con exito");
        }/*
        ArrayList<BandaSonora> bandas = daoBandaSonora.listarBandaSonoras();
        for(BandaSonora banda : bandas){
            System.out.println(banda.getIdProducto() + ". " + banda.getTitulo() + " - " +
                    banda.getDuracion().toString()+ " - " + banda.getArtista() + " - " + banda.getDescripcion());
        }*/

        //CRUD SOFTWARE
        logoUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShoRHLNX2m9GQ-ziMfqlaSkfZH8m5YnhovOAWASmw8Dg&s";
        portadaUrl = "https://cdn.akamai.steamstatic.com/steam/apps/431960/header.jpg?t=1665921297";
        SoftwareDAO daoSoftware = new SoftwareMySQL();
        Software software1 = new Software("Core i5 7th Generation", "GPL", "Wallpaper Engine", sdf.parse("29-04-2004"),
                5, "Aplicacion para fondos de pantalla en alta calidad y animados", 20, logoUrl, portadaUrl, proveedor2);
        
        if(daoSoftware.insertarSoftware(software1)!=0){
            System.out.println("El software se insertó con exito");
        }
        /*
        Software software = daoSoftware.buscarSoftware(6);
        
        System.out.println(software.getIdProducto() + ". " + software.getTitulo() +
                    " - " + software.getRequisitos() + " - " + software.getPrecio());
            System.out.println("    Proveedor: " + software.getProveedor().getIdProveedor() + ". " + software.getProveedor().getRazonSocial());
        
        software.setPrecio(2.5);
        daoSoftware.actualizarSoftware(software);
        software = daoSoftware.buscarSoftware(6);
        System.out.println(software.getIdProducto() + ". " + software.getTitulo() +
                    " - " + software.getRequisitos() + " - " + software.getPrecio());
            System.out.println("    Proveedor: " + software.getProveedor().getIdProveedor() + ". " + software.getProveedor().getRazonSocial());
        */
            
        
        /*
        ArrayList<Software> softwares = daoSoftware.listarSoftware();
        for(Software software: softwares){
            System.out.println(software.getIdProducto() + ". " + software.getTitulo() +
                    " - " + software.getRequisitos() + " - " + software.getPrecio());
            System.out.println("    Proveedor: " + software.getProveedor().getIdProveedor() + ". " + software.getProveedor().getRazonSocial());
        }*/
        
        
        LogroDAO daoLogro = new LogroMySQL();
        Logro logro = new Logro("Sobrevivir un dia", "Lograr sobrevivir un dia no es facil", juego2);
        if(daoLogro.insertarLogro(logro)!=0){
            System.out.println("Se realizo el registro del logro correctamente");
        }
        else{
            System.out.println("Error al realizar el registro");
        }
//        ArrayList<Logro> logros = daoLogro.listarLogros();
//        for(Logro logro: logros){
//            System.out.println(logro.getIdLogro() + ". " + logro.getNombre() + ": " + logro.getDescripcion());
//        }
//        Logro logro = daoLogro.buscarLogro(1);
//        logro.setDescripcion("Lograr sobrevivir un dia es facil");
//        if(daoLogro.actualizarLogro(logro)!=0){
//            System.out.println("Se actualizo el logro correctamente");
//        }
//        logro = daoLogro.buscarLogro(1);
//        System.out.println(logro.getIdLogro() + ". " + logro.getNombre() + ": " + logro.getDescripcion());

        
        
    }
}
