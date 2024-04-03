package Comunidad;
import java.util.Date;
import java.util.ArrayList;
import User.Usuario;

public class Mensaje{
	// Atributos propios de la clase
	private String contenido;
	private Date fechaPublicacion;
	
	// Atributos de las relaciones
	private Hilo hilo;
	private Usuario autor;
	private Mensaje padre;
	private ArrayList<Mensaje> respuestas;
	
	// Constructor
	public Mensaje (String contenido, Usuario autor){
		this.contenido = contenido;
		this.autor = autor;
	}
	
	// Setters y getters
	public void setContenido (String contenido){
		this.contenido = contenido;
	}
	
	public String getContenido (){
		return contenido;
	}
	
	public void setFechaPublicacion (Date fechaPublicacion){
		this.fechaPublicacion = fechaPublicacion;
	}
	
	public Date getFechaPublicacion (){
		return fechaPublicacion;
	}
	
	public void setHilo (Hilo hilo){
		this.hilo = hilo;
	}
	
	public Hilo getHilo (){
		return hilo;
	}
	
	public void setAutor (Usuario autor){
		this.autor = autor;
	}
	
	public Usuario getAutor (){
		return autor;
	}
	
	public void setPadre (Mensaje padre){
		this.padre = padre;
	}
	
	public Mensaje getPadre (){
		return padre;
	}
	
	public void setRespuestas (ArrayList<Mensaje> respuestas){
		this.respuestas = respuestas;
	}
	
	public ArrayList<Mensaje> getRespuestas (){
		return respuestas;
	}
	
}