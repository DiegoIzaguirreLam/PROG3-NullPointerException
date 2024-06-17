package pe.edu.pucp.steam.usuario.personal.model;

import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.steam.biblioteca.coleccion.model.Biblioteca;
import pe.edu.pucp.steam.comunidad.model.GestorSanciones;
import pe.edu.pucp.steam.comunidad.model.Foro;
import pe.edu.pucp.steam.comunidad.model.Mensaje;
import pe.edu.pucp.steam.usuario.jugador.model.Cartera;

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
    private boolean activo;
    private String fotoURL;
    private Pais pais;
    private Biblioteca biblioteca;
    private ArrayList<Notificacion> notificaciones;
    private GestorSanciones gestorSanciones;
    private ArrayList<Mensaje> mensajes;
    private ArrayList<Foro> foros;
    private ArrayList<Usuario> amigos;
    private ArrayList<Usuario> bloqueados;
    private Cartera cartera;

    public Usuario(){};

    public Usuario(int UID, String nombreCuenta, String nombrePerfil, String correo, String telefono, String password, int edad, Date fechaNacimiento, boolean verificado, boolean activo, Pais pais, Biblioteca biblioteca, GestorSanciones gestorSanciones, Cartera cartera) {
        this.UID = UID;
        this.nombreCuenta = nombreCuenta;
        this.nombrePerfil = nombrePerfil;
        this.correo = correo;
        this.telefono = telefono;
        this.password = password;
        this.edad = edad;
        this.fechaNacimiento = fechaNacimiento;
        this.verificado = verificado;
        this.activo = activo;
        this.pais = pais;
        this.biblioteca = biblioteca;
        this.gestorSanciones = gestorSanciones;
        this.cartera = cartera;
    }

    public Usuario(int UID, String nombreCuenta, String nombrePerfil, String correo, String telefono, String password, int edad, Date fechaNacimiento, boolean verificado) {
        this.UID = UID;
        this.nombreCuenta = nombreCuenta;
        this.nombrePerfil = nombrePerfil;
        this.correo = correo;
        this.telefono = telefono;
        this.password = password;
        this.edad = edad;
        this.fechaNacimiento = fechaNacimiento;
        this.verificado = verificado;
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

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
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

    public ArrayList<Notificacion> getNotificaciones() {
        return notificaciones;
    }

    public void setNotificaciones(ArrayList<Notificacion> notificaciones) {
        this.notificaciones = notificaciones;
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

    public Cartera getCartera() {
        return cartera;
    }

    public void setCartera(Cartera cartera) {
        this.cartera = cartera;
    }

    public String getFotoURL() {
        return fotoURL;
    }

    public void setFotoURL(String fotoURL) {
        this.fotoURL = fotoURL;
    }
}