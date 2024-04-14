/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.comunidad.model;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author GAMER
 */
public class Hilo {
    private int idHilo;
    private boolean fijado;
    private int nroMensajes;
    private Date fechaCreacion;
    private Date fechaModificacion;
    private Subforo subforo;
    private ArrayList<Mensaje> mensajes;
}
