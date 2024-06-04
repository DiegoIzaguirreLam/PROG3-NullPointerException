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
        private BibliotecaWSClient daoBiblioteca;
        private CarteraWSClient daoCartera;
        private PerfilWSClient daoPerfil;
        private GestorSancionesWSClient daoGestorSanciones;
        private usuario usuario;
        private BindingList<pais> paises;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_Init(object sender, EventArgs e)
        {
            daoUsuario = new UsuarioWSClient();
            daoPais = new PaisWSClient();
            daoBiblioteca = new BibliotecaWSClient();
            daoCartera = new CarteraWSClient();
            daoPerfil = new PerfilWSClient();
            daoGestorSanciones = new GestorSancionesWSClient();
            paises = new BindingList<pais>(daoPais.listarPaises().ToList());
            ddlPaises.DataTextField = "nombre";
            ddlPaises.DataValueField = "idPais";
            ddlPaises.DataSource = paises;
            ddlPaises.DataBind();
        }
        protected void lbRegistrar_Click(object sender, EventArgs e)
        {
            string nombreCuenta = txtNombreCuenta.Text.Trim();
            string nombrePerfil = txtNombrePerfil.Text.Trim();
            if (nombreCuenta != "" && nombrePerfil!="")
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
                    usuario.edad = DateTime.Today < usuario.fechaNacimiento ? (DateTime.Today.Year - usuario.fechaNacimiento.Year) : (DateTime.Today.Year - usuario.fechaNacimiento.Year - 1);
                    usuario.pais = new pais();
                    usuario.pais.idPais = Int32.Parse(ddlPaises.SelectedValue);
                    int UID = daoUsuario.insertarUsuario(usuario);
                    if (UID != 0)
                    {
                        int r1 = daoBiblioteca.asignarBibliotecaUsuario(UID);
                        int r2 = daoCartera.asignarCarteraUsuario(UID);
                        int r3 = daoPerfil.asignarPerfilUsuario(UID);
                        int r4 = daoGestorSanciones.asignarGestorUsuario(UID);
                        Response.Redirect("Login.aspx?accion=registrado");
                    }
                    //else
                    //{
                    //    lblMensajeError.Visible = true;
                    //    lblMensajeError.Text = "Ocurrió un error. Vuelva a intentarlo";
                    //}
                }
                else
                {
                    // Mostrar mensaje de error
                    lblMensajeError.Visible = true;
                    lblMensajeError.Text = "Nombre de cuenta ya existente. Intente con otro nombre";
                    txtNombreCuenta.Text = string.Empty;
                }
            }
            else
            {
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Por favor, ingrese un nombre válido para el nombre de cuenta y/o perfil";
                txtNombreCuenta.Text = string.Empty;
                txtNombrePerfil.Text = string.Empty;
            }
        }
    }
}