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
    public partial class BuscarAmigos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbBuscarPorID_Click(object sender, EventArgs e)
        {
            int idUsuario = ((usuario)Session["usuario"]).UID;
            int idBuscado = Int32.Parse(txtUID.Text);

            if (idBuscado == idUsuario)
            {
                lblMensajeID.Text = $"Error: el ID {idBuscado} es tu ID.";
                lblMensajeID.Visible = true;
                return;
            }

            UsuarioWSClient usuarioDao = new UsuarioWSClient();

            BindingList<usuario> usuarios = new BindingList<usuario>();
            usuario usuarioEncontrado = usuarioDao.buscarUsuarioPorId(idBuscado);

            if (usuarioEncontrado == null)
            {
                lblMensajeID.Text = $"No hay usuarios con ID {idBuscado}";
                lblMensajeID.Visible = true;
                return;
            }

            BindingList<usuario> amigos = (BindingList<usuario>) Session["amigos"];

            if (amigos.Any(amigo => amigo.UID == usuarioEncontrado.UID))
            {
                lblMensajeID.Text = $"Ya tienes como amigo al ID {idBuscado}";
                lblMensajeID.Visible = true;
                return;
            }

            usuarios.Add(usuarioEncontrado);
            gvUsuarios.DataSource = usuarios;
            gvUsuarios.DataBind();
            lblMensajeNombre.Visible = false;
            lblMensajeID.Visible = false;
        }

        protected void lbBuscarPorNombre_Click(object sender, EventArgs e)
        {
            string nombreUsuario = ((usuario)Session["usuario"]).nombreCuenta;
            string nombreBuscado = txtNombre.Text;

            if (nombreBuscado == nombreUsuario)
            {
                lblMensajeNombre.Text = $"Error: no puedes agregarte a ti mismo como amigo.";
                lblMensajeNombre.Visible = true;
                return;
            }

            UsuarioWSClient usuarioDao = new UsuarioWSClient();

            BindingList<usuario> usuarios = new BindingList<usuario>();
            usuario usuarioEncontrado = usuarioDao.buscarUsuarioPorNombreCuenta(nombreBuscado);

            if (usuarioEncontrado == null)
            {
                lblMensajeNombre.Text = $"No hay usuarios con nombre {nombreBuscado}";
                lblMensajeNombre.Visible = true;
                return;
            }

            BindingList<usuario> amigos = (BindingList<usuario>)Session["amigos"];

            if (amigos.Any(amigo => amigo.UID == usuarioEncontrado.UID))
            {
                lblMensajeNombre.Text = $"Ya tienes como amigo a {nombreBuscado}";
                lblMensajeNombre.Visible = true;
                return;
            }

            usuarios.Add(usuarioEncontrado);
            gvUsuarios.DataSource = usuarios;
            gvUsuarios.DataBind();
            lblMensajeNombre.Visible = false;
            lblMensajeID.Visible = false;
        }


        protected void lbAgregarAmigo_Click(object sender, EventArgs e)
        {
            RelacionWSClient relacionDao = new RelacionWSClient();
            int idUsuario = ((usuario)Session["usuario"]).UID;
            int idNuevoAmigo = Int32.Parse(((LinkButton)sender).CommandArgument);
            relacionDao.agregarAmigo(idUsuario, idNuevoAmigo);
            Response.Redirect("Amigos.aspx");
        }

        protected void gvUsuarios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsuarios.PageIndex = e.NewPageIndex;
            gvUsuarios.DataBind();
        }
    }
}