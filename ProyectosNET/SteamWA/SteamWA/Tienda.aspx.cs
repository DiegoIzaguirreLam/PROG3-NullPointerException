using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Tienda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Steam master = (Steam)this.Master;
            master.ItemTienda.Attributes["class"] = "active";
        }

        protected void btnCarrito1_Click(object sender, EventArgs e)
        {
            /*string script = "window.onload = function() { showModalForm('form-modal-EliminarColeccion') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);*/
        }

        protected void btnCarro_Click(object sender, EventArgs e)
        {
            Response.Redirect("Carrito.aspx");
        }
    }
}