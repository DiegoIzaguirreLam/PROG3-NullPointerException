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
            Steam master = (Steam)this.Master;
            master.ItemAmigos.Attributes["class"] = "active";
        }

        protected void lbBuscarPorID_Click(object sender, EventArgs e)
        {
            // Obtener el ID del usuario y el ID que se está buscando
            int idUsuario = ((usuario)Session["usuario"]).UID;
            int idBuscado = Int32.Parse(txtUID.Value);

            // El usuario no se puede buscar a sí mismo
            if (idBuscado == idUsuario)
            {
                // Mostrar mensaje de error
                lblMensajeID.Text = $"Error: el ID {idBuscado} es tu ID.";
                lblMensajeID.Visible = true;
                txtUID.Value = "";
                return;
            }

            // El usuario buscado ha bloqueado al usuario de la sesión
            BindingList<usuario> usuariosQueBloquearon = (BindingList<usuario>)Session["usuariosQueBloquearon"];
            if (usuariosQueBloquearon.Any(u => u.UID == idBuscado))
            {
                // Mensaje de error
                lblMensajeID.Text = $"No hay usuarios con ID {idBuscado}";
                lblMensajeID.Visible = true;
                txtUID.Value = "";
                return;
            }

            // Buscar el usuario en la base de datos
            UsuarioWSClient usuarioDao = new UsuarioWSClient();
            usuario usuarioEncontrado = usuarioDao.buscarUsuarioPorId(idBuscado);

            // No se encontró el usuario con el ID deseado en la base de datos
            if (usuarioEncontrado == null)
            {
                // Mensaje de error
                lblMensajeID.Text = $"No hay usuarios con ID {idBuscado}";
                lblMensajeID.Visible = true;
                txtUID.Value = "";
                return;
            }

            // Guardar la lista de un solo usuario en el GridView y en la variable de sesión
            Session["usuariosEncontrados"] = gvUsuarios.DataSource = new BindingList<usuario> { usuarioEncontrado };
            gvUsuarios.DataBind();

            // No mostrar mensajes de error
            lblMensajeNombre.Visible = false;
            lblMensajeID.Visible = false;

            Steam master = (Steam)this.Master;
            master.ItemAmigos.Attributes["class"] = "active";
        }

        protected void lbBuscarPorNombre_Click(object sender, EventArgs e)
        {
            // Obtener el nombre del usuario y el nombre buscado
            usuario usuarioActual = (usuario)Session["usuario"];
            string nombreBuscado = txtNombre.Value;

            // El usuario no puede buscarse a sí mismo
            if (nombreBuscado == usuarioActual.nombreCuenta)
            {
                lblMensajeNombre.Text = $"Error: no puedes agregarte a ti mismo como amigo.";
                lblMensajeNombre.Visible = true;
                return;
            }

            // Obtener las cuentas de la base de datos
            UsuarioWSClient usuarioDao = new UsuarioWSClient();
            usuario[] listaUsuarios = usuarioDao.listarUsuariosPorNombreCuenta(nombreBuscado);

            // Si, en la base de datos, no existe ningún registro de usuario
            if (listaUsuarios == null)
            {
                // Mensaje de error
                lblMensajeNombre.Text = $"No hay usuarios con nombre {nombreBuscado}";
                lblMensajeNombre.Visible = true;
                txtNombre.Value = "";
                return;
            }

            // Se crea una BindingList a partir de los usuarios de la base de datos
            BindingList<usuario> usuariosEncontrados = new BindingList<usuario>(listaUsuarios.ToList());

            // Se elimina al usuario actual si es que aparece 
            usuario usuarioActualPorEliminar = usuariosEncontrados.SingleOrDefault(u => u.UID == usuarioActual.UID);
            if (usuarioActualPorEliminar != null) usuariosEncontrados.Remove(usuarioActualPorEliminar);

            // Se eliminan los usuarios que han bloqueado al usuario de la sesión de los resultados
            BindingList<usuario> usuariosQueBloquearon = (BindingList<usuario>)Session["usuariosQueBloquearon"];
            foreach (usuario usuarioQueBloqueo in usuariosQueBloquearon)
            {
                usuario resultadoPorEliminar = usuariosEncontrados.SingleOrDefault(u => u.UID == usuarioQueBloqueo.UID);
                if (resultadoPorEliminar != null) usuariosEncontrados.Remove(resultadoPorEliminar);
            }

            // Si después de las eliminaciones la lista quedó vacía
            if (usuariosEncontrados.Count == 0)
            {
                // Mensaje de error
                lblMensajeNombre.Text = $"No hay usuarios con nombre {nombreBuscado}";
                lblMensajeNombre.Visible = true;
                txtNombre.Value = "";
                return;
            }

            // Guardar los usuarios encontrados en una variable de sesión
            Session["usuariosEncontrados"] = usuariosEncontrados;

            // Enlazar el GridView con los resultados
            gvUsuarios.DataSource = usuariosEncontrados;
            gvUsuarios.DataBind();

            // No mostrar los mensajes de error
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

            // Se obtiene una copia de la variable de sesión
            BindingList<usuario> amigos = new BindingList<usuario>(((BindingList<usuario>)
                                                                   Session["amigos"]).ToList());

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
            NotificacionWSClient daoNotificacion = new NotificacionWSClient();

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

            verificarUsuarioEsAmigo_RowDataBound(e);
            verificarUsuarioEsBloqueado_RowDataBound(e);
        }

        /*
         * Esta función verifica si el usuario que se va a enlistar ya ha sido agregado
         * como amigo. En ese caso, se muestra un mensaje y se esconde el
         * botón de agregar amigo.
         */
        protected void verificarUsuarioEsAmigo_RowDataBound(GridViewRowEventArgs e)
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

        /*
         * Esta función verifica si el usuarios que se va a enlistar ya han sido bloqueado
         * por el usuario de la sesión. En ese caso, se muestra un mensaje y se esconde el
         * botón de agregar amigo.
         */
        protected void verificarUsuarioEsBloqueado_RowDataBound(GridViewRowEventArgs e)
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

        protected void volverPaginaAmigos_Click(object sender, EventArgs e)
        {
            Response.Redirect("Amigos.aspx");
        }
    }
}