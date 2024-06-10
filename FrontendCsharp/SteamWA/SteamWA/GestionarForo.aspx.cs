using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.UI;
using System.Web.UI.WebControls;
using SteamWA.SteamServiceWS;

namespace SteamWA
{
    public partial class GestionarForo : System.Web.UI.Page
    {
        BindingList<subforo> subforos;
        SubforoWSClient daoSubforo;
        int pageIndex;

        protected void Page_Load(object sender, EventArgs e)
        {
            daoSubforo = new SubforoWSClient();
            
            if (Session["IndexPagesSubforo"] == null)
            {
                pageIndex = 0;
                Session["IndexPagesSubforo"] = pageIndex;
            }
            else pageIndex = (int)Session["IndexPagesSubforo"];

            if (!IsPostBack)
            {
                pageIndex = 0;
                Session["IndexPagesSubforo"] = pageIndex;
                foro auxForo = (foro)Session["foroPadre"];
                subforo[] aux = daoSubforo.mostrarSubforosForo(auxForo);
                if(aux != null) subforos = new BindingList<subforo>(aux);
                gvSubforos.DataSource = subforos;
                gvSubforos.DataBind();
                Session["subforos"] = subforos;
            }
            String nombre = Request.QueryString["foro"];
            if(nombre != null)
            {
                foro.Text = nombre;
            }
        }

        protected void btnVolverComunidad_Click(object sender, EventArgs e)
        {
            Response.Redirect("Comunidad.aspx");
        }

        protected void btnActualizarForo_Click(object sender, EventArgs e)
        {
            string nombreForo = "pruebita";
            //int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            //Foro foro = areas.SingleOrDefault(x => x.IdArea == idArea);
            //Session["objeto"]=foro
            Response.Redirect("GestionarForo.aspx?foro=" + nombreForo);
        }

        protected void btnCrearSubforo_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-subforo') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbAbrirSubforo_Click(object sender, EventArgs e)
        {                        
            string nombreForo = "pruebitaSubforo"; //Al crear foro analizará que permita máximo 15 caracteres para el nombre
            //int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            //Foro foro = areas.SingleOrDefault(x => x.IdArea == idArea);
            //Session["objeto"]=foro
            Session["foro_nombre"] = foro.Text; //Por ahora manda un String
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

        protected void gvSubforos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void gvSubforos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AbrirSubforo")
            {
                subforos = (BindingList<subforo>)Session["subforos"];
                int idSubforo = Convert.ToInt32(e.CommandArgument);
                subforo sub = subforos[idSubforo + 5 * pageIndex];
                Session["subforoPadre"] = sub;
                Response.Redirect("GestionarSubforo.aspx?subforo=" + sub.nombre);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {

        }
    }
}