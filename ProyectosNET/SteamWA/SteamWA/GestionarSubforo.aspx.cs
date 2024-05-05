using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class GestionarSubforo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String nombre = Request.QueryString["subforo"];
            if (nombre != null)
            {
                nombreSubforo.Text = nombre;
            }
        }

        protected void btnCrearHilo_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-hilo') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }
    }
}