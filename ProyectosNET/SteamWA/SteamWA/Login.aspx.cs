using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_Init(object sender, EventArgs e)
        {
            String accion = Request.QueryString["accion"];
            if (accion != null && accion == "registrado")
            {
                lblMensajeExito.Visible = true;
                lblMensajeExito.Text = "¡Registro exitoso!";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Tienda.aspx");
        }
    }
}