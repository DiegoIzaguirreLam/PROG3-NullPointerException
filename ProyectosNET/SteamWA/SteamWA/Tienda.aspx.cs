using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing.Printing;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Tienda : System.Web.UI.Page
    {
        private SteamWA.SteamServiceWS.ProductoWSClient daoProducto;
        BindingList<SteamWA.SteamServiceWS.producto> listaProductos;
        protected void Page_Load(object sender, EventArgs e)
        {
            Steam master = (Steam)this.Master;
            master.ItemTienda.Attributes["class"] = "active";
            
            daoProducto = new SteamServiceWS.ProductoWSClient();
           
            if (!IsPostBack)
            {
                
            listaProductos = 
            new BindingList<SteamWA.SteamServiceWS.producto>(daoProducto.listarProductos());
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Tienda", "<script src='Scripts/Steam/Tienda.js'></script>", false);
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string json = serializer.Serialize(listaProductos);
                Session["ListaProductos"] = listaProductos;

                mostrarListaProductos(listaProductos);



                //ScriptManager.RegisterStartupScript(this, this.GetType(), "EnviarInformacion", "enviarInformacion('" + json + "');", true);
            }
        }

        protected void btnCarrito1_Click(object sender, EventArgs e)
        {
            /*string script = "window.onload = function() { showModalForm('form-modal-EliminarColeccion') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);*/
        }

        protected void btnCarro_Click(object sender, EventArgs e)
        {
            Response.Redirect("Carrito.aspx");
        }

        protected void search_Click(object sender, EventArgs e)
        {
            SteamWA.SteamServiceWS.etiqueta etiqueta = new SteamWA.SteamServiceWS.etiqueta();
            etiqueta.nombre = "accion";
            if (listaProductos == null)
            {
                listaProductos =
           new BindingList<SteamWA.SteamServiceWS.producto>(daoProducto.listarProductos());
            }
            try
            {
                BindingList<SteamWA.SteamServiceWS.producto> lista =
               new BindingList<SteamWA.SteamServiceWS.producto>(daoProducto.listarProductosPorTituloDesarrollador(search_autocomplete.Text));
                listaProductos = lista;
            }
            catch
            {
                listaProductos = null;
            }
           
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string json = serializer.Serialize(listaProductos);
            Session["ListaProductos"] = listaProductos;
            mostrarListaProductos(listaProductos);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "EnviarInformacion", "enviarInformacion('" + json + "');", true);
        }

        public void mostrarListaProductos(BindingList<SteamWA.SteamServiceWS.producto> lProds)
        {
            HtmlGenericControl divHtmlContainer = new HtmlGenericControl("div");
            divHtmlContainer.Attributes["class"] = "row mt-3 pb-4";
            divHtmlContainer.Attributes["id"] = "contenedorProductos";
            foreach (producto prod in listaProductos)
            {
             
                HtmlGenericControl divHtmlCardColumn = new HtmlGenericControl("div");
                HtmlGenericControl divHtmlCard = new HtmlGenericControl("div");
                
                divHtmlCardColumn.Attributes["class"] = "col-md-4";
                divHtmlCard.Attributes["class"] = "card bg-dark-subtle border-shadow mb-4";

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

                HtmlGenericControl divHtmlCardPrice= new HtmlGenericControl("p");
                divHtmlCardPrice.Attributes["class"] = "card-text";
                divHtmlCardPrice.InnerText = "Precio: " + (prod.precio).ToString();

                LinkButton buttonCarrito = new LinkButton();
                buttonCarrito.CssClass = "btn btn-primary";
                buttonCarrito.ID = "btnCarritos" + prod.idProducto;
                buttonCarrito.Attributes["data-bs-toggle"] = "modal";
                buttonCarrito.Attributes["data-bs-target"] = "#form-modal-añadido-carrito";
                buttonCarrito.OnClientClick = "btnCarrito1_Click";
                buttonCarrito.Text = "Añadir al carrito";
                divHtmlCard.Controls.Add(imagen);
                divHtmlCard.Controls.Add(divHtmlCardBody);
                divHtmlCardBody.Controls.Add(divHtmlCardTitle);
                divHtmlCardBody.Controls.Add(divHtmlCardDesc);
                divHtmlCardBody.Controls.Add(divHtmlCardPrice);
                divHtmlCardBody.Controls.Add(buttonCarrito);
                placeholderProductos.Controls.Add(divHtmlContainer);
            }
        }
    }
}