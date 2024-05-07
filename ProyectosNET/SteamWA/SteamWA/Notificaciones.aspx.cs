using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Notificaciones : System.Web.UI.Page
    {
        private DataTable dtNotificaciones = new DataTable();
        protected void Page_Init(object sender, EventArgs e)
        {
            dtNotificaciones.Columns.Add("IdNotificacion", typeof(string));
            dtNotificaciones.Columns.Add("TipoNotificacion", typeof(string));
            dtNotificaciones.Columns.Add("Mensaje", typeof(string));
            dtNotificaciones.Columns.Add("Revisada", typeof(bool));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Datos para simulación
                // Crear un DataTable para almacenar los datos de las notificaciones
                dtNotificaciones.Rows.Add("1", "Notificación 1", "Mensaje1", false);
                dtNotificaciones.Rows.Add("2", "Notificación 2", "Mensaje2", true);
                dtNotificaciones.Rows.Add("3", "Notificación 3", "Mensaje3", true);

                // Vincular el DataTable al ListView
                lvNotificaciones.DataSource = dtNotificaciones;
                lvNotificaciones.DataBind();
            }
        }


        protected void ExpandirNotificacion_Click(object sender, EventArgs e)
        {
            string idNotificacion = ((LinkButton)sender).CommandArgument;
            // Busca en las notificaciones del usuario
            // Verifica si se encontró la información de la notificación

            string tipoNotificacion = "Amigos";
            string mensaje = "Hola";

            string script = $"window.onload = function() {{mostrarNotificacion('{tipoNotificacion}', '{mensaje}')}};";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }
    }
}