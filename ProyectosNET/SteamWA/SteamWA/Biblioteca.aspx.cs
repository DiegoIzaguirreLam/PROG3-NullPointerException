using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Biblioteca : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Steam master = (Steam)this.Master;
            master.ItemBiblioteca.Attributes["class"] = "active";
        }

        protected void lbLogros_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-logros') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbPrograma_Click(object sender, EventArgs e)
        {
            String nProg = ((LinkButton)sender).CommandArgument;
            //capturar id
            //buscar programa en arreglo
            tituloPrograma.InnerText = "Programa " + nProg;
            infoPrograma.Style.Value = "block";
        }

    }
}