/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.steam.usuario.model;

import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.steam.biblioteca.model.Biblioteca;
import pe.edu.pucp.steam.comunidad.model.GestorSanciones;
import pe.edu.pucp.steam.comunidad.model.Foro;
import pe.edu.pucp.steam.comunidad.model.Mensaje;
import pe.edu.pucp.steam.inventario.model.Inventario;
import pe.edu.pucp.steam.perfil.model.Comentario;
import pe.edu.pucp.steam.perfil.model.Perfil;

/**
 *
 * @author GAMER
 */
public class Usuario {
    private int UID;
    private String nombreCuenta;
    private String nombrePerfil;
    private String correo;
    private String telefono;
    private String password;
    private int edad;
    private Date fechaNacimiento;
    private boolean verificado;
    private int expNivel;
    private int nivel;
    private int experiencia;
    private Pais pais;
    private Biblioteca biblioteca;
    private Notificacion notificaciones;
    private Inventario inventario;
    private ArrayList<Comentario> comentarios;
    private GestorSanciones gestorSanciones;
    private ArrayList<Mensaje> mensajes;
    private Perfil perfil;
    private ArrayList<Foro> foros;
    private ArrayList<Usuario> amigos;
    private ArrayList<Usuario> bloqueados;
}
