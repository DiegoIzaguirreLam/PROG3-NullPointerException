using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Comunidad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindingList<Foro> foros = new BindingList<Foro>();
            Foro proof = new Foro(1, "PRUEBAAA", "Este es un foro", "GianLukaGG", "https://avatars.akamai.steamstatic.com/f698ccb1d89632d7f174c142b789b84d4ec2dab6_full.jpg");
            foros.Add(proof);
            gvForos.DataSource = foros;
            gvForos.DataBind();
            Steam master = (Steam)this.Master;
            master.ItemComunidad.Attributes["class"] = "active";
            ComunidadWS.ComunidadWSClient a = new ComunidadWS.ComunidadWSClient();
            a.hello("a");
            
        }

        protected void btnActualizarComunidad_Click(object sender, EventArgs e)
        {
            Response.Redirect("Comunidad.aspx");
        }

        protected void btnCrearForo_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-foro') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbAbrirForo_Click(object sender, EventArgs e)
        {
            string nombreForo = "pruebita";
            //int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            //Foro foro = areas.SingleOrDefault(x => x.IdArea == idArea);
            //Session["objeto"]=foro
            Response.Redirect("GestionarForo.aspx?foro="+nombreForo);
        }

        protected void lbActualizarInfoForo_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-edicion') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbEliminarForo_Click(object sender, EventArgs e)
        {

        }
    }
}