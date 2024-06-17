using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text.RegularExpressions;
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
        protected void Page_Load(object sender, EventArgs e)
        {
            double montoUsado=0;
            usuario usuario = (usuario)Session["usuario"];
            if (usuario == null)
            {
                Response.Redirect("Login.aspx");
            }
            daoCartera = new CarteraWSClient();
            daoMovimiento = new MovimientoWSClient();
            cartera = daoCartera.buscarCartera(usuario.UID);
            pais = usuario.pais;
            if (cartera == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                pBalanceCartera.InnerText = pais.moneda.simbolo + (cartera.fondos*pais.moneda.cambioDeDolares).ToString("N2");
                cartera.movimientos = daoMovimiento.listarMovimientos(cartera);
                Session["cartera"] = cartera;
            }
            if (cartera.movimientos != null)
            {
                foreach (movimiento movimiento in cartera.movimientos)
                {
                    if (movimiento.tipo == tipoMovimiento.DEPOSITO && movimiento.metodoPago == SteamServiceWS.metodoPago.GIFTCARD)
                    {
                        montoUsado += movimiento.monto;
                    }
                }
                montoUsado *= pais.moneda.cambioDeDolares;
            }

            hAgregar15.InnerText = "Agregar " + pais.moneda.simbolo + "15";
            hAgregar30.InnerText = "Agregar " + pais.moneda.simbolo + "30";
            hAgregar50.InnerText = "Agregar " + pais.moneda.simbolo + "50";
            hAgregar100.InnerText = "Agregar " + pais.moneda.simbolo + "100";
            hCartera.InnerHtml = "Agregar fondos a la cartera de <strong>" + usuario.nombreCuenta + "</strong>";
            txtMonedaPersonalizado.Text = pais.moneda.simbolo;
            pCreditoUtilizado.InnerHtml = "Usted ha retirado <strong>" + pais.moneda.simbolo + montoUsado.ToString("N2") + "</strong> del crédito de "+ pais.moneda.simbolo + (100 * pais.moneda.cambioDeDolares).ToString("N2") + " que le ha otorgado STREAM.";
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

            if (!double.TryParse(input, out montoPersonalizado))
            {
                lblMensajeError.Text = "Por favor ingrese un valor numérico válido";
                lblMensajeError.Visible = true;
                return;
            }

            string inputNormalizada = montoPersonalizado.ToString("F2");
            if (!Regex.IsMatch(inputNormalizada, @"^\d+(\.\d{1,2})?$")) // para ver si tiene como maximo 2 decimales
            {
                lblMensajeError.Text = "Por favor, ingrese un valor numérico válido con como máximo 2 decimales.";
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