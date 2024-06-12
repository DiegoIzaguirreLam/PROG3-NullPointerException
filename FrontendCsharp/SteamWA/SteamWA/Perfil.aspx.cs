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
            // En la primera carga, se obtienen los datos de la base de datos
            if (!IsPostBack)
            {
                // Obtener información de la base de datos
                usuario usuario = cargarDatosUsuario();
                cargarLogrosBaseDeDatos(usuario.UID);
                cargarBloqueadosBaseDeDatos(usuario.UID);

                // Para que la pantalla inicie en la vista de logros
                lbLogros_Click(null, null);
            }

            // Enlazar los GridView con los datos
            gvLogros.DataSource = (BindingList<logroDesbloqueado>)Session["logrosDesbloqueados"];
            gvLogros.DataBind();
            gvBloqueados.DataSource = (BindingList<usuario>)Session["bloqueados"];
            gvBloqueados.DataBind();
        }

        protected usuario cargarDatosUsuario()
        {
            usuario usuario = (usuario)Session["usuario"];

            lblNombreCuenta.InnerText = usuario.nombreCuenta;
            lblUID.Text = usuario.UID.ToString();
            lblCorreo.Text = usuario.correo;
            lblTelefono.Text = usuario.telefono;
            lblFechaNacimiento.Text = usuario.fechaNacimiento.ToString("dd/MM/yyyy");

            if (usuario.verificado)
            {
                lblVerificado.InnerText = "Verificado por Steam";
                lblVerificado.Style["color"] = "green";
                iconVerificado.Style["color"] = "green";
            }

            return usuario;
        }

        protected void cargarLogrosBaseDeDatos(int idUsuario)
        {
            LogroDesbloqueadoWSClient daoLogro = new LogroDesbloqueadoWSClient();
            logroDesbloqueado[] listaLogros = daoLogro.listarLogrosPorUsuario(idUsuario);

            if (listaLogros == null)
            {
                lblNoLogros.Visible = true;
                return;
            }

            Session["logrosDesbloqueados"] = new BindingList<logroDesbloqueado>(listaLogros);
        }

        protected void cargarBloqueadosBaseDeDatos(int idUsuario)
        {
            // Se asume que la variable sesión ya tiene los bloqueados actualizados
            if (Session["bloqueados"] != null) return;

            UsuarioWSClient daoUsuario = new UsuarioWSClient();

            // Se obtienen los bloqueados del usuario de la base de datos
            usuario[] listaBloqueados = daoUsuario.listarBloqueadosPorUsuario(idUsuario);

            // Si no tiene bloqueados, no se hace nada
            if (listaBloqueados == null) return;

            // Se guardan los bloqueados en la sesión
            Session["bloqueados"] = new BindingList<usuario>(listaBloqueados);
        }

        protected void lbLogros_Click(object sender, EventArgs e)
        {
            lbLogros.CssClass = "nav-link bg-navy text-light bg-gradient";
            lbActividad.CssClass = "nav-link bg-navy text-light";
            lbUsuariosBloqueados.CssClass = "nav-link bg-navy text-light";
            MultiView1.SetActiveView(ViewLogrosObtenidos);
        }

        protected void lbActividad_Click(object sender, EventArgs e)
        {
            lbLogros.CssClass = "nav-link bg-navy text-light";
            lbActividad.CssClass = "nav-link bg-navy text-light bg-gradient";
            lbUsuariosBloqueados.CssClass = "nav-link bg-navy text-light";
            MultiView1.SetActiveView(ViewActividadReciente);
        }

        protected void lbUsuariosBloqueados_Click(object sender, EventArgs e)
        {
            lbLogros.CssClass = "nav-link bg-navy text-light";
            lbActividad.CssClass = "nav-link bg-navy text-light";
            lbUsuariosBloqueados.CssClass = "nav-link bg-navy text-light bg-gradient";
            MultiView1.SetActiveView(ViewInfoPersonal);
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

            btnBloquearModal.Visible = false;

            if (usuarioPorBloquear == null)
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
            int idUsuario = ((usuario)Session["usuario"]).UID;
            usuario usuarioPorBloquear = (usuario)Session["usuarioPorBloquear"];

            // Bloqueo en la base de datos
            RelacionWSClient daoRelacion = new RelacionWSClient();
            daoRelacion.bloquearUsuario(idUsuario, usuarioPorBloquear.UID);

            // Se obtiene la variable ReadOnly
            BindingList<usuario> bloqueadosReadOnly = (BindingList<usuario>)Session["bloqueados"];

            // Se crea copia de la variable ReadOnly
            BindingList<usuario> bloqueados = new BindingList<usuario>(bloqueadosReadOnly.ToList());

            // Añadir el usuario a los bloqueados
            bloqueados.Add(usuarioPorBloquear);

            // Actualización de las variables en la sesión
            Session["bloqueados"] = bloqueados;

            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }
    }
}