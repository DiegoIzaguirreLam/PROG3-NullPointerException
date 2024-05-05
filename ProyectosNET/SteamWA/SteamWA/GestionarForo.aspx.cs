using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class GestionarForo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String nombre = Request.QueryString["foro"];
            if(nombre != null)
            {
                nombreForo.Text = nombre;
            }
        }

        protected void btnCrearSubforo_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-subforo') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbAbrirSubforo_Click(object sender, EventArgs e)
        {
            string nombreForo = "pruebita de subforo";
            //int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            //Foro foro = areas.SingleOrDefault(x => x.IdArea == idArea);
            //Session["objeto"]=foro
            Response.Redirect("GestionarSubforo.aspx?subforo=" + nombreForo);
        }

        protected void lbActualizarSubforo_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-actualizar') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbEliminarSubforo_Click(object sender, EventArgs e)
        {

        }
    }
}