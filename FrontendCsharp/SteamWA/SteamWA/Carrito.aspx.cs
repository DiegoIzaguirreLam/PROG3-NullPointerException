using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Carrito : System.Web.UI.Page
    {
        private BindingList<producto> listaCarrito;
        private cartera cartera;
        private SteamServiceWS.MovimientoWSClient daoMovimiento;
        private SteamServiceWS.ProductoAdquiridoWSClient daoProductoAdquirido;
        private SteamWA.SteamServiceWS.BibliotecaWSClient daoBiblioteca;
        private SteamServiceWS.CarteraWSClient daoCartera;
        private SteamServiceWS.NotificacionWSClient daoNotificacion;
        protected void Page_Load(object sender, EventArgs e)
        {
            daoBiblioteca = new SteamServiceWS.BibliotecaWSClient();
            LabelFaltaFondos.Style["display"] = "none";

            daoMovimiento = new SteamServiceWS.MovimientoWSClient();
            daoProductoAdquirido = new SteamServiceWS.ProductoAdquiridoWSClient();
            daoCartera = new SteamServiceWS.CarteraWSClient();
            daoNotificacion = new SteamServiceWS.NotificacionWSClient();
            cartera = daoCartera.buscarCartera(((usuario)Session["usuario"]).UID);
             listaCarrito = null;
            if (Session["ElementosCarrito"] != null)
            {
                listaCarrito = (BindingList<producto>)Session["ElementosCarrito"];
                double montoTotal=0;
                foreach(producto p in listaCarrito)
                {
                    montoTotal += Double.Parse(p.precio.ToString());
                   
                }
                labelTotalCarrito.InnerText = "Total Estimado: S/." + montoTotal.ToString();
                valorTotal.Value = montoTotal.ToString();
                  mostrarListaProductos(listaCarrito);

            }
        }

        protected void btmComprar_Click(object sender, EventArgs e)
        {
            if (listaCarrito != null && listaCarrito.Count >0) {
                if((cartera.fondos - double.Parse(valorTotal.Value.ToString())) >=0)
                {

              
                movimiento mov = new movimiento();
                mov.idTransaccion = "COMPRAPRODUCTOS_"+ ((usuario)Session["usuario"]).nombreCuenta+ (double.Parse(valorTotal.Value.ToString()) / listaCarrito.Count).ToString();
                mov.cartera = cartera;
                mov.monto = double.Parse(valorTotal.Value.ToString());
                mov.fechaSpecified = true;
                mov.tipoSpecified = true;
                mov.fecha = DateTime.Now;
                mov.tipo = tipoMovimiento.RETIRO;
                daoMovimiento.insertarMovimiento(mov);
                biblioteca bibl = daoBiblioteca.buscarBibliotecaPorUID(((usuario)Session["usuario"]).UID);
                foreach (producto p in listaCarrito)
                {
                    productoAdquirido pA = new productoAdquirido();
                    pA.activo = true;
                    pA.producto = p;
                    pA.oculto = false;
                    pA.fechaAdquisicion = DateTime.Now;
                    pA.biblioteca = bibl;
                    pA.tiempoUso = new DateTime(0);
                    daoProductoAdquirido.insertarProductoAdquirido(pA);
                    agregarNotificacion(pA.producto);
                }
                    cartera.fondos = cartera.fondos - double.Parse(valorTotal.Value.ToString());
                    daoCartera.actualizarCartera(cartera);
                listaCarrito = null;
                Session["ElementosCarrito"] = null;
                Response.Redirect("Biblioteca.aspx");
                }
                else
                {
                    LabelFaltaFondos.Style["display"] = "block";
                }
            }
        }
        protected void clik_EliminarProductoCarrito(object sender, CommandEventArgs e)
        {
            int id = Int32.Parse(e.CommandArgument.ToString());

            producto prodEncontrado = listaCarrito.FirstOrDefault(p => p.idProducto == id);
            if (prodEncontrado != null)
            {

                listaCarrito.Remove(prodEncontrado);
                
            }
            Session["ElementosCarrito"] = listaCarrito;
            mostrarListaProductos(listaCarrito);
        }
        public void mostrarListaProductos(BindingList<SteamWA.SteamServiceWS.producto> lProds)
        {
            if (Session["ElementosCarrito"] != null)
            {
                BindingList<producto> listaCarrito = (BindingList<producto>)Session["ElementosCarrito"];

            }
            if (lProds != null)
            {
                HtmlGenericControl divHtmlContainer = new HtmlGenericControl("div");
                placeholderProductosCarrito.Controls.Clear();
                divHtmlContainer.Attributes["class"] = "row mt-3 pb-4";
                divHtmlContainer.Attributes["id"] = "contenedorProductos";

                foreach (producto prod in lProds)
                {

                    HtmlGenericControl divHtmlCardColumn = new HtmlGenericControl("div");
                    HtmlGenericControl divHtmlCard = new HtmlGenericControl("div");

                    divHtmlCardColumn.Attributes["class"] = "col-md-4 mb-4";
                    divHtmlCard.Attributes["class"] = "card h-100 bg-dark-subtle border-shadow";

                    divHtmlContainer.Controls.Add(divHtmlCardColumn);
                    divHtmlCardColumn.Controls.Add(divHtmlCard);


                    Image imagen = new Image();
                    imagen.ImageUrl = prod.portadaUrl;
                    imagen.CssClass = "card-img-top";
                    imagen.Attributes["height"] = "200";

                    HtmlGenericControl divHtmlCardBody = new HtmlGenericControl("div");
                    divHtmlCardBody.Attributes["class"] = "card-body";

                    HtmlGenericControl divHtmlCardTitle = new HtmlGenericControl("h5");
                    divHtmlCardTitle.Attributes["class"] = "card-title";
                    divHtmlCardTitle.InnerText = prod.titulo;

                    HtmlGenericControl divHtmlCardDesc = new HtmlGenericControl("p");
                    divHtmlCardDesc.Attributes["class"] = "card-text";
                    divHtmlCardDesc.InnerText = prod.descripcion;

                    HtmlGenericControl divHtmlCardPrice = new HtmlGenericControl("p");
                    divHtmlCardPrice.Attributes["class"] = "card-text";
                    divHtmlCardPrice.InnerText = "Precio: " + (prod.precio).ToString();

                    LinkButton buttonCarrito = new LinkButton();
                    buttonCarrito.CssClass = "btn btn-danger";
                    buttonCarrito.ID = "btnEliminarProd" + prod.idProducto;

                    buttonCarrito.CommandArgument = (prod.idProducto).ToString();
                    buttonCarrito.Command += clik_EliminarProductoCarrito;


                  
                    buttonCarrito.Text = "Eliminar";

                   
                    divHtmlCard.Controls.Add(imagen);
                    divHtmlCard.Controls.Add(divHtmlCardBody);
                    divHtmlCardBody.Controls.Add(divHtmlCardTitle);
                    divHtmlCardBody.Controls.Add(divHtmlCardDesc);
                    divHtmlCardBody.Controls.Add(divHtmlCardPrice);
                    divHtmlCardBody.Controls.Add(buttonCarrito);
                    placeholderProductosCarrito.Controls.Add(divHtmlContainer);
                }
            }
        }

        public void agregarNotificacion(producto producto)
        {
            notificacion notificacion = new notificacion();
            notificacion.mensaje = "Se ha agregado un nuevo producto: "+producto.titulo+ " a tu Biblioteca";
            notificacion.tipoSpecified = true;
            notificacion.tipo = tipoNotificacion.BIBLIOTECA;
            notificacion.usuario = (usuario)Session["usuario"];
            int resultado = daoNotificacion.insertarNotificacion(notificacion);
        }
    }
}