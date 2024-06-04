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
        private PaisWSClient daoPais;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario usuario = (usuario)Session["usuario"];
            if (usuario == null)
            {
                Response.Redirect("Login.aspx");
            }
            daoCartera = new CarteraWSClient();
            daoPais = new PaisWSClient();
            cartera = daoCartera.buscarCartera(usuario.UID);
            pais pais = daoPais.buscarPais(usuario.pais.idPais);
            if(cartera == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                pBalanceCartera.InnerText = pais.moneda.simbolo + cartera.fondos.ToString("N2");
                Session["cartera"] = cartera;
            }
            hAgregar15.InnerText = "Agregar " + pais.moneda.simbolo + "15";
            hAgregar30.InnerText = "Agregar " + pais.moneda.simbolo + "30";
            hAgregar50.InnerText = "Agregar " + pais.moneda.simbolo + "50";
            hAgregar100.InnerText = "Agregar " + pais.moneda.simbolo + "100";
            hCartera.InnerHtml = "Agregar fondos a la cartera de <strong>" + usuario.nombreCuenta + "</strong>";
            Session["simbolo"] = pais.moneda.simbolo;
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            double monto = Double.Parse(((LinkButton)sender).CommandArgument);
            Session["monto"] = monto;
            Response.Redirect("AgregarFondos.aspx");
        }

    }
}