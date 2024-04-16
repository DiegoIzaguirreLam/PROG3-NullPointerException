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
import pe.edu.pucp.steam.usuario.model.jugador.Cartera;
import pe.edu.pucp.steam.usuario.model.jugador.Medalla;

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
    private boolean activo;
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
    private ArrayList<Medalla> medallas;
    private Cartera cartera;

    public Usuario(String nombreCuenta, String nombrePerfil, String correo, String telefono, String password, int edad, Date fechaNacimiento, boolean verificado, int expNivel, int nivel, boolean activo, int experiencia, Pais pais, Biblioteca biblioteca, Notificacion notificaciones, Inventario inventario, ArrayList<Comentario> comentarios, GestorSanciones gestorSanciones, ArrayList<Mensaje> mensajes, Perfil perfil, ArrayList<Foro> foros, ArrayList<Usuario> amigos, ArrayList<Usuario> bloqueados, ArrayList<Medalla> medallas, Cartera cartera) {
        this.nombreCuenta = nombreCuenta;
        this.nombrePerfil = nombrePerfil;
        this.correo = correo;
        this.telefono = telefono;
        this.password = password;
        this.edad = edad;
        this.fechaNacimiento = fechaNacimiento;
        this.verificado = verificado;
        this.expNivel = expNivel;
        this.nivel = nivel;
        this.activo = activo;
        this.experiencia = experiencia;
        this.pais = pais;
        this.biblioteca = biblioteca;
        this.notificaciones = notificaciones;
        this.inventario = inventario;
        this.comentarios = comentarios;
        this.gestorSanciones = gestorSanciones;
        this.mensajes = mensajes;
        this.perfil = perfil;
        this.foros = foros;
        this.amigos = amigos;
        this.bloqueados = bloqueados;
        this.medallas = medallas;
        this.cartera = cartera;
    }

    

    public int getUID() {
        return UID;
    }

    public void setUID(int UID) {
        this.UID = UID;
    }

    public String getNombreCuenta() {
        return nombreCuenta;
    }

    public void setNombreCuenta(String nombreCuenta) {
        this.nombreCuenta = nombreCuenta;
    }

    public String getNombrePerfil() {
        return nombrePerfil;
    }

    public void setNombrePerfil(String nombrePerfil) {
        this.nombrePerfil = nombrePerfil;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public Date getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public boolean isVerificado() {
        return verificado;
    }

    public void setVerificado(boolean verificado) {
        this.verificado = verificado;
    }

    public int getExpNivel() {
        return expNivel;
    }

    public void setExpNivel(int expNivel) {
        this.expNivel = expNivel;
    }

    public int getNivel() {
        return nivel;
    }

    public void setNivel(int nivel) {
        this.nivel = nivel;
    }

    public boolean getActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    
    
    public int getExperiencia() {
        return experiencia;
    }

    public void setExperiencia(int experiencia) {
        this.experiencia = experiencia;
    }

    public Pais getPais() {
        return pais;
    }

    public void setPais(Pais pais) {
        this.pais = pais;
    }

    public Biblioteca getBiblioteca() {
        return biblioteca;
    }

    public void setBiblioteca(Biblioteca biblioteca) {
        this.biblioteca = biblioteca;
    }

    public Notificacion getNotificaciones() {
        return notificaciones;
    }

    public void setNotificaciones(Notificacion notificaciones) {
        this.notificaciones = notificaciones;
    }

    public Inventario getInventario() {
        return inventario;
    }

    public void setInventario(Inventario inventario) {
        this.inventario = inventario;
    }

    public ArrayList<Comentario> getComentarios() {
        return comentarios;
    }

    public void setComentarios(ArrayList<Comentario> comentarios) {
        this.comentarios = comentarios;
    }

    public GestorSanciones getGestorSanciones() {
        return gestorSanciones;
    }

    public void setGestorSanciones(GestorSanciones gestorSanciones) {
        this.gestorSanciones = gestorSanciones;
    }

    public ArrayList<Mensaje> getMensajes() {
        return mensajes;
    }

    public void setMensajes(ArrayList<Mensaje> mensajes) {
        this.mensajes = mensajes;
    }

    public Perfil getPerfil() {
        return perfil;
    }

    public void setPerfil(Perfil perfil) {
        this.perfil = perfil;
    }

    public ArrayList<Foro> getForos() {
        return foros;
    }

    public void setForos(ArrayList<Foro> foros) {
        this.foros = foros;
    }

    public ArrayList<Usuario> getAmigos() {
        return amigos;
    }

    public void setAmigos(ArrayList<Usuario> amigos) {
        this.amigos = amigos;
    }

    public ArrayList<Usuario> getBloqueados() {
        return bloqueados;
    }

    public void setBloqueados(ArrayList<Usuario> bloqueados) {
        this.bloqueados = bloqueados;
    }

    public ArrayList<Medalla> getMedallas() {
        return medallas;
    }

    public void setMedallas(ArrayList<Medalla> medallas) {
        this.medallas = medallas;
    }

    public Cartera getCartera() {
        return cartera;
    }

    public void setCartera(Cartera cartera) {
        this.cartera = cartera;
    }
    
    
}
