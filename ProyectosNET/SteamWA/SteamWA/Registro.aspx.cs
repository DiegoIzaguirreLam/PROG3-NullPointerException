using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Registro : System.Web.UI.Page
    {
        private UsuarioWSClient daoUsuario;
        private PaisWSClient daoPais;
        private usuario usuario;
        private BindingList<pais> paises;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_Init(object sender, EventArgs e)
        {
            daoUsuario = new UsuarioWSClient();
            daoPais = new PaisWSClient();
            paises = new BindingList<pais>(daoPais.listarPaises().ToList());
            ddlPaises.DataTextField = "nombre";
            ddlPaises.DataValueField = "idPais";
            ddlPaises.DataSource = paises;
            ddlPaises.DataBind();
        }
        protected void lbRegistrar_Click(object sender, EventArgs e)
        {
            usuario usuarioNuevo = daoUsuario.buscarUsuarioPorNombreCuenta(txtNombreCuenta.Text);
            // Solo si no existe el nombre de cuenta
            if (usuarioNuevo.UID == 0)
            {
                usuario = new usuario();
                usuario.nombreCuenta = txtNombreCuenta.Text;
                usuario.nombrePerfil = txtNombrePerfil.Text;
                usuario.password = txtContrasenia.Text;
                usuario.correo = txtCorreo.Text;
                usuario.fechaNacimientoSpecified = true;
                usuario.fechaNacimiento = DateTime.Parse(txtFechaNacimiento.Text);
                usuario.telefono = txtTelefono.Text;
                usuario.edad = Int32.Parse(txtEdad.Text);
                usuario.pais = new pais();
                usuario.pais.idPais = Int32.Parse(ddlPaises.SelectedValue);
                int resultado = daoUsuario.insertarUsuario(usuario);
                if (resultado != 0)
                {
                    Response.Redirect("Login.aspx?accion=registrado");
                }
                else
                {
                    lblMensajeError.Visible = true;
                    lblMensajeError.Text = "Ocurrió un error. Vuelva a intentarlo";
                }
            }
            else
            {
                // Mostrar mensaje de error
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Nombre de cuenta ya existente. Intente con otro nombre";
                txtNombreCuenta.Text = string.Empty;
            }
        }
    }
}