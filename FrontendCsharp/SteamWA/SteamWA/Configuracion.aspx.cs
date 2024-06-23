using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
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
                Session["fotoEditada"] = null;
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

            if (fileUpdloadFotoPerfil.HasFile && !validarFoto(usuario.nombreCuenta)) return;

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

        public bool validarFoto(string nombreCuenta)
        {
            string extension = System.IO.Path.GetExtension(fileUpdloadFotoPerfil.FileName);
            if (extension.ToLower() == ".jpg" || extension.ToLower() == ".jpeg" || extension.ToLower() == ".png" || extension.ToLower() == ".gif")
            {
                // Guardar el archivo temporalmente en el servidor
                string filename = nombreCuenta + "Foto" + extension;
                string tempFilePath = Server.MapPath("~/Uploads/Temp/") + filename;
                fileUpdloadFotoPerfil.SaveAs(tempFilePath);

                // Guardar la información del archivo en la sesión
                Session["nombreArchivoTemp"] = filename;
                return true;
            }
            lblMensajeError.Visible = true;
            lblMensajeError.Text = "Valor inválido. Por favor, selecciona un archivo de imagen válido.";
            return false;
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
            string script = "window.onload = function() { showModalForm('form-modal-Editar') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
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
            //usuario.pais = new pais();
            //usuario.pais.idPais = Int32.Parse(ddlPaises.SelectedValue);
            int idPais = Int32.Parse(ddlPaises.SelectedValue);
            pais pais = paises.SingleOrDefault(x => x.idPais == idPais);
            usuario.pais = pais;
            Session["moneda"] = pais.moneda;
            bool estado = (bool)Session["fotoEditada"];

            if (estado)
            {
                // En caso no se haya subido nada se le asigna la foto por defecto
                if (Session["nombreArchivoTemp"] != null)
                {
                    string filename = Session["nombreArchivoTemp"].ToString();

                    // Mover el archivo desde la ubicación temporal a la final
                    string finalFilePath = Server.MapPath("~/Uploads/Perfiles/") + filename;
                    string tempFilePath = Server.MapPath("~/Uploads/Temp/") + filename;

                    // Primero se verifica si ya existe el archivo y se elimina
                    if (File.Exists(finalFilePath))
                        File.Delete(finalFilePath);

                    // Mover el archivo
                    File.Move(tempFilePath, finalFilePath);

                    // Actualizar la URL de la foto en el objeto usuario y en la sesión
                    usuario.fotoURL = "Uploads/Perfiles/" + filename;
                }
                else usuario.fotoURL = "Uploads/Perfiles/FotoPorDefecto.jpg";
            }
            
            int resultado = daoUsuario.actualizarUsuario(usuario);
            limpiarInformacionTemporal();
            Response.Redirect("Configuracion.aspx");
        }

        public void limpiarInformacionTemporal()
        {
            // Eliminar la información temporal del archivo
            if (Session["nombreArchivoTemp"] != null)
            {
                string tempFilePath = Server.MapPath("~/Uploads/Temp/") + Session["nombreArchivoTemp"].ToString();
                if (File.Exists(tempFilePath)) 
                    File.Delete(tempFilePath);
            }
            // Limpiar las variables de sesión
            Session.Remove("nombreArchivoTemp");
        }

        protected void btnCancelarModal_Click(object sender, EventArgs e)
        {
            limpiarInformacionTemporal();
            Response.Redirect("Configuracion.aspx");
        }

        protected void btnNo_Click(object sender, EventArgs e)
        {
            camposEditables();
            Session["fotoEditada"] = false;
        }

        protected void btnSi_Click(object sender, EventArgs e)
        {
            camposEditables();
            PanelImagen.Visible = true;
            Session["fotoEditada"] = true;
        }

        public void camposEditables()
        {
            txtNombreCuenta.Enabled = true;
            txtNombrePerfil.Enabled = true;
            txtCorreo.Enabled = true;
            txtTelefono.Enabled = true;
            txtTelefono.Enabled = true;
            txtFechaNacimiento.Enabled = true;
            ddlPaises.Enabled = true;
            btnGuardar.Visible = true;
            btnEditar.Visible = false;
        }
    }
}