package Comunidad;
import java.util.ArrayList;

public class Subforo{
	// Atributos propios de la clase
	private String nombre;
	
	// Atributos de las relaciones
	private Foro foro;
	private ArrayList<Hilo> hilos;
	
	// Constructor
	public Subforo (String nombre, Foro foro){
		this.nombre = nombre;
		this.foro = foro;
	}
	
	// Setters y getters
	public void setNombre (String nombre){
		this.nombre = nombre;
	}
	
	public String getNombre (){
		return nombre;
	}
	
	public void setForo (Foro foro){
		this.foro = foro;
	}
	
	public Foro getForo (){
		return foro;
	}
	
	public void setHilos (ArrayList<Hilo> hilos){
		this.hilos = hilos;
	}
	
	public ArrayList<Hilo> getHilos (){
		return hilos;
	}
}