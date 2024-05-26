using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Biblioteca : System.Web.UI.Page
    {
        private ProductoAdquiridoWSClient daoProductoAdquirido;
        private BindingList<productoAdquirido> productosAdquiridos;

        protected void Page_Load(object sender, EventArgs e)
        {
            Steam master = (Steam)this.Master;
            master.ItemBiblioteca.Attributes["class"] = "active";

        }
        protected void Page_Init(object sender, EventArgs e)
        {
            daoProductoAdquirido = new ProductoAdquiridoWSClient();
            productoAdquirido[] productoArr = daoProductoAdquirido.listarProductosAdquiridosPorIdBiblioteca(1);
            productosAdquiridos = new BindingList<productoAdquirido>(productoArr);

            generarListaProductosAdquiridos();
        }

        protected void generarListaProductosAdquiridos()
        {
            foreach (productoAdquirido productoAdquirido in productosAdquiridos)
            {
                // Crear el elemento li
                var li = new HtmlGenericControl("li");
                li.Attributes["class"] = "list-group-item text-gray bg-transparent";
                li.Attributes["id"] = "liPrograma" + productoAdquirido.idProductoAdquirido;

                // Crear la imagen
                var img = new HtmlImage
                {
                    Src = productoAdquirido.producto.logoUrl,
                    Height = 30
                };

                // Crear el LinkButton
                var linkButton = new LinkButton
                {
                    ID = "lbPrograma" + productoAdquirido.idProductoAdquirido,
                    Text = productoAdquirido.producto.titulo,
                    CssClass = "text-decoration-none text-white",
                    CommandArgument = productoAdquirido.idProductoAdquirido.ToString()
                };
                linkButton.Click += lbPrograma_Click;

                // Agregar la imagen y el LinkButton al elemento li
                li.Controls.Add(img);
                li.Controls.Add(new Literal { Text = " " }); // Espacio entre la imagen y el LinkButton
                li.Controls.Add(linkButton);

                // Agregar el elemento li a la lista ul
                ulProgramas.Controls.Add(li);
            }
        }

        protected void lbLogros_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-logros') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbPrograma_Click(object sender, EventArgs e)
        {

            int idProductoAdquirido = Int32.Parse(((LinkButton)sender).CommandArgument);
            //capturar id
            //buscar programa en arreglo
            productoAdquirido productoAdquirido = productosAdquiridos.SingleOrDefault(x => x.idProductoAdquirido == idProductoAdquirido);
            producto producto = productoAdquirido.producto;
            imgPrograma.Src = producto.portadaUrl;
            txtTituloPrograma.InnerText = producto.titulo;
            txtDescripcionPrograma.InnerText = producto.descripcion;
            txtFechaEjecucionPrograma.InnerHtml = "<strong>Última ejecución: </strong>" + producto.fechaPublicacion.ToString("dd/MM/yyyy");
            txtTiempoUsoPrograma.InnerHtml = "<strong>Tiempo de uso: </strong>" + productoAdquirido.tiempoUso.ToString("hh:mm:ss");
            txtActualizadoPrograma.InnerHtml = "<strong>Actualizado: </strong>" + (productoAdquirido.actualizado ? "Sí" : "No");
            if(producto is juego)
            {
                lbLogros.Visible = true;
                divBotonesPrograma.Attributes["class"] = "d-flex justify-content-between";
            }
            else
            {
                lbLogros.Visible = false;
                divBotonesPrograma.Attributes["class"] = "d-flex justify-content-end";
            }

            if (!productoAdquirido.actualizado)
            {
                lbJugar.Text = "Actualizar";
            }
            else
            {
                lbJugar.Text = "Jugar";
            }
            infoPrograma.Style.Value = "block";
        }

    }
}