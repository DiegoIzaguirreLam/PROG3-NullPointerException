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
        /*
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
        */

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Configuracion.aspx");
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-GuardarCambios') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            txtNombreCuenta.Enabled = true;
            txtNombrePerfil.Enabled = true;
            txtCorreo.Enabled = true;
            txtTelefono.Enabled = true;
            txtTelefono.Enabled = true;
            dtpFechaNacimiento.Disabled = false;
            ddlPaises.Enabled = true;
        }
    }
}