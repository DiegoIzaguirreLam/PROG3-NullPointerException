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
        private usuario usuario;
        private string metodoPagoStr;
        private double monto;
        private cartera cartera;
        private CarteraWSClient daoCartera;
        private MovimientoWSClient daoMovimiento;

        protected void Page_Load(object sender, EventArgs e)
        {
            string simbolo_moneda = (string)Session["simbolo"];
            usuario = (usuario)Session["usuario"];
            cartera = (cartera)Session["cartera"];
            if (usuario == null || cartera == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (Session["metodoPago"]==null || Session["monto"]==null)
            {
                Response.Redirect("GestionarCartera.aspx");
            }
            else
            {
                metodoPagoStr = (string)Session["metodoPago"];
                monto = (double)Session["monto"];
            }
            daoCartera = new CarteraWSClient();
            daoMovimiento = new MovimientoWSClient();
            pMonto.InnerText = simbolo_moneda + monto.ToString("N2");
            pTotal.InnerText = simbolo_moneda + monto.ToString("N2");
            pMetodoPago.InnerText = "Método de Pago: " + metodoPagoStr.ToUpper();
            pCuenta.InnerHtml = "Cuenta de STREAM: <strong>" + usuario.nombreCuenta + "</strong>";
        }

        protected void lbCambiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarFondos.aspx");
        }

        protected void btnPagar_Click(object sender, EventArgs e)
        {
            metodoPago metodoPago;
            movimiento movimiento = new movimiento();
            if (chkTerminosCondiciones.Checked == false)
            {
                txtFondosModal.InnerText = "Debe aceptar los términos y condiciones para pagar";
                btnAceptarModal.Visible = true;
                lbContinuarATienda.Visible = false;
            }
            else
            {
                if (metodoPagoStr == "paypal")
                {
                    metodoPago = metodoPago.PAYPAL;
                    btnAceptarModal.Visible = true;
                    lbContinuarATienda.Visible = false;
                    txtFondosModal.InnerText = "Este método de pago será soportado próximamente";
                    btnPagar.Visible = false;
                }
                else if (metodoPagoStr == "tarjeta")
                {
                    metodoPago = metodoPago.TARJETA;
                    btnAceptarModal.Visible = true;
                    lbContinuarATienda.Visible = false;
                    txtFondosModal.InnerText = "Este método de pago será soportado próximamente";
                    btnPagar.Visible = false;
                }
                else if (metodoPagoStr == "giftCard")
                {

                    cartera.fondos += monto;
                    cartera.cantMovimientos++;

                    metodoPago = metodoPago.GIFTCARD;
                    btnAceptarModal.Visible = false;
                    lbContinuarATienda.Visible = true;
                    movimiento.fechaSpecified = true;
                    movimiento.metodoPagoSpecified = true;
                    movimiento.tipoSpecified = true;
                    movimiento.metodoPago = metodoPago;
                    movimiento.fecha = DateTime.Now;
                    movimiento.cartera = cartera;
                    movimiento.monto = monto;
                    movimiento.tipo = tipoMovimiento.DEPOSITO;
                    movimiento.idTransaccion = "GIFTCARD-" + usuario.nombreCuenta.ToUpper() + "-" + cartera.cantMovimientos.ToString("D5");

                    if (daoMovimiento.insertarMovimiento(movimiento)!=0 && daoCartera.actualizarCartera(cartera) != 0)
                    {
                        txtFondosModal.InnerText = "Se han agregado los fondos de manera exitosa";
                    }
                    else
                    {
                        txtFondosModal.InnerText = "Ocurrió un error en la agregación de fondos. Por favor intente de nuevo más tarde";
                        lbContinuarATienda.Text = "Aceptar";
                    }
                }
            }
            string script = "window.onload = function() { showModalForm('form-modal-FondosAgregados') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbContinuarATienda_OnClick(object sender, EventArgs e)
        {
            Response.Redirect("Tienda.aspx");
        }

    }
}