using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Perfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Para que la pantalla inicie en la vista de logros
            if (!IsPostBack) lbLogros_Click(null, null);

            // Mostrar los datos del usuario en los labels
            cargarDatosUsuario();

            // Enlazar los GridView con los datos de las variables de sesión
            gvLogros.DataSource = (BindingList<logroDesbloqueado>)Session["logrosDesbloqueados"];
            gvLogros.DataBind();
            gvBloqueados.DataSource = (BindingList<usuario>)Session["bloqueados"];
            gvBloqueados.DataBind();
        }

        protected void cargarDatosUsuario()
        {
            usuario usuario = (usuario)Session["usuario"];

            lblNombreCuenta.InnerText = usuario.nombreCuenta;
            lblUID.Text = usuario.UID.ToString();
            lblCorreo.Text = usuario.correo;
            lblTelefono.Text = usuario.telefono;
            lblFechaNacimiento.Text = usuario.fechaNacimiento.ToString("dd/MM/yyyy");
            imgPerfil.ImageUrl = usuario.fotoURL;

            if (usuario.verificado)
            {
                lblVerificado.InnerText = "Verificado por Steam";
                lblVerificado.Style["color"] = "green";
                iconVerificado.Style["color"] = "green";
            }
        }

        protected void lbLogros_Click(object sender, EventArgs e)
        {
            lbLogros.CssClass = "nav-link bg-navy text-light bg-gradient";
            lbUsuariosBloqueados.CssClass = "nav-link bg-navy text-light";
            MultiView1.SetActiveView(ViewLogrosObtenidos);
        }

        protected void lbUsuariosBloqueados_Click(object sender, EventArgs e)
        {
            lbLogros.CssClass = "nav-link bg-navy text-light";
            lbUsuariosBloqueados.CssClass = "nav-link bg-navy text-light bg-gradient";
            MultiView1.SetActiveView(ViewUsuariosBloqueados);
        }

        protected void gvLogros_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLogros.PageIndex = e.NewPageIndex;
            gvLogros.DataBind();
        }

        protected void gvLogros_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                logroDesbloqueado logro = (logroDesbloqueado)e.Row.DataItem;
                HtmlImage img = new HtmlImage();
                img.Src = logro.juego.producto.logoUrl;
                img.Height = 50;
                img.Width = 50;
                e.Row.Cells[0].Controls.Add(img);
                e.Row.Cells[1].Text = logro.juego.producto.titulo;
                e.Row.Cells[2].Text = logro.logro.nombre;
                e.Row.Cells[3].Text = logro.logro.descripcion;
                e.Row.Cells[4].Text = logro.fechaDesbloqueo.ToString("dd/MM/yyyy");
            }
        }

        protected void gvBloqueados_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvBloqueados.PageIndex = e.NewPageIndex;
            gvBloqueados.DataSource = (BindingList<usuario>)Session["bloqueados"];
            gvBloqueados.DataBind();
        }

        protected void lbBloquearID_Click(object sender, EventArgs e)
        {
            // Obtener el usuario por bloquear
            UsuarioWSClient usuarioDao = new UsuarioWSClient();
            int idUsuarioPorBloquear = Int32.Parse(inputIdBloquear.Value);
            usuario usuarioPorBloquear = usuarioDao.buscarUsuarioPorId(idUsuarioPorBloquear);
            BindingList<usuario> bloqueados = (BindingList<usuario>)Session["bloqueados"];
            BindingList<usuario> usuariosQueBloquearon = (BindingList<usuario>)Session["usuariosQueBloquearon"];

            if (usuarioPorBloquear == null ||
                usuariosQueBloquearon.Any(u => u.UID == idUsuarioPorBloquear))
            {
                lblConfirmacionUsuario.Text = $"Error: no existe el usuario con " +
                                              $"ID = {idUsuarioPorBloquear}.";
            }
            else if (idUsuarioPorBloquear == ((usuario)Session["usuario"]).UID)
            {
                lblConfirmacionUsuario.Text = $"Error: tú eres el usuario con" +
                                              $"ID = {idUsuarioPorBloquear}.\n" +
                                              $"No puedes bloquearte a ti mismo.";
            }
            else if (bloqueados.Any(u => u.UID == idUsuarioPorBloquear))
            {
                lblConfirmacionUsuario.Text = $"El usuario {usuarioPorBloquear.nombrePerfil} " +
                                              $"({usuarioPorBloquear.nombreCuenta}) con " +
                                              $"ID = {idUsuarioPorBloquear} ya está bloqueado.";
            }
            else
            {
                btnBloquearModal.Visible = true;

                // Mostrar el modal de confirmación de bloqueo
                lblConfirmacionUsuario.Text = $"¿Estás seguro de que deseas bloquear a " +
                                              $"{usuarioPorBloquear.nombrePerfil} " +
                                              $"({usuarioPorBloquear.nombreCuenta}) con " +
                                              $"ID = {idUsuarioPorBloquear}?\n" +
                                              $"¡Recuerda que esta acción es permanente!";

                // Guardar el usuario por bloquear en una variable temporal de sesión
                Session["usuarioPorBloquear"] = usuarioPorBloquear;
            }

            inputIdBloquear.Value = "";
            string script = "window.onload = function() { showModalForm('modalBloquearUsuario') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnBloquearModal_Click(object sender, EventArgs e)
        {
            // Se obtiene el usuario por bloquear
            int idUsuario = ((usuario)Session["usuario"]).UID;
            usuario usuarioPorBloquear = (usuario)Session["usuarioPorBloquear"];

            // Bloqueo en la base de datos
            RelacionWSClient daoRelacion = new RelacionWSClient();
            daoRelacion.bloquearUsuario(idUsuario, usuarioPorBloquear.UID);

            // Se obtiene una copia de la variable de sesión de bloqueados
            BindingList<usuario> bloqueados =
                new BindingList<usuario>(((BindingList<usuario>)
                                         Session["bloqueados"]).ToList());

            // Añadir el usuario a los bloqueados
            bloqueados.Add(usuarioPorBloquear);

            // Actualización de la variable de bloqueados en la sesión
            Session["bloqueados"] = bloqueados;

            // Se obtiene una copia de la variable de sesión de amigos
            BindingList<usuario> amigos =
                new BindingList<usuario>(((BindingList<usuario>)
                                         Session["amigos"]).ToList());

            // Si el bloqueado era amigo, eliminarlo de la lista de amigos
            usuario bloqueadoPorQuitarDeAmigos = amigos.FirstOrDefault(u => u.UID == usuarioPorBloquear.UID);
            if (bloqueadoPorQuitarDeAmigos != null)
            {
                amigos.Remove(bloqueadoPorQuitarDeAmigos);

                // Actualización de la variable de amigos en la sesión
                Session["amigos"] = amigos;
            }


            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }
    }
}