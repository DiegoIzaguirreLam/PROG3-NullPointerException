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
            lvNotificaciones.DataSource = notificaciones;
            lvNotificaciones.DataBind();
        }


        //protected void ExpandirNotificacion_Click(object sender, EventArgs e)
        //{
        //    idNotificacion = Int32.Parse(((LinkButton)sender).CommandArgument);
        //    string tipoNotificacion = string.Empty;
        //    string mensaje = string.Empty;
        //    notificaciones = (BindingList<notificacion>)Session["notificaciones"];
        //    // Busca en las notificaciones del usuario
        //    notificacion notificacion = notificaciones.SingleOrDefault(x => x.idNotificacion == idNotificacion);
        //    // Verifica si se encontró la información de la notificación
        //    if (notificacion != null)
        //    {
        //        tipoNotificacion = notificacion.tipo.ToString();
        //        mensaje = notificacion.mensaje;
        //        //notificacion.revisada = true;
        //        //int resultado = daoNotificacion.actualizarNotificacion(notificacion);
        //        Session["notificacionSeleccionada"] = notificacion;
        //    }
        //    btnMarcarNoLeido.Text = notificacion.revisada ? "Marcar como no leído" : "Marcar como leído";
        //    string script = $"window.onload = function() {{mostrarNotificacion('{tipoNotificacion}', '{mensaje}')}};";
        //    ClientScript.RegisterStartupScript(GetType(), "", script, true);
        //}

        private void Chk_CheckedChanged(object sender, EventArgs e)
        {

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
            notificaciones = (BindingList<notificacion>)Session["notificaciones"];
            int resultado;
            foreach (notificacion not in notificaciones)
            {
                resultado = daoNotificacion.eliminarNotificacion(not.idNotificacion);
            }
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

                if (btnMarcarLeidoNoLeido != null)
                {
                    btnMarcarLeidoNoLeido.Text = notificacion.revisada ? "Marcar como no leído" : "Marcar como leído";
                }
            }
        }

        protected void lvNotificaciones_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvNotificaciones.FindControl("dpNotificaciones") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            lvNotificaciones.DataSource = (BindingList<notificacion>)Session["notificaciones"];
            lvNotificaciones.DataBind();
        }
    }
}