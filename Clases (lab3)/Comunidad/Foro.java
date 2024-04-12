package Comunidad;
import java.util.ArrayList;

public class Foro{
	// Atributos propios de la clase
	private String idForo;
	private String nombre;
	private String descripcion;
	private OrigenForo origen;
	
	// Atributos de relaciones
	private ArrayList<Subforo> subforos;
	private ArrayList<Usuario> miembros;
	
	// Constructor
	public Foro (String idForo, String nombre, String descripcion, OrigenForo origen){
		this.idForo = idForo;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.origen;
	}
	
	// Setters y getters
	private void setIdForo(String idForo){
		this.idForo = idForo;
	}
	
	private String getIdForo (){
		return idForo;
	}
	
	private void setNombre (String nombre){
		this.nombre = nombre;
	}
	
	private String getNombre (){
		return nombre;
	}
	
	private void setDescripcion (String descripcion){
		this.descripcion = descripcion;
	}
	
	private String getDescripcion (){
		return descripcion;
	}
	
	private void setOrigenForo (OrigenForo origen){
		this.origen = origen;
	}
	
	private OrigenForo getOrigenForo (){
		return origen;
	}
	
	public void setSubforos(ArrayList<Subforo> subforos){
		this.subforos = subforos;
	}
	
	public ArrayList<Subforo> getSubforos(){
		return subforos;
	}
	
	public void setMiembros(ArrayList<Usuario> miembros){
		this.miembros = miembros;
	}
	
	public ArrayList<Usuario> getMiembros(){
		return miembros;
	}
}