using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Configuracion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnRegresar_Click(object sender, EventArgs e)
        {

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Configuracion.aspx");
        }

        protected void lbEditarNombreCuenta_Click(object sender, EventArgs e)
        {
            txtNombreCuenta.Enabled = true;
        }

        protected void lbEditarNombrePerfil_Click(object sender, EventArgs e)
        {
            txtNombrePerfil.Enabled = true;
        }

        protected void lbEditarCorreo_Click(object sender, EventArgs e)
        {
            txtCorreo.Enabled = true;
        }

        protected void lbEditarTelefono_Click(object sender, EventArgs e)
        {
            txtTelefono.Enabled = true;
        }

        protected void lbEditarFechaNacimiento_Click(object sender, EventArgs e)
        {
            dtpFechaNacimiento.Disabled = false;
        }

        protected void lbEditarPais_Click(object sender, EventArgs e)
        {
            ddlPaises.Enabled = true;
        }
    }
}