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

        }
    }
}