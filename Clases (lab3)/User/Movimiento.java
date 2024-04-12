package User;

import java.util.Date;
import java.util.ArrayList;

public class Movimiento {
	private int idMovimiento;
	private String idTransaccion;
	private Date fechaMovimiento;
	private double monto;
	private TipoMovimiento tipo;
    	private MetodoPago metodoPago;
	private ArrayList<ProductoAdquirido> productosAdquiridos;
	
}
