using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SteamWA
{
    public class Foro
    {
        private int idForo;
        private string nombre;
        private string descripcion;
        private string usuario; //Esto en java se hallará buscando al user en la bd (Es el creador)
        private string fotoPerfil; //Esto se buscará en el perfil que será un link

        public Foro(int idForo, string nombre, string descripcion, string usuario, string fotoPerfil)
        {
            this.IdForo = idForo;
            this.Nombre = nombre;
            this.Descripcion = descripcion;
            this.Usuario = usuario;
            this.FotoPerfil = fotoPerfil;
        }

        public int IdForo { get => idForo; set => idForo = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
        public string Usuario { get => usuario; set => usuario = value; }
        public string FotoPerfil { get => fotoPerfil; set => fotoPerfil = value; }
    }
}