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
        private DataTable dtNotificaciones = new DataTable();
        private NotificacionWSClient daoNotificacion;
        BindingList<notificacion> notificaciones;
        int idNotificacion;

        protected void Page_Init(object sender, EventArgs e)
        {
            daoNotificacion = new NotificacionWSClient();
            //BindingList<string> tiposNotificaciones = new BindingList<string>();
            //tiposNotificaciones.Add("Amigos");
            //tiposNotificaciones.Add("Juegos");
            //tiposNotificaciones.Add("Foros");
            //tiposNotificaciones.Add("Biblioteca");

            //foreach (string tipoN in tiposNotificaciones)
            //{
            //    CheckBox chk = new CheckBox();
            //    chk.ID = "chk" + tipoN;
            //    HtmlGenericControl liNot = new HtmlGenericControl("li");
            //    HtmlGenericControl contr = new HtmlGenericControl("div");
            //    contr.Attributes["class"] = "d-flex ps-2";
            //    chk.CheckedChanged += Chk_CheckedChanged;
            //    chk.AutoPostBack = true;
            //    liNot.Attributes["class"] = "ps-2 text-light";
            //    liNot.InnerText = tipoN;

            //    contr.Controls.Add(chk);
            //    contr.Controls.Add(liNot);
            //    ddlTipoNotif.Controls.Add(contr);
            //}
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


        protected void ExpandirNotificacion_Click(object sender, EventArgs e)
        {
            idNotificacion = Int32.Parse(((LinkButton)sender).CommandArgument);
            string tipoNotificacion = string.Empty;
            string mensaje = string.Empty;
            notificaciones = (BindingList<notificacion>)Session["notificaciones"];
            // Busca en las notificaciones del usuario
            notificacion notificacion = notificaciones.SingleOrDefault(x => x.idNotificacion == idNotificacion);
            // Verifica si se encontró la información de la notificación
            if (notificacion != null)
            {
                tipoNotificacion = notificacion.tipo.ToString();
                mensaje = notificacion.mensaje;
                //notificacion.revisada = true;
                //int resultado = daoNotificacion.actualizarNotificacion(notificacion);
                Session["notificacionSeleccionada"] = notificacion;
            }
            btnMarcarNoLeido.Text = notificacion.revisada ? "Marcar como no leído" : "Marcar como leído";
            string script = $"window.onload = function() {{mostrarNotificacion('{tipoNotificacion}', '{mensaje}')}};";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        private void Chk_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            notificacion notificacion = (notificacion)Session["notificacionSeleccionada"];
            int resultado = daoNotificacion.eliminarNotificacion(notificacion.idNotificacion);
            Session["notificacionSeleccionada"] = null;
            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }

        protected void btnMarcarNoLeido_Click(object sender, EventArgs e)
        {
            notificacion notificacion = (notificacion)Session["notificacionSeleccionada"];
            notificacion.revisada = !notificacion.revisada;
            int resultado = daoNotificacion.actualizarNotificacion(notificacion);
            Session["notificacionSeleccionada"] = null;
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
    }
}