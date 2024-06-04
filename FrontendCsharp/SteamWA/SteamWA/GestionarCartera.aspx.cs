using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class GestionarCartera : System.Web.UI.Page
    {
        private cartera cartera;
        private CarteraWSClient daoCartera;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario usuario = (usuario)Session["usuario"];
            if (usuario == null)
            {
                Response.Redirect("Login.aspx");
            }
            daoCartera = new CarteraWSClient();
            cartera = daoCartera.buscarCartera(usuario.cartera.idCartera);

            if(cartera == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                pBalanceCartera.InnerText = usuario.pais.moneda.simbolo + cartera.fondos;
                Session["cartera"] = cartera;
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            double monto = Double.Parse(((LinkButton)sender).CommandArgument);
            Session["monto"] = monto;
            Response.Redirect("AgregarFondos.aspx");
        }

    }
}