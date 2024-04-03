package Comunidad;
import java.util.Date;
import java.util.ArrayList;

public class Hilo{
	// Atributos propios de la clase
	private boolean fijado;
	private int nroMensajes;
	private Date fechaCreacion;
	private Date fechaModificacion;
	
	// Atributos de las relaciones
	private ArrayList<Mensaje> mensajes;
	private Subforo subforo;
	
	// Constructor
	public Hilo (boolean fijado){
		this.fijado = fijado;
		this.nroMensajes = 0;
		this.fechaCreacion = new Date();
		this.fechaModificacion = new Date();
	}
	
	// Setters y getters
	public void setFijado (boolean fijado){
		this.fijado = fijado;
	}
	
	public boolean getFijado (){
		return fijado;
	}
	
	public void setNroMensajes (int nroMensajes){
		this.nroMensajes = nroMensajes;
	}
	
	public int getNroMensajes (){
		return nroMensajes;
	}
	
	public void setFechaCreacion (Date fechaCreacion){
		this.fechaCreacion = fechaCreacion;
	}
	
	public Date getFechaCreacion (){
		return fechaCreacion;
	}
	
	public void setFechaModificacion (Date fechaModificacion){
		this.fechaModificacion = fechaModificacion;
	}
	
	public Date getFechaModificacion (){
		return fechaModificacion;
	}
	
	public void setMensajes (ArrayList<Mensaje> mensajes){
		this.mensajes = mensajes;
	}
	
	public ArrayList<Mensaje> getMensajes (){
		return mensajes;
	}
}