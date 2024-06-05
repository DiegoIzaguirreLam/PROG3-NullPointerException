using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class GestionarCartera : System.Web.UI.Page
    {
        private cartera cartera;
        private pais pais;
        private CarteraWSClient daoCartera;
        private MovimientoWSClient daoMovimiento;
        private PaisWSClient daoPais;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario usuario = (usuario)Session["usuario"];
            if (usuario == null)
            {
                Response.Redirect("Login.aspx");
            }
            daoCartera = new CarteraWSClient();
            daoMovimiento = new MovimientoWSClient();
            daoPais = new PaisWSClient();
            cartera = daoCartera.buscarCartera(usuario.UID);
            pais = daoPais.buscarPais(usuario.pais.idPais);
            if(cartera == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                pBalanceCartera.InnerText = pais.moneda.simbolo + cartera.fondos.ToString("N2");
                cartera.movimientos = daoMovimiento.listarMovimientos(cartera);
                Session["cartera"] = cartera;
            }

            hAgregar15.InnerText = "Agregar " + pais.moneda.simbolo + "15";
            hAgregar30.InnerText = "Agregar " + pais.moneda.simbolo + "30";
            hAgregar50.InnerText = "Agregar " + pais.moneda.simbolo + "50";
            hAgregar100.InnerText = "Agregar " + pais.moneda.simbolo + "100";
            hCartera.InnerHtml = "Agregar fondos a la cartera de <strong>" + usuario.nombreCuenta + "</strong>";
            txtMonedaPersonalizado.Text = pais.moneda.simbolo;
            Session["moneda"] = pais.moneda;
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            double monto = Double.Parse(((LinkButton)sender).CommandArgument);
            Session["monto"] = monto;
            Response.Redirect("SeleccionarMetodoPago.aspx");
        }

        protected void btnAgregarPersonalizado_Click(object sender, EventArgs e)
        {
            string input = txtMontoPersonalizado.Text.Trim();
            double montoPersonalizado;
            if(!double.TryParse(input, out montoPersonalizado))
            {
                lblMensajeError.Text = "Por favor ingrese un valor numérico válido";
                lblMensajeError.Visible = true;
                return;
            }
            if(montoPersonalizado < 15)
            {
                lblMensajeError.Text = "El monto debe ser mayor o igual a " + pais.moneda.simbolo + "15.00";
                lblMensajeError.Visible = true;
                return;
            }
            Session["monto"] = montoPersonalizado;
            Response.Redirect("SeleccionarMetodoPago.aspx");
        }
    }
}