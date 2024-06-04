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
        private string metodoPagoStr;
        private double monto;
        private cartera cartera;
        private CarteraWSClient daoCartera;
        private MovimientoWSClient daoMovimiento;

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
                metodoPagoStr = (string)Session["metodoPago"];
                monto = (double)Session["monto"];
            }
            daoCartera = new CarteraWSClient();
            daoMovimiento = new MovimientoWSClient();
            pMonto.InnerText = monto.ToString("N2");
            pTotal.InnerText = monto.ToString("N2");
            pMetodoPago.InnerText = "Método de Pago: " + metodoPagoStr;
            pCuenta.InnerText = "Cuenta de STREAM: " + usuario.nombreCuenta;
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
                    
                    cartera.fondos += monto;
                    cartera.cantMovimientos++;

                    if (daoMovimiento.insertarMovimiento(movimiento)== 1 && daoCartera.actualizarCartera(cartera) == 1)
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
    }
}