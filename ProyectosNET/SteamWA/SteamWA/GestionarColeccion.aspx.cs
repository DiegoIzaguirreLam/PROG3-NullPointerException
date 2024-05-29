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
    public partial class GestionarColeccion : System.Web.UI.Page
    {
        private ColeccionWSClient daoColeccion;
        private ProductoAdquiridoColeccionWSClient daoProductoAdquiridoColeccion;
        private BindingList<productoAdquirido> productosAdquiridos;
        private BindingList<productoAdquirido> productosEnColeccion;
        private coleccion coleccionS;
        private Estado estado;
        

        protected void Page_Init(object sender, EventArgs e) //terminar coleccion: soporte a caso insertar/modificar
        {
            if (Session["usuario"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            daoColeccion = new ColeccionWSClient();
            daoProductoAdquiridoColeccion = new ProductoAdquiridoColeccionWSClient();
            productosAdquiridos = (BindingList<productoAdquirido>)Session["productosAdquiridos"];
            if (productosAdquiridos == null) Response.Redirect("Biblioteca.aspx");

            string accion = Request.QueryString["accion"];
            if (accion != null && accion=="modificar")
            {
                coleccionS = (coleccion)Session["coleccion"];
                if (coleccionS.productos != null)
                {
                    productosEnColeccion = new BindingList<productoAdquirido>(coleccionS.productos);
                }
                else
                {
                    productosEnColeccion = null;
                }
                txtNombreColeccion.Value = coleccionS.nombre;
                estado = Estado.ACTUALIZAR;
                hGestionarColeccion.InnerText = "Editar Colección";
            }
            else
            {
                coleccionS = null;
                txtNombreColeccion.Value = "";
                estado = Estado.NUEVO;
                hGestionarColeccion.InnerText = "Nueva Colección";
            }
            
            generarTablaProductosAdquiridos();
        }

        protected void generarTablaProductosAdquiridos()
        {
            // recorrer la lista de productos y agregar cada uno como una fila a la tabla
            foreach (productoAdquirido producto in productosAdquiridos)
            {
                HtmlTableRow fila = new HtmlTableRow();

                // agregar la celda para el checkbox
                HtmlTableCell celdaCheckbox = new HtmlTableCell();
                CheckBox checkbox = new CheckBox();
                checkbox.ID = "chkProductoAdquirido" + producto.idProductoAdquirido; // Asignar un ID único
                checkbox.Attributes["idProductoAdquirido"] = producto.idProductoAdquirido.ToString();
                if(estado == Estado.ACTUALIZAR && productosEnColeccion!=null &&
                    productosEnColeccion.SingleOrDefault(x=>x.idProductoAdquirido == producto.idProductoAdquirido)!=null)
                {
                    checkbox.Checked = true;
                }
                celdaCheckbox.Controls.Add(checkbox);

                // agregar la celda para el nombre del producto
                HtmlTableCell celdaNombre = new HtmlTableCell();
                celdaNombre.InnerText = producto.producto.titulo;

                fila.Cells.Add(celdaCheckbox);
                fila.Cells.Add(celdaNombre);

                // agregar la fila a la tabla
                tablaProductos.Rows.Add(fila);
            }
        }

        protected void btnEliminarColeccion_OnClick(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-EliminarColeccion') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }
        protected void btnCancelar_OnClick(object sender, EventArgs e)
        {
            Response.Redirect("Biblioteca.aspx");
        }

        protected void btnGuardar_OnClick(object sender, EventArgs e)
        {
            int resultado = 0;
            if (coleccionS == null) coleccionS = new coleccion();
            coleccionS.nombre = txtNombreColeccion.Value;
            coleccionS.biblioteca = new biblioteca();
            coleccionS.biblioteca.idBiblioteca = (int)Session["idBiblioteca"];
            if (estado == Estado.NUEVO)
            {
                resultado = daoColeccion.insertarColeccion(coleccionS);
                if (resultado!=0)
                {
                    coleccionS.idColeccion = resultado;
                }
            }
            else
            {
                resultado = daoColeccion.actualizarColeccion(coleccionS);
            }
            guardaProductosAdquiridosColeccion();
            Response.Redirect("Biblioteca.aspx");
        }

        protected void guardaProductosAdquiridosColeccion()
        {
            int resultado = 0;
            // iterar filas de la tabla
            foreach (HtmlTableRow fila in tablaProductos.Rows)
            {
                HtmlTableCell celdaCheckbox = fila.Cells[0];
                // buscar el checkbox que esta al inicio de la celda
                CheckBox checkbox = celdaCheckbox.Controls.OfType<CheckBox>().FirstOrDefault();
                int idProductoAdquirido = int.Parse(checkbox.Attributes["idProductoAdquirido"]);
                // si el checkbox está marcado
                if (checkbox.Checked)
                {
                    if (productosEnColeccion != null && productosEnColeccion.SingleOrDefault(x => x.idProductoAdquirido == idProductoAdquirido)!=null) // si ya esta en la coleccion
                    {
                        continue;
                    }
                    else
                    {
                        resultado =
                        daoProductoAdquiridoColeccion.insertarProductoAdquiridoAColeccion(coleccionS.idColeccion,
                        idProductoAdquirido);
                    }
                }
                else //si no esta marcado, se elimina el producto si que fue desmarcado
                {
                    if(estado == Estado.ACTUALIZAR && productosEnColeccion!=null 
                        && productosEnColeccion.SingleOrDefault(x => x.idProductoAdquirido == idProductoAdquirido)!=null)
                    {
                        resultado = daoProductoAdquiridoColeccion.eliminarProductoAdquiridoDeColeccion(coleccionS.idColeccion,
                            idProductoAdquirido);
                    }
                }
            }
        }

        protected void btnEliminar_OnClick(object sender, EventArgs e)
        {
            if(estado == Estado.ACTUALIZAR)
            {
                daoColeccion.eliminarColeccion(coleccionS.idColeccion);
            }
            
            Response.Redirect("Biblioteca.aspx");
        }
    }
}