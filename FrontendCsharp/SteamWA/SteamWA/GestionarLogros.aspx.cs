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

            // No mostrar ningún contenido
            gvLogrosDesbloqueados.Visible  = false;
            gvLogrosPorDesbloquear.Visible = false;
            h2LogrosDesbloqueados.Visible  = false;
            h2LogrosPorDesbloquear.Visible = false;
            pLogrosDesbloqueados.Visible   = false;
            pLogrosPorDesbloquear.Visible  = false;

            // Obtener los logros correspondientes al juego
            logrosDelJuego = obtenerLogrosDeJuego(juegoSeleccionado);
            if (logrosDelJuego.Count == 0)
            {
                pLogros.InnerText = "Aún no hay logros disponibles para este juego.";
                return;
            }

            // Obtener los logros desbloqueados por el usuario en su juego
            h2LogrosDesbloqueados.Visible = true;
            logrosDesbloqueados = obtenerLogrosDesbloqueadosDeJuego(juegoSeleccionado);
            if (logrosDesbloqueados.Count == 0)
            {
                pLogrosDesbloqueados.InnerText = "Aquí se mostrarán tus logros desbloqueados.";
                pLogrosDesbloqueados.Visible = true;
            }
            else
            {
                gvLogrosDesbloqueados.DataSource = logrosDesbloqueados;
                gvLogrosDesbloqueados.DataBind();
                gvLogrosDesbloqueados.Visible = true;
            }

            // Obtener los logros no desbloqueados por el usuario en su juego
            logrosNoDesbloqueados = obtenerLogrosNoDesbloqueadosDeJuego(logrosDelJuego, logrosDesbloqueados);
            if (logrosNoDesbloqueados.Count == 0)
            {
                pLogrosPorDesbloquear.InnerText = "¡Felicidades! Has desbloqueado todos los logros de este juego.";
                pLogrosPorDesbloquear.Visible = true;
            }
            else
            {
                gvLogrosPorDesbloquear.DataSource = logrosNoDesbloqueados;
                gvLogrosPorDesbloquear.DataBind();

                gvLogrosPorDesbloquear.Visible = true;
                h2LogrosPorDesbloquear.Visible = true;
            }
            Steam master = (Steam)this.Master;
            master.ItemBiblioteca.Attributes["class"] = "active";
        }

        protected BindingList<logro> obtenerLogrosDeJuego(producto juegoSeleccionado)
        {
            // Obtener los logros del juego de la base de datos
            LogroWSClient daoLogro = new LogroWSClient();
            logro[] listaLogrosDelJuego = daoLogro.listarLogrosPorIdJuego(juegoSeleccionado.idProducto);

            // Si el juego tiene logros, se asigna al atributo logrosDelJuego
            return listaLogrosDelJuego != null ?
                   new BindingList<logro>(listaLogrosDelJuego) :
                   new BindingList<logro>();
        }

        protected BindingList<logroDesbloqueado> obtenerLogrosDesbloqueadosDeJuego(producto juegoSeleccionado)
        {
            // Obtener todos los logros desbloqueados por el usuario
            BindingList<logroDesbloqueado> todosLogrosDesbloqueados =
                (BindingList<logroDesbloqueado>)Session["logrosDesbloqueados"];

            // Variable en la cual se guardarán todos los logros desbloqueados del juego
            BindingList<logroDesbloqueado> logrosDesbloqueadosDeJuego = new BindingList<logroDesbloqueado>();

            // Agregar solo los logros correspondientes al juego
            foreach (logroDesbloqueado logroDesbloqueado in todosLogrosDesbloqueados)
                if (logroDesbloqueado.logro.juego.idProducto == juegoSeleccionado.idProducto)
                    logrosDesbloqueadosDeJuego.Add(logroDesbloqueado);

            return logrosDesbloqueadosDeJuego;
        }

        protected BindingList<logro> obtenerLogrosNoDesbloqueadosDeJuego(
            BindingList<logro> logrosDelJuego, BindingList<logroDesbloqueado> logrosDesbloqueados)
        {
            // Si el usuario no ha desbloqueado logros, entonces los logros no desbloqueados son los logros del juego
            if (logrosDesbloqueados.Count == 0) return logrosDelJuego;

            // Se crea la lista de logros no desbloqueados vacía
            BindingList<logro> logrosNoDesbloqueados = new BindingList<logro>();

            // Si todos los logros fueron desbloqueados, entonces se deja la lista vacía
            if (logrosDesbloqueados.Count == logrosDelJuego.Count) return logrosNoDesbloqueados;

            // Se agregan todos los logros del juego que no estén desbloqueados
            foreach (logro logroDelJuego in logrosDelJuego)
            {
                bool esLogroNoDesbloqueado = logrosDesbloqueados.FirstOrDefault(
                    x => x.logro.idLogro == logroDelJuego.idLogro) == null;

                if (esLogroNoDesbloqueado) logrosNoDesbloqueados.Add(logroDelJuego);
            }

            return logrosNoDesbloqueados;
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

            // Obtener una copia de la variable de sesión de logros desbloqueados
            BindingList<logroDesbloqueado> todosLogrosDesbloqueados =
                new BindingList<logroDesbloqueado>(((BindingList<logroDesbloqueado>)
                                                   Session["logrosDesbloqueados"]).ToList());

            // Basta con eliminar el logro desbloqueado de la variable de sesión de logros desbloqueados
            todosLogrosDesbloqueados.Remove(
                todosLogrosDesbloqueados.FirstOrDefault(
                    l => l.idLogroDesbloqueado == idLogroPorEliminar));

            // Actualizar la variable de sesión
            Session["logrosDesbloqueados"] = todosLogrosDesbloqueados;

            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }

        protected void btnDesbloquearLogroConfirmacionModal_OnClick(object sender, EventArgs e)
        {
            int idLogroPorDesbloquear = (int)Session["idLogro"];

            // Crear un nuevo objeto de desbloqueo de logro
            logroDesbloqueado nuevoLogroDesbloqueado = new logroDesbloqueado();
            nuevoLogroDesbloqueado.activo = true;
            nuevoLogroDesbloqueado.fechaDesbloqueo = DateTime.Now;
            nuevoLogroDesbloqueado.logro = logrosDelJuego.SingleOrDefault(x => x.idLogro == idLogroPorDesbloquear);
            nuevoLogroDesbloqueado.juego = productoAdquiridoSeleccionado;

            //logroDesbloqueado.logro.juego.idProducto

            // Desbloquear el logro para el usuario en la base de datos
            LogroDesbloqueadoWSClient daoLogroDesbloqueado = new LogroDesbloqueadoWSClient();
            nuevoLogroDesbloqueado.idLogroDesbloqueado =
                daoLogroDesbloqueado.insertarLogroDesbloqueado(nuevoLogroDesbloqueado);
            // logroDesbloqueado.logro.juego.idProducto

            // Obtener una copia de la variable de sesión de logros desbloqueados
            BindingList<logroDesbloqueado> todosLogrosDesbloqueados =
                new BindingList<logroDesbloqueado>(((BindingList<logroDesbloqueado>)
                                                   Session["logrosDesbloqueados"]).ToList());

            // Basta con eliminar el logro desbloqueado de la variable de sesión de logros desbloqueados
            todosLogrosDesbloqueados.Add(nuevoLogroDesbloqueado);

            // Actualizar la variable de sesión
            Session["logrosDesbloqueados"] = todosLogrosDesbloqueados;

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