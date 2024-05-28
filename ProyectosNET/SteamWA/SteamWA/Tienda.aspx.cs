using System;
using System.Collections.Generic;
using System.ComponentModel;
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
                ScriptManager.RegisterStartupScript(this, this.GetType(), "EnviarInformacion", "enviarInformacion('" + json + "');", true);
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
            ScriptManager.RegisterStartupScript(this, this.GetType(), "EnviarInformacion", "enviarInformacion('" + json + "');", true);
        }
    }
}