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
            // Validar otros campos
            if (!validarCampo(txtNombreCuenta, "un nombre de cuenta válido", usuario.nombreCuenta) ||
                !validarCampo(txtNombrePerfil, "un nombre de perfil válido", usuario.nombrePerfil) ||
                !validarCampo(txtCorreo, "un correo electrónico válido", usuario.correo) ||
                !validarCampo(txtTelefono, "un número de teléfono válido", usuario.telefono.ToString()) ||
                !validarCampo(txtFechaNacimiento, "una fecha válida", usuario.fechaNacimiento.ToString("yyyy-MM-dd"))
                )
                return;
            
            // Validar url
            if (!string.IsNullOrEmpty(txtURL.Text) && !urlValida(txtURL.Text))
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

        public bool validarCampo(TextBox campo, string mensaje, string valorValido)
        {
            string valorCampo = campo.Text.Trim();
            if (valorCampo == "")
            {
                lblMensajeError.Visible = true;
                lblMensajeError.Text = "Valor inválido. Por favor, ingrese " + mensaje;
                campo.Text = valorValido;
                return false;
            }
            return true;
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
            // Se cambia el valor si es que se escribió algo, de lo contrario se asigna url por defecto
            if (!string.IsNullOrEmpty(txtURL.Text))
                usuario.fotoURL = txtURL.Text;
            else usuario.fotoURL = "https://i.imgur.com/c7tUWcg.png";
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