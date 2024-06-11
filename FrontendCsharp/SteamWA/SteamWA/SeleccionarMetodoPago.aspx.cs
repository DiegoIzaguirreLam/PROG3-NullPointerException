using SteamWA.SteamServiceWS;
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
        private cartera cartera;
        private string metodoPago;
        private double monto;
        private tipoMoneda moneda;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["cartera"] != null)
            {
                cartera = (cartera)Session["cartera"];
            }
            else
            {
                Response.Redirect("GestionarCartera.aspx");
            }
            if (Session["moneda"] != null)
            {
                moneda = (tipoMoneda)Session["moneda"];
            }
            if (Session["monto"] != null)
            {
                monto = (double)Session["monto"];

                lblMontoNumero.Text = moneda.simbolo + monto.ToString("N2");
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
            pNoSoportado.Visible = false;
        }

        protected void btnPaypal_Click(object sender, EventArgs e)
        {
            btnPagar.Text = "Pagar con Paypal";
            btnPagar.Visible = false;
            pNoSoportado.Visible = true;
            pNoSoportado.InnerHtml = "<i class='fa-solid fa-circle-exclamation'></i>" + " Este método de pago aún no es soportado por Stream";
            metodoPago = "paypal";
            dropdownMetodo.InnerText = "Paypal";
            Session["metodoPago"] = metodoPago;
        }

        protected void btnTarjeta_Click(object sender, EventArgs e)
        {
            btnPagar.Text = "Pagar con Tarjeta";
            btnPagar.Visible = false;
            pNoSoportado.Visible = true;
            pNoSoportado.InnerHtml = "<i class='fa-solid fa-circle-exclamation'></i>" + " Este método de pago aún no es soportado por Stream";
            metodoPago = "tarjeta";
            dropdownMetodo.InnerText = "Tarjeta";
            Session["metodoPago"] = metodoPago;
        }
        protected void btnGiftCard_Click(object sender, EventArgs e)
        {
            double montoDolares=0;
            if (cartera.movimientos != null)
            {
                foreach (movimiento movimiento in cartera.movimientos)
                {
                    if (movimiento.tipo == tipoMovimiento.DEPOSITO && movimiento.metodoPago == SteamServiceWS.metodoPago.GIFTCARD)
                    {
                        montoDolares+=movimiento.monto;
                    }
                }
            }
            montoDolares = montoDolares/moneda.cambioDeDolares;
            if(montoDolares + monto/moneda.cambioDeDolares < 100)
            {
                btnPagar.Text = "Usar mi regalo de STREAM";
                btnPagar.Visible = true;
                btnPagar.Enabled = true;
                pNoSoportado.Visible = false;
            }
            else
            {
                double montoPermitido = (100-montoDolares)*moneda.cambioDeDolares;
                pNoSoportado.InnerHtml = "<i class='fa-solid fa-circle-exclamation'></i>" + " No cuenta con suficientes fondos de regalo de STREAM (" + moneda.simbolo + montoPermitido.ToString("N2") + " restante). Escoja otra opción o espere a recibir más.";
                pNoSoportado.Visible = true;
            }
            metodoPago = "giftCard";
            dropdownMetodo.InnerText = "GiftCard";
            Session["metodoPago"] = metodoPago;
        }

        protected void btnPagar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ConfirmarCompra.aspx");
        }

    }
}