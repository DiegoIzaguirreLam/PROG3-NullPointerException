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
            int idBuscado = Int32.Parse(txtUID.Value);

            if (idBuscado == idUsuario)
            {
                lblMensajeID.Text = $"Error: el ID {idBuscado} es tu ID.";
                lblMensajeID.Visible = true;
                return;
            }

            UsuarioWSClient usuarioDao = new UsuarioWSClient();
            usuario usuarioEncontrado = usuarioDao.buscarUsuarioPorId(idBuscado);

            if (usuarioEncontrado == null)
            {
                lblMensajeID.Text = $"No hay usuarios con ID {idBuscado}";
                lblMensajeID.Visible = true;
                return;
            }

            BindingList<usuario> usuariosEncontrados = new BindingList<usuario> { usuarioEncontrado };
            Session["usuariosEncontrados"] = usuariosEncontrados;

            gvUsuarios.DataSource = usuariosEncontrados;
            gvUsuarios.DataBind();

            txtUID.Value = "";
            txtNombre.Value = "";
            lblMensajeNombre.Visible = false;
            lblMensajeID.Visible = false;
        }

        protected void lbBuscarPorNombre_Click(object sender, EventArgs e)
        {
            usuario usuarioActual = (usuario)Session["usuario"];
            string nombreUsuario = usuarioActual.nombreCuenta;
            string nombreBuscado = txtNombre.Value;

            if (nombreBuscado == nombreUsuario)
            {
                lblMensajeNombre.Text = $"Error: no puedes agregarte a ti mismo como amigo.";
                lblMensajeNombre.Visible = true;
                return;
            }

            UsuarioWSClient usuarioDao = new UsuarioWSClient();
            usuario[] listaUsuarios = usuarioDao.listarUsuariosPorNombreCuenta(nombreBuscado);

            if (listaUsuarios == null)
            {
                lblMensajeNombre.Text = $"No hay usuarios con nombre {nombreBuscado}";
                lblMensajeNombre.Visible = true;
                return;
            }

            BindingList<usuario> usuariosEncontrados = new BindingList<usuario>(listaUsuarios.ToList());

            usuario usuarioActualPorEliminar = usuariosEncontrados.SingleOrDefault(u => u.UID == usuarioActual.UID);
            usuariosEncontrados.Remove(usuarioActualPorEliminar);
            Session["usuariosEncontrados"] = usuariosEncontrados;

            gvUsuarios.DataSource = usuariosEncontrados;
            gvUsuarios.DataBind();

            txtUID.Value = "";
            txtNombre.Value = "";
            lblMensajeNombre.Visible = false;
            lblMensajeID.Visible = false;
        }

        protected void lbAgregarAmigo_Click(object sender, EventArgs e)
        {
            int idUsuario = ((usuario)Session["usuario"]).UID;
            int idNuevoAmigo = Int32.Parse(((LinkButton)sender).CommandArgument);

            // Agregar el amigo en la base de datos
            RelacionWSClient relacionDao = new RelacionWSClient();
            relacionDao.agregarAmigo(idUsuario, idNuevoAmigo);

            // Se obtiene la variable ReadOnly
            BindingList<usuario> amigosReadOnly = (BindingList<usuario>)Session["amigos"];
            // Se crea una copia de la variable ReadOnly
            BindingList<usuario> amigos = amigosReadOnly != null ?
                                          new BindingList<usuario>(amigosReadOnly.ToList()) :
                                          new BindingList<usuario>();

            // Obtener el usuario del nuevo amigo
            BindingList<usuario> usuariosEncontrados = (BindingList<usuario>)Session["usuariosEncontrados"];
            usuario nuevoAmigo = usuariosEncontrados.SingleOrDefault(u => u.UID== idNuevoAmigo);

            // Actualizar la lista de amigos de la sesión
            amigos.Add(nuevoAmigo);
            Session["amigos"] = amigos;

            // Enviar notificación y redireccionar a la vista de amigos
            agregarNotificacionNuevoAmigo(nuevoAmigo);
            Session["usuariosEncontrados"] = null;
            Response.Redirect("Amigos.aspx");
        }

        public void agregarNotificacionNuevoAmigo(usuario nuevoAmigo)
        {
            usuario usuarioActual = (usuario)Session["usuario"];
            notificacion notificacion = new notificacion();

            // Enviar la notificación al usuario actual
            notificacion.usuario = usuarioActual;
            notificacion.tipoSpecified = true;
            notificacion.tipo = tipoNotificacion.AMIGOS;
            notificacion.mensaje = "Ahora eres amigo de " + nuevoAmigo.nombrePerfil;
            daoNotificacion.insertarNotificacion(notificacion);

            // Enviar la notificación al nuevo amigo
            notificacion.usuario = nuevoAmigo;
            notificacion.tipoSpecified = true;
            notificacion.tipo = tipoNotificacion.AMIGOS;
            notificacion.mensaje = "Ahora eres amigo de " + usuarioActual.nombrePerfil;
            daoNotificacion.insertarNotificacion(notificacion);
        }

        protected void gvUsuarios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsuarios.PageIndex = e.NewPageIndex;
            gvUsuarios.DataSource = (BindingList<usuario>)Session["usuariosEncontrados"];
            gvUsuarios.DataBind();
        }

        protected void gvUsuarios_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            verificarUsuarioEsAmigo(e);
            verificarUsuarioEsBloqueado(e);
        }

        protected void verificarUsuarioEsAmigo(GridViewRowEventArgs e)
        {
            // Si no tiene amigos, no se hace nada
            BindingList<usuario> amigos = (BindingList<usuario>)Session["amigos"];
            if (amigos == null) return;

            // Obtener el valor del campo UID
            int idUsuarioFila = Int32.Parse(DataBinder.Eval(e.Row.DataItem, "UID").ToString());
            int idUsuario = ((usuario)Session["usuario"]).UID;

            // Verificar si el usuario en la fila ya es amigo
            bool yaEsAmigo = amigos.Any(u => u.UID == idUsuarioFila);

            // Buscar el LinkButton dentro de la fila
            LinkButton lbAgregarAmigo = (LinkButton)e.Row.FindControl("lbAgregarAmigo");

            // Buscar el Label dentro de la fila
            Label lblYaEsAmigo = (Label)e.Row.FindControl("lblYaEsAmigo");

            lbAgregarAmigo.Visible = !yaEsAmigo;
            lblYaEsAmigo.Visible = yaEsAmigo;
        }

        protected void verificarUsuarioEsBloqueado(GridViewRowEventArgs e)
        {
            // Si no tiene bloqueados, no se hace nada
            BindingList<usuario> bloqueados = (BindingList<usuario>)Session["bloqueados"];
            if (bloqueados == null) return;

            // Obtener el valor del campo UID
            int idUsuarioFila = Int32.Parse(DataBinder.Eval(e.Row.DataItem, "UID").ToString());
            int idUsuario = ((usuario)Session["usuario"]).UID;

            // Verificar si el usuario en la fila está bloqueado
            bool estaBloqueado = bloqueados.Any(u => u.UID == idUsuarioFila);

            // Buscar el LinkButton dentro de la fila
            LinkButton lbAgregarAmigo = (LinkButton)e.Row.FindControl("lbAgregarAmigo");

            // Buscar el Label dentro de la fila
            Label lblEstaBloqueado = (Label)e.Row.FindControl("lblEstaBloqueado");

            lbAgregarAmigo.Visible = !estaBloqueado && lbAgregarAmigo.Visible;
            lblEstaBloqueado.Visible = estaBloqueado;
        }
    }
}