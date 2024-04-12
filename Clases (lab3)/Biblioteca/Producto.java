package Biblioteca;

import java.util.Date;
import java.util.ArrayList;
import User.Proveedor;

public class Producto {
	private static int correlativo;
	private int idProducto;
	private String titulo;
	private Date fechaPublicacion;
	private double precio;
	private String descripcion;
	private double espacioDisco;
	private ArrayList<Proveedor> desarrolladores;
	private ArrayList<Proveedor> publicadores;
	
}
