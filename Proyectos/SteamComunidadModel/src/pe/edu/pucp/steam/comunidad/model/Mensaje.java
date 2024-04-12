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
public class Mensaje {
    private int idMensaje;
    private int idAutor; //ID del usuario
    private String contenido;
    private Date fechaPublicacion;
    private ArrayList<Mensaje> respuestas;
    private Hilo hilo;
}
