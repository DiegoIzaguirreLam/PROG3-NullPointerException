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
    public partial class GestionarLogros : System.Web.UI.Page
    {
        private productoAdquirido productoAdquiridoSeleccionado;
        private BindingList<logro> logrosDelJuego = null;
        private BindingList<logro> logrosNoDesbloqueados = null;
        private BindingList<logroDesbloqueado> logrosDesbloqueados = null;
        private NotificacionWSClient daoNotificacion;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Si todavía no se ha seleccionado ningún producto de la biblioteca
            productoAdquiridoSeleccionado = (productoAdquirido)Session["productoAdquiridoSeleccionado"];
            if (productoAdquiridoSeleccionado == null)
                Response.Redirect("Biblioteca.aspx");

            // Obtener el juego correspondiente al producto adquirido
            producto juegoSeleccionado = productoAdquiridoSeleccionado.producto;
            hGestionarLogros.InnerHtml = juegoSeleccionado.titulo + ": Logros";

            // Obtener los logros correspondientes al juego
            obtenerLogrosDeJuego(juegoSeleccionado);
            if (logrosDelJuego == null)
            {
                pLogros.InnerText = "Aún no hay logros disponibles para este juego.";
                gvLogrosDesbloqueados.Visible = false;
                gvLogrosPorDesbloquear.Visible = false;
                h2LogrosDesbloqueados.Visible = false;
                h2LogrosPorDesbloquear.Visible = false;
                return;
            }

            // Obtener los logros desbloqueados por el usuario en su juego
            obtenerLogrosDesbloqueados();
            if (logrosDesbloqueados == null)
            {
                pLogrosDesbloqueados.InnerText = "Aquí se mostrarán tus logros desbloqueados";
                pLogrosDesbloqueados.Visible = true;
                gvLogrosDesbloqueados.Visible = false;
            }

            // Obtener los logros no desbloqueados por el usuario en su juego
            obtenerLogrosNoDesbloqueados();
            if (logrosNoDesbloqueados == null)
            {
                pLogrosPorDesbloquear.InnerText = "¡Felicidades! Has desbloqueado todos los logros de este juego.";
                pLogrosPorDesbloquear.Visible = true;
                gvLogrosPorDesbloquear.Visible = false;
                h2LogrosPorDesbloquear.Visible = false;
            }

            // Enlazar la lista de logros a los GridView
            gvLogrosPorDesbloquear.DataSource = logrosNoDesbloqueados;
            gvLogrosPorDesbloquear.DataBind();
            gvLogrosDesbloqueados.DataSource = logrosDesbloqueados;
            gvLogrosDesbloqueados.DataBind();

            // Mostrar los GridView y esconder mensajes
            pLogrosPorDesbloquear.Visible = false;
            gvLogrosPorDesbloquear.Visible = true;
            pLogrosDesbloqueados.Visible = false;
            gvLogrosDesbloqueados.Visible = true;
        }

        protected void obtenerLogrosDeJuego(producto juegoSeleccionado)
        {
            // Obtener los logros del juego de la base de datos
            LogroWSClient daoLogro = new LogroWSClient();
            logro[] listaLogrosDelJuego = daoLogro.listarLogrosPorIdJuego(juegoSeleccionado.idProducto);

            // Si el juego tiene logros, se asigna al atributo logrosDelJuego
            logrosDelJuego = listaLogrosDelJuego != null ?
                             new BindingList<logro>(listaLogrosDelJuego) :
                             null;
        }

        protected void obtenerLogrosDesbloqueados()
        {
            // Obtener los logros desbloqueados por el usuario de la base de datos
            LogroDesbloqueadoWSClient daoLogroDesbloqueado = new LogroDesbloqueadoWSClient();
            logroDesbloqueado[] listaLogrosDesbloqueados =
                daoLogroDesbloqueado.listarLogrosDesbloqueadosProductoAdquirido(
                    productoAdquiridoSeleccionado.idProductoAdquirido);

            // Si el usuario ha desbloqueado logros, se asigna al atributo logrosDesbloqueados
            logrosDesbloqueados = listaLogrosDesbloqueados != null ?
                                  new BindingList<logroDesbloqueado>(listaLogrosDesbloqueados) :
                                  null;
        }

        protected void obtenerLogrosNoDesbloqueados()
        {
            // Si el usuario no ha desbloqueado logros, entonces los logros no desbloqueados son los logros del juego
            if (logrosDesbloqueados == null)
            {
                logrosNoDesbloqueados = logrosDelJuego;
                return;
            }

            // Se agregan todos los logros del juego que no estén desbloqueados
            logrosNoDesbloqueados = new BindingList<logro>();
            foreach (logro logroDelJuego in logrosDelJuego)
            {
                bool esLogroNoDesbloqueado = logrosDesbloqueados.FirstOrDefault(
                    x => x.logro.idLogro == logroDelJuego.idLogro) == null;
                if (esLogroNoDesbloqueado) logrosNoDesbloqueados.Add(logroDelJuego);
            }
        }

        protected void gvLogrosDesbloqueados_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                logroDesbloqueado logroDesbloqueado = (logroDesbloqueado)e.Row.DataItem;
                e.Row.Cells[0].Text = logroDesbloqueado.logro.nombre.ToString();
                e.Row.Cells[1].Text = logroDesbloqueado.logro.descripcion.ToString();
                e.Row.Cells[2].Text = logroDesbloqueado.fechaDesbloqueo.ToString("dd/MM/yyyy");
            }
        }

        protected void gvLogrosPorDesbloquear_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                logro logro = (logro)e.Row.DataItem;
                e.Row.Cells[0].Text = logro.nombre.ToString();
                e.Row.Cells[1].Text = logro.descripcion.ToString();
            }
        }

        protected void btnEliminarLogroDesbloqueado_Click(object sender, EventArgs e)
        {
            Session["idLogroDesbloqueado"] = Int32.Parse(((LinkButton)sender).CommandArgument);
            string script = "window.onload = function() { showModalForm('form-modal-EliminarLogroDesbloqueado') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnDesbloquearLogro_Click(object sender, EventArgs e)
        {
            Session["idLogro"] = Int32.Parse(((LinkButton)sender).CommandArgument);
            string script = "window.onload = function() { showModalForm('form-modal-DesbloquearLogro') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }


        protected void btnEliminarLogroDesbloqueadoConfirmacionModal_OnClick(object sender, EventArgs e)
        {
            // Obtener el ID del logro por eliminar
            int idLogroPorEliminar = (int)Session["idLogroDesbloqueado"];

            // Eliminar el logro en la base de datos
            LogroDesbloqueadoWSClient daoLogroDesbloqueado = new LogroDesbloqueadoWSClient();
            daoLogroDesbloqueado.eliminarLogroDesbloqueado(idLogroPorEliminar);

            // Obtener una copia de la lista de logros de la variable de sesión
            BindingList<logroDesbloqueado> logrosDesbloqueados =
                new BindingList<logroDesbloqueado>(((BindingList<logroDesbloqueado>)
                                                    Session["logrosDesbloqueados"]).ToList());
            
            // Eliminar el logro seleccionado
            logrosDesbloqueados.Remove(logrosDesbloqueados.FirstOrDefault
                                       (u => u.idLogroDesbloqueado == idLogroPorEliminar));

            // Actualizar la variable de logros de la sesión
            Session["logrosDesbloqueados"] = logrosDesbloqueados;

            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }

        protected void btnDesbloquearLogroConfirmacionModal_OnClick(object sender, EventArgs e)
        {
            int idLogroPorDesbloquear = (int)Session["idLogro"];

            // Crear un nuevo objeto de desbloqueo de logro
            logroDesbloqueado nuevoLogroDesbloqueado = new logroDesbloqueado();
            nuevoLogroDesbloqueado.logro = logrosDelJuego.SingleOrDefault(x => x.idLogro == idLogroPorDesbloquear);
            nuevoLogroDesbloqueado.juego = productoAdquiridoSeleccionado;

            // Desbloquear el logro para el usuario en la base de datos
            LogroDesbloqueadoWSClient daoLogroDesbloqueado = new LogroDesbloqueadoWSClient();
            daoLogroDesbloqueado.insertarLogroDesbloqueado(nuevoLogroDesbloqueado);

            // Obtener una copia de la lista de logros de la variable de sesión
            BindingList<logroDesbloqueado> logrosDesbloqueados =
                new BindingList<logroDesbloqueado>(((BindingList<logroDesbloqueado>)
                                                    Session["logrosDesbloqueados"]).ToList());

            // Agregar el nuevo logro seleccionado
            logrosDesbloqueados.Add(nuevoLogroDesbloqueado);

            // Actualizar la variable de logros de la sesión
            Session["logrosDesbloqueados"] = logrosDesbloqueados;

            agregarNotificacion();
            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }

        public void agregarNotificacion()
        {
            notificacion notificacionJuego = new notificacion();
            notificacionJuego.usuario = (usuario)Session["usuario"];
            notificacionJuego.tipoSpecified = true;
            notificacionJuego.tipo = tipoNotificacion.JUEGOS;
            notificacionJuego.mensaje = "Has conseguido un nuevo logro en "+productoAdquiridoSeleccionado.producto.titulo;
            daoNotificacion = new NotificacionWSClient();
            int resultado = daoNotificacion.insertarNotificacion(notificacionJuego);
        }
        protected void gvLogrosDesbloqueados_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLogrosDesbloqueados.PageIndex = e.NewPageIndex;
            gvLogrosDesbloqueados.DataSource = logrosDesbloqueados;
            gvLogrosDesbloqueados.DataBind();
        }

        protected void gvLogrosPorDesbloquear_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLogrosPorDesbloquear.PageIndex = e.NewPageIndex;
            gvLogrosPorDesbloquear.DataSource = logrosNoDesbloqueados;
            gvLogrosPorDesbloquear.DataBind();
        }

        protected void lbVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Biblioteca.aspx");
        }
    }
}