using SteamWA.SteamServiceWS;
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
        private UsuarioWSClient daoUsuario;
        private usuario usuarioIngresado;
        protected void Page_Load(object sender, EventArgs e)
        {
            String accion = Request.QueryString["accion"];
            if (accion != null && accion == "registrado")
            {
                lblMensajeExito.Visible = true;
                lblMensajeExito.Text = "¡Registro exitoso!";
            }
            if (!IsPostBack)
            {
                lblMensajeError.Visible = false;
                txtPassword.Text = string.Empty;
                txtNombreCuenta.Text = string.Empty;
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            daoUsuario = new UsuarioWSClient();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtNombreCuenta.Text.Trim() != "")
            {
                usuarioIngresado = daoUsuario.verificarUsuario(txtNombreCuenta.Text, txtPassword.Text);
                // Existe el usuario
                if (usuarioIngresado.UID != 0)
                {
                    Session["usuario"] = usuarioIngresado;
                    Response.Redirect("Tienda.aspx");
                }
                else
                {
                    // Muestra mensaje de error
                    txtNombreCuenta.Text = string.Empty;
                    txtPassword.Text = string.Empty;
                    lblMensajeExito.Visible = false;
                    lblMensajeError.Visible = true;
                    lblMensajeError.Text = "El usuario y/o la contraseña no son válidos. Intente de nuevo";
                }
            }
            else
            {
                txtNombreCuenta.Text = string.Empty;
                txtPassword.Text = string.Empty;
                lblMensajeExito.Visible = false;
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Nombre de cuenta inválido. Intente de nuevo";
            }
        }
    }
}