using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Net;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Configuracion : System.Web.UI.Page
    {
        private usuario usuario;
        private UsuarioWSClient daoUsuario;
        private PaisWSClient daoPais;
        private BindingList<usuario> usuarios;
        private BindingList<pais> paises;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = (usuario)Session["usuario"];
            if (!IsPostBack)
            {
                CargarDatosUsuario();
                Session["cuentaOriginal"] = usuario.nombreCuenta; // Registrar el nombre de cuenta original
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            daoUsuario = new UsuarioWSClient();
            daoPais = new PaisWSClient();
            paises = new BindingList<pais>(daoPais.listarPaises().ToList());
            usuarios = new BindingList<usuario>(daoUsuario.listarUsuarios().ToList());
            ddlPaises.DataTextField = "nombre";
            ddlPaises.DataValueField = "idPais";
            ddlPaises.DataSource = paises;
            ddlPaises.DataBind();
        }

        public void CargarDatosUsuario()
        {
            txtUID.Text = usuario.UID.ToString();
            txtNombreCuenta.Text = usuario.nombreCuenta;
            txtNombrePerfil.Text = usuario.nombrePerfil;
            txtCorreo.Text = usuario.correo;
            txtTelefono.Text = usuario.telefono;
            txtFechaNacimiento.Text = usuario.fechaNacimiento.ToString("yyyy-MM-dd");
            txtURL.Text = usuario.fotoURL;
            ListItem item = ddlPaises.Items.FindByText(usuario.pais.nombre);
            if (item != null)
            {
                item.Selected = true;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtNombreCuenta.Text.Trim()))
            {
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Nombre de cuenta inválido. Por favor ingrese otro nombre de cuenta.";
                txtNombreCuenta.Text = usuario.nombreCuenta;
                return;
            }
            if (string.IsNullOrEmpty(txtNombrePerfil.Text.Trim()))
            {
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Nombre de perfil inválido. Por favor ingrese otro nombre de perfil.";
                txtNombrePerfil.Text = usuario.nombrePerfil;
                return;
            }
            if (string.IsNullOrEmpty(txtCorreo.Text.Trim()))
            {
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Correo electrónico inválido. Por favor ingrese otro correo.";
                txtCorreo.Text = usuario.correo;
                return;
            }
            if (string.IsNullOrEmpty(txtTelefono.Text.Trim()))
            {
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Telefono inválido. Por favor ingrese otro correo.";
                txtCorreo.Text = usuario.telefono.ToString();
                return;
            }
            if (!urlValida(txtURL.Text))
            {
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "La dirección URL no apunta a una imagen válida.";
                txtURL.Text = usuario.fotoURL;
                return;
            }
            // Verificar si el nombre de cuenta ha cambiado
            if (txtNombreCuenta.Text != (string)Session["cuentaOriginal"])
            {
                // Realizar la verificación en la base de datos solo si el nombre de cuenta ha cambiado
                usuario usuarioRepetido = usuarios.SingleOrDefault(u => u.nombreCuenta == txtNombreCuenta.Text);
                if (usuarioRepetido != null)
                {
                    lblMensajeError.Visible = true;
                    lblMensajeError.Text = "El nombre de cuenta ya está en uso. Por favor, elija otro.";
                    txtNombreCuenta.Text = string.Empty;
                    return; // Salir del evento sin guardar si se encuentra un nombre de cuenta duplicado
                }
            }
            // Continuar con el proceso de guardado si no se encontró ningún nombre de cuenta duplicado
            lblMensajeError.Visible = false;
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
            txtFechaNacimiento.Enabled = true;
            ddlPaises.Enabled = true;
            txtURL.Enabled = true;
            btnValidarImagen.Enabled = true;
            btnGuardar.Visible = true;
            btnEditar.Visible = false;
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Configuracion.aspx");
        }

        protected void btnGuardarModal_Click(object sender, EventArgs e)
        {
            usuario.nombreCuenta = txtNombreCuenta.Text;
            usuario.nombrePerfil = txtNombrePerfil.Text;
            usuario.correo = txtCorreo.Text;
            usuario.fechaNacimientoSpecified = true;
            usuario.fechaNacimiento = DateTime.Parse(txtFechaNacimiento.Text);
            usuario.telefono = txtTelefono.Text;
            usuario.edad = DateTime.Today < usuario.fechaNacimiento ? (DateTime.Today.Year - usuario.fechaNacimiento.Year) : (DateTime.Today.Year - usuario.fechaNacimiento.Year - 1);
            usuario.pais = new pais();
            usuario.pais.idPais = Int32.Parse(ddlPaises.SelectedValue);
            // Solo se cambia el valor si es que se escribió algo
            if (!string.IsNullOrEmpty(txtURL.Text))
                usuario.fotoURL = txtURL.Text;
            int resultado = daoUsuario.actualizarUsuario(usuario);
            Response.Redirect("Configuracion.aspx");
        }

        protected void lbValidarImagen_Click(object sender, EventArgs e)
        {
            // Sirve para previsualizar
            modalImagen.ImageUrl = txtURL.Text;
            string script = "window.onload = function() { showModalForm('form-modal-mostrarImagen') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        private bool urlValida(string url)
        {
            try
            {
                var request = (HttpWebRequest)WebRequest.Create(url);
                request.Method = "HEAD";
                using (var response = (HttpWebResponse)request.GetResponse())
                {
                    return response.ContentType.ToLower().StartsWith("image/");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
        }

        protected void btnCancelarModal_Click(object sender, EventArgs e)
        {
            Response.Redirect("Configuracion.aspx");
        }
    }
}