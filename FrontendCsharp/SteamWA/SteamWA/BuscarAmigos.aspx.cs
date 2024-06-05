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
        private NotificacionWSClient daoNotificacion;
        protected void Page_Load(object sender, EventArgs e)
        {
            daoNotificacion = new NotificacionWSClient();
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
            if (amigos != null)
            {
                if (amigos.Any(amigo => amigo.UID == usuarioEncontrado.UID))
                {
                    lblMensajeID.Text = $"Ya tienes como amigo al ID {idBuscado}";
                    lblMensajeID.Visible = true;
                    return;
                }
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

            if (amigos != null)
            {
                if (amigos.Any(amigo => amigo.UID == usuarioEncontrado.UID))
                {
                    lblMensajeNombre.Text = $"Ya tienes como amigo a {nombreBuscado}";
                    lblMensajeNombre.Visible = true;
                    return;
                }
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
            UsuarioWSClient usuarioDao = new UsuarioWSClient();
            int idUsuario = ((usuario)Session["usuario"]).UID;
            int idNuevoAmigo = Int32.Parse(((LinkButton)sender).CommandArgument);
            relacionDao.agregarAmigo(idUsuario, idNuevoAmigo);
            Session["usuarioAmigo"] = usuarioDao.buscarUsuarioPorId(idNuevoAmigo);
            agregarNotificacion();
            Response.Redirect("Amigos.aspx");
        }

        public void agregarNotificacion()
        {
            notificacion notificacion1 = new notificacion();
            notificacion notificacion2 = new notificacion();
            notificacion1.usuario = (usuario)Session["usuario"];
            notificacion2.usuario = (usuario)Session["usuarioAmigo"];

            notificacion1.tipoSpecified = true;
            notificacion1.tipo = tipoNotificacion.AMIGOS;
            notificacion1.mensaje = "Ahora eres amigo de " + notificacion2.usuario.nombrePerfil;
            int resultado1 = daoNotificacion.insertarNotificacion(notificacion1);
            
            notificacion2.tipoSpecified = true;
            notificacion2.tipo = tipoNotificacion.AMIGOS;
            notificacion2.mensaje = "Ahora eres amigo de " + notificacion1.usuario.nombrePerfil;
            int resultado2 = daoNotificacion.insertarNotificacion(notificacion2);
        }

        protected void gvUsuarios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsuarios.PageIndex = e.NewPageIndex;
            gvUsuarios.DataBind();
        }
    }
}