using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class AgregarFondos : System.Web.UI.Page
    {
        private string metodoPago;
        private double monto;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["monto"] != null)
            {
                monto = (double)Session["monto"];

                lblMontoNumero.Text = "S/." + monto.ToString("N2");
                lblMontoNumero.Attributes["class"] = "fw-bold";
            }
            else
            {
                Response.Redirect("Tienda.aspx");
            }
            dropdownMetodo.InnerText = "Seleccione";
            if (IsPostBack)
            {
                metodoPago = (string)Session["metodoPago"];
            }
        }

        protected void btnPaypal_Click(object sender, EventArgs e)
        {
            btnPagar.Text = "Pagar con Paypal";
            btnPagar.Visible = true;
            metodoPago = "paypal";
            dropdownMetodo.InnerText = "Paypal";
            Session["metodoPago"] = metodoPago;
        }

        protected void btnTarjeta_Click(object sender, EventArgs e)
        {
            btnPagar.Text = "Pagar con Tarjeta";
            btnPagar.Visible = true;
            metodoPago = "tarjeta";
            dropdownMetodo.InnerText = "Tarjeta";
            Session["metodoPago"] = metodoPago;
        }
        protected void btnGiftCard_Click(object sender, EventArgs e)
        {
            btnPagar.Text = "Usar mi regalo de STREAM";
            btnPagar.Visible = true;
            metodoPago = "giftCard";
            dropdownMetodo.InnerText = "GiftCard";
            Session["metodoPago"] = metodoPago;
        }

        protected void btnPagar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ConfirmarCompra.aspx");
        }

        protected void lbContinuarATienda_OnClick(object sender, EventArgs e)
        {
            Response.Redirect("Tienda.aspx");
        }
    }
}