package Biblioteca;

import java.time.LocalTime;
import java.util.Date;
import java.util.ArrayList;

public class ProductoAdquirido extends Producto implements Consultable {
    private Producto producto;
	private Date fechaAdquisicion;
    private Date fechaEjecutado;
    private LocalTime tiempoUso;
    private boolean actualizado;
	private ArrayList<LogroDesbloqueado> desbloqueados;
	
    public void consultarDatos() {
        // metodo a implementar
    }

}