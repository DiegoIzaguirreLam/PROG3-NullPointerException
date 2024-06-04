using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Steam : System.Web.UI.MasterPage
    {
        public HtmlAnchor ItemTienda { get => itemTienda; set => itemTienda = value; }

        public HtmlAnchor ItemBiblioteca { get => itemBiblioteca; set => itemBiblioteca = value; }

        public HtmlAnchor ItemComunidad { get => itemComunidad; set => itemComunidad = value; }

        public HtmlAnchor ItemAmigos { get => itemAmigos; set => itemAmigos = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Si existe el usuario
                if (Session["usuario"] != null) { nombreUsuario.InnerText = ((usuario)Session["usuario"]).nombrePerfil; }
            }
        }
    }
}