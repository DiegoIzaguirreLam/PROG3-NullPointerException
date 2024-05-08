using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class GestionarColeccion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        protected void btnEliminarColeccion_OnClick(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-EliminarColeccion') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }
        protected void btnCancelar_OnClick(object sender, EventArgs e)
        {
            Response.Redirect("Biblioteca.aspx");
        }

        protected void btnGuardar_OnClick(object sender, EventArgs e)
        {
            //por implementar
            Response.Redirect("Biblioteca.aspx");
        }

        protected void btnEliminar_OnClick(object sender, EventArgs e)
        {
            //por implementar
            Response.Redirect("Biblioteca.aspx");
        }
    }
}