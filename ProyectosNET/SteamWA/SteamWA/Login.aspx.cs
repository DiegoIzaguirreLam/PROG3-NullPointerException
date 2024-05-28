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
            usuarioIngresado = daoUsuario.buscarUsuarioPorNombreCuenta(txtNombreCuenta.Text);
            // Existe el usuario
            if (usuarioIngresado.UID != 0)
            {
                // Contraseña coincide
                if (usuarioIngresado.password == txtPassword.Text)
                {
                    Session["usuario"] = usuarioIngresado;

                    Response.Redirect("Tienda.aspx");
                }
                else
                {
                    // Vuelve a pedir contraseña
                    txtPassword.Text = string.Empty;
                    lblMensajeExito.Visible = false;
                    lblMensajeError.Visible = true;
                    lblMensajeError.Text = "No ha ingresado correctamente su contraseña. Vuelva a intentarlo";
                }
            }
            else
            {
                // Muestra mensaje de error y pregunta si quiere volver a ingresar o dirigirse a pantalla de registro
                txtNombreCuenta.Text = string.Empty;
                txtPassword.Text = string.Empty;
                lblMensajeExito.Visible = false;
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Usuario inexistente. Vuelva a intentarlo";
            }
        }
    }
}