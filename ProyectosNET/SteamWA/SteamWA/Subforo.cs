using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SteamWA
{
    public class Subforo
    {
        int idSubforo;
        string nombre;
        string mensaje;

        public Subforo(int idSubforo, string nombre, string mensaje)
        {
            this.IdSubforo = idSubforo;
            this.Nombre = nombre;
            this.Mensaje = mensaje;
        }

        public int IdSubforo { get => idSubforo; set => idSubforo = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Mensaje { get => mensaje; set => mensaje = value; }
    }
}