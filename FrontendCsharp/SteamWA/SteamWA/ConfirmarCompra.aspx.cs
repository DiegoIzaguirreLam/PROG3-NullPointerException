using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class ConfirmarCompra : System.Web.UI.Page
    {
        private string metodoPago;
        private double montoTotal;
        private cartera cartera;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario usuario = (usuario)Session["usuario"];
            if (usuario == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (Session["metodoPago"]==null || Session["monto"]==null)
            {
                Response.Redirect("GestionarCartera.aspx");
            }
            else
            {
                metodoPago = (string)Session["metodoPago"];
                montoTotal = (double)Session["monto"];
            }
            pMonto.InnerText = montoTotal.ToString("N2");
            pTotal.InnerText = montoTotal.ToString("N2");
            pMetodoPago.InnerText = "Método de Pago: " + metodoPago;
            pCuenta.InnerText = "Cuenta de STREAM: " + usuario.nombreCuenta;
        }

        protected void lbCambiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarFondos.aspx");
        }

        protected void btnPagar_Click(object sender, EventArgs e)
        {
            if (metodoPago == "paypal")
            {
                btnAceptarModal.Visible = true;
                lbContinuarATienda.Visible = false;
                txtFondosModal.InnerText = "Este método de pago será soportado próximamente";
                btnPagar.Visible = false;
            }
            else if (metodoPago == "tarjeta")
            {
                btnAceptarModal.Visible = true;
                lbContinuarATienda.Visible = false;
                txtFondosModal.InnerText = "Este método de pago será soportado próximamente";
                btnPagar.Visible = false;
            }
            else if (metodoPago == "giftCard")
            {
                btnAceptarModal.Visible = false;
                lbContinuarATienda.Visible = true;
                txtFondosModal.InnerText = "Se han agregado los fondos de manera exitosa";


            }


            string script = "window.onload = function() { showModalForm('form-modal-FondosAgregados') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }
    }
}