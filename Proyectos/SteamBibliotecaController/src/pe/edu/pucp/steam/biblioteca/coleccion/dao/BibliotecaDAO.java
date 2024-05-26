/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.steam.biblioteca.coleccion.dao;

import pe.edu.pucp.steam.biblioteca.coleccion.model.Biblioteca;

/**
 *
 * @author GAMER
 */
public interface BibliotecaDAO {
    int asignarBibliotecaUsuario(int UID);
    Biblioteca buscarBiblioteca(int idUser);
}