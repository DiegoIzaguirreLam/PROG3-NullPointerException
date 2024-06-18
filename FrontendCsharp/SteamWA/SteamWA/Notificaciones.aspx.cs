using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Notificaciones : System.Web.UI.Page
    {

        private NotificacionWSClient daoNotificacion;
        BindingList<notificacion> notificaciones;

        protected void Page_Init(object sender, EventArgs e)
        {
            daoNotificacion = new NotificacionWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            usuario usuario = ((usuario)Session["usuario"]);
            notificacion[] notificacionesArr = daoNotificacion.listarNotificaciones(usuario.UID);
            lbEliminarNotificaciones.Visible = true;
            if (notificacionesArr != null)
            {
                notificaciones = new BindingList<notificacion>(notificacionesArr);
                Session["notificaciones"] = notificaciones;
            }
            else
            {
                notificaciones = new BindingList<notificacion>();
                lbEliminarNotificaciones.Visible = false;
            }
            // Verificar si la página actual del DataPager debe ser ajustada
            verificarDataPager();
            
            lvNotificaciones.DataSource = notificaciones;
            lvNotificaciones.DataBind();
        }

        public void verificarDataPager()
        {
            DataPager dp = lvNotificaciones.FindControl("dpNotificaciones") as DataPager;
            if (dp != null && notificaciones.Count > 0)
            {
                int startRowIndex = dp.StartRowIndex;
                int maximumRows = dp.MaximumRows;

                // Se verifica si el índice de inicio está fuera del rango de elementos
                if (startRowIndex >= notificaciones.Count)
                {
                    // Se calcula el índice de inicio para mostrar la última página con elementos
                    int totalPages = (int)Math.Ceiling((double)notificaciones.Count / maximumRows) - 1;
                    startRowIndex = totalPages * maximumRows;
                }

                dp.SetPageProperties(startRowIndex, maximumRows, true);
            }
        }
        protected void btnEliminarModal_Click(object sender, EventArgs e)
        {
            int idNotificacion = (int)Session["idNotificacionEliminar"];
            int resultado = daoNotificacion.eliminarNotificacion(idNotificacion);
            Session["idNotificacionEliminar"] = null;
            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }

        protected void btnMarcarNoLeidoModal_Click(object sender, EventArgs e)
        {
            notificacion notificacion = (notificacion)Session["notificacionModificar"];
            if (notificacion != null)
            {
                notificacion.revisada = !notificacion.revisada;
                int resultado = daoNotificacion.actualizarNotificacion(notificacion);
            }
            Session["notificacionModificar"] = null;
            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }

        protected void btnEliminarTodasNotificaciones_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-EliminarTodasNotificaciones') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnEliminarTodasNotificacionesModal_Click(object sender, EventArgs e)
        {
            usuario usuario = (usuario)Session["usuario"];
            int resultado = daoNotificacion.eliminarNotificacionesUsuario(usuario.UID);
            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }

        protected void btnMarcarLeidoNoLeido_Click(object sender, EventArgs e)
        {
            int idNotificacion = Int32.Parse(((LinkButton)sender).CommandArgument);
            notificaciones = (BindingList<notificacion>)Session["notificaciones"];
            notificacion notificacion = notificaciones.SingleOrDefault(x => x.idNotificacion == idNotificacion);
            Session["notificacionModificar"] = notificacion;
            btnMarcarNoLeidoModal.Text = notificacion.revisada ? "Marcar como no leído" : "Marcar como leído";
            string script = "window.onload = function() { showModalForm('form-modal-ModificarNotificacion') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            Session["idNotificacionEliminar"] = Int32.Parse(((LinkButton)sender).CommandArgument);
            string script = "window.onload = function() { showModalForm('form-modal-EliminarNotificacion') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lvNotificaciones_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                var notificacion = (notificacion)((ListViewDataItem)e.Item).DataItem;
                var btnMarcarLeidoNoLeido = (LinkButton)e.Item.FindControl("btnMarcarLeidoNoLeido");
                var mensaje = (Literal)e.Item.FindControl("litMensaje");

                if (btnMarcarLeidoNoLeido != null)
                {
                    if (notificacion.revisada)
                    {
                        btnMarcarLeidoNoLeido.Text = "Marcar como no leído";
                        btnMarcarLeidoNoLeido.Visible = true;
                    }
                    else btnMarcarLeidoNoLeido.Visible=false;
                }
                // btnMarcarLeidoNoLeido.Text = notificacion.revisada ? "Marcar como no leído" : "Marcar como leído";
                //if (mensaje != null) mensaje.Text = truncarMensaje(notificacion.mensaje, 80);
                if (mensaje != null) mensaje.Text = notificacion.mensaje;
            }
        }

        public string truncarMensaje (string mensaje, int maximo)
        {
            if (mensaje.Length <= maximo) return mensaje;
            return mensaje.Substring(0, maximo) + "...";
        }

        protected void lvNotificaciones_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvNotificaciones.FindControl("dpNotificaciones") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            lvNotificaciones.DataSource = (BindingList<notificacion>)Session["notificaciones"];
            lvNotificaciones.DataBind();
        }

        [System.Web.Services.WebMethod]
        public static void MarcarComoRevisada(int idNotificacion)
        {
            try
            {
                NotificacionWSClient daoNotificacion = new NotificacionWSClient();
                int resultado = daoNotificacion.marcarNotificacionLeida(idNotificacion);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al marcar la notificación como revisada.", ex);
            }
        }
    }
}