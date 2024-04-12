package User;

import java.util.ArrayList;
import Biblioteca.Biblioteca;
import Comunidad.Foro;
import Comunidad.Mensaje;
import Perfil.Perfil;
import Perfil.Comentario;
import Inventario.Inventario;

public class Usuario {
	private static int correlativo;
	private int UID;
	private String nombreCuenta;
	private String correo;
	private String telefono;
	private String password;
	private Pais pais;
	private boolean verificado;
	private Biblioteca biblioteca;
	private ArrayList<Foro> foros;
	private Perfil perfil;
	private ArrayList<Mensaje> mensajes;
	private ArrayList<Comentario> comentarios;
	private Inventario inventario;
	private ArrayList<Notificacion> notificaciones;
	
	
}
