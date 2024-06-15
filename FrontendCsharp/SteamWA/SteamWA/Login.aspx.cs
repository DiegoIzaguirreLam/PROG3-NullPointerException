using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
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
            // No se ingresó nombre de cuenta
            if (txtNombreCuenta.Text.Trim() == "")
            {
                txtNombreCuenta.Text = string.Empty;
                txtPassword.Text = string.Empty;
                lblMensajeExito.Visible = false;
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Nombre de cuenta inválido. Intente de nuevo";
                return;
            }
            if (txtPassword.Text.Trim() == "")
            {
                txtNombreCuenta.Text = string.Empty;
                txtPassword.Text = string.Empty;
                lblMensajeExito.Visible = false;
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Contraseña inválida. Intente de nuevo";
                return;
            }

            usuarioIngresado = daoUsuario.verificarUsuario(txtNombreCuenta.Text, txtPassword.Text);

            // Si no existe el usuario
            if (usuarioIngresado.UID == 0)
            {
                // Muestra mensaje de error
                txtNombreCuenta.Text = string.Empty;
                txtPassword.Text = string.Empty;
                lblMensajeExito.Visible = false;
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "El usuario y/o la contraseña no son válidos. Intente de nuevo";
                return;
            }

            // Guardar el usuario, amigos y bloqueados en las variables de sesión
            Session["usuario"] = usuarioIngresado;
            Session["amigos"] = cargarAmigos(usuarioIngresado.UID);
            Session["bloqueados"] = cargarBloqueados(usuarioIngresado.UID);
            Session["logrosDesbloqueados"] = cargarLogrosDesbloqueados(usuarioIngresado.UID);

            // Redireccionar al usuario a la tienda
            Response.Redirect("Tienda.aspx");
        }

        /* 
         * Devuelve una BindingList<usuario> con los usuarios que son amigos
         * del usuario pasado por parámetro. Si el usuario no tiene amigos,
         * entonces, se devuelve una BindingList<usuario> vacía (0 elementos).
         */
        protected BindingList<usuario> cargarAmigos(int idUsuario)
        {
            // Se obtienen los amigos del usuario de la base de datos
            UsuarioWSClient daoUsuario = new UsuarioWSClient();
            usuario[] listaAmigos = daoUsuario.listarAmigosPorUsuario(idUsuario);

            return listaAmigos != null ?
                   new BindingList<usuario>(listaAmigos) :
                   new BindingList<usuario>();
        }

        /* 
         * Devuelve una BindingList<usuario> con los usuarios que fueron bloqueados por
         * el usuario pasado por parámetro. Si el usuario no tiene bloqueados,
         * entonces, se devuelve una BindingList<usuario> vacía (0 elementos).
         */
        protected BindingList<usuario> cargarBloqueados(int idUsuario)
        {
            // Se obtienen los bloqueados del usuario de la base de datos
            UsuarioWSClient daoUsuario = new UsuarioWSClient();
            usuario[] listaBloqueados = daoUsuario.listarBloqueadosPorUsuario(idUsuario);

            return listaBloqueados != null ?
                   new BindingList<usuario>(listaBloqueados) :
                   new BindingList<usuario>();
        }

        /* 
         * Devuelve una BindingList<usuario> con los usuarios que fueron bloqueados por
         * el usuario pasado por parámetro. Si el usuario no tiene bloqueados,
         * entonces, se devuelve una BindingList<usuario> vacía (0 elementos).
         */
        protected BindingList<logroDesbloqueado> cargarLogrosDesbloqueados(int idUsuario)
        {
            // Se obtienen los logros desbloqueados del usuario de la base de datos
            LogroDesbloqueadoWSClient daoLogros =
                new LogroDesbloqueadoWSClient();
            logroDesbloqueado[] listaLogrosDesbloqueados =
                daoLogros.listarLogrosPorUsuario(idUsuario);

            return listaLogrosDesbloqueados != null ?
                   new BindingList<logroDesbloqueado>(listaLogrosDesbloqueados) :
                   new BindingList<logroDesbloqueado>();
        }
    }
}