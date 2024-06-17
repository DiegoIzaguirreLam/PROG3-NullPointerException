using SteamWA.SteamServiceWS;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.InteropServices;
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
        private BindingList<productoAdquirido> productosColecciones;
        private ColeccionWSClient daoColeccion;
        private BindingList<coleccion> colecciones;
        private BibliotecaWSClient daoBiblioteca;
        private NotificacionWSClient daoNotificacion;
        private ReportesWSClient daoReportes;
        private int nColeccionesActivas;
        private int idBiblioteca;

        protected void Page_Load(object sender, EventArgs e)
        {
            Steam master = (Steam)this.Master;
            master.ItemBiblioteca.Attributes["class"] = "active";

        }
        protected void Page_Init(object sender, EventArgs e)
        {

            daoProductoAdquirido = new ProductoAdquiridoWSClient();
            daoColeccion = new ColeccionWSClient();
            daoBiblioteca = new BibliotecaWSClient();
            productosColecciones = new BindingList<productoAdquirido>();
            daoNotificacion = new NotificacionWSClient();
            //idBiblioteca = 1;
            if (!IsPostBack)
            {
                if (Session["usuario"] != null)
                {
                    int uid = ((usuario)Session["usuario"]).UID;
                    if (Session["idBiblioteca"] == null)
                    {
                        idBiblioteca = daoBiblioteca.buscarBibliotecaPorUID(uid).idBiblioteca;
                        Session["idBiblioteca"] = idBiblioteca;
                    }
                    else
                    {
                        idBiblioteca = (int)Session["idBiblioteca"];
                    }
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
                productoAdquirido[] productoArr = null;
                string origen = Request.QueryString["origen"];
                if (Session["productosAdquiridos"] == null || (origen!=null && origen=="carrito")) // si ya se cargo en tienda (si ya hay productos se vuelve a llamar)
                    productoArr = daoProductoAdquirido.listarProductosAdquiridosPorIdBiblioteca(idBiblioteca);
                else
                    productoArr = ((BindingList<productoAdquirido>)Session["productosAdquiridos"]).ToArray();
                if (productoArr != null)
                {
                    List<productoAdquirido> productosAdquiridosList = new List<productoAdquirido>(productoArr);
                    productosAdquiridosList.Sort((p1, p2) => string.Compare(p1.producto.titulo, p2.producto.titulo));
                    productosAdquiridos = new BindingList<productoAdquirido>(productosAdquiridosList);
                    rbNombre.Checked = true;
                    generarListaProductosAdquiridos();
                    Session["productosAdquiridos"] = productosAdquiridos;
                    pBibliotecaVacia.Visible = false;
                    contenedorProgramas.Visible = true;
                }
                else
                {
                    Session["productosAdquiridos"] = null;
                    pBibliotecaVacia.Visible = true;
                    contenedorProgramas.Visible = false;
                }
                coleccion[] coleccionesArr = daoColeccion.listarColeccionesPorBiblioteca(idBiblioteca);
                if (coleccionesArr != null)
                {
                    colecciones = new BindingList<coleccion>(coleccionesArr);
                    foreach (coleccion coleccion in colecciones)
                    {
                        coleccion.productos =
                            daoProductoAdquirido.listarProductosAdquiridosPorIdColeccion(coleccion.idColeccion);
                    }
                }
                else
                {
                    colecciones = null;
                }
                generarListaColecciones();
                Session["colecciones"] = colecciones;
                Session["nColeccionesActivas"] = 0;
                Session["productosColecciones"] = new BindingList<productoAdquirido>();
                lbLimpiarFiltros.Visible = false;
            }
            else
            {
                idBiblioteca = (int)Session["idBiblioteca"];
                productosAdquiridos = (BindingList<productoAdquirido>)Session["productosAdquiridos"];
                nColeccionesActivas = (int)Session["nColeccionesActivas"];
                productosColecciones = (BindingList<productoAdquirido>)Session["productosColecciones"];
                generarListaProductosAdquiridos();
                colecciones = (BindingList<coleccion>)Session["colecciones"];
                generarListaColecciones();
            }

        }

        protected void generarListaProductosAdquiridos()
        {
            ulProgramas.Controls.Clear();
            //productosAdquiridos = (BindingList<productoAdquirido>)Session["productosAdquiridos"];
            if (productosAdquiridos == null) return;
            foreach (productoAdquirido productoAdquirido in productosAdquiridos)
            {
                if (nColeccionesActivas > 0 && productosColecciones.FirstOrDefault(x => x.idProductoAdquirido == productoAdquirido.idProductoAdquirido) == null) continue;
                // crear el elemento li
                HtmlGenericControl li = new HtmlGenericControl("li");
                li.Attributes["class"] = "list-group-item text-gray bg-transparent";
                li.Attributes["id"] = "liPrograma" + productoAdquirido.idProductoAdquirido;

                // crear la imagen
                HtmlImage img = new HtmlImage
                {
                    Src = productoAdquirido.producto.logoUrl,
                    Height = 30
                };

                // crear el linkbutton
                LinkButton linkButton = new LinkButton
                {
                    ID = "lbPrograma" + productoAdquirido.idProductoAdquirido,
                    Text = productoAdquirido.producto.titulo,
                    CssClass = "text-decoration-none text-white",
                    CommandArgument = productoAdquirido.idProductoAdquirido.ToString()
                };
                linkButton.Click += lbPrograma_Click;

                // agregar la imagen y el linkbutton al li
                li.Controls.Add(img);
                li.Controls.Add(new Literal { Text = " " }); // espacio entre la imagen y el LinkButton
                li.Controls.Add(linkButton);

                // agregar el elemento li a la lista ul
                ulProgramas.Controls.Add(li);
            }
        }

        protected void generarListaColecciones()
        {
            if (colecciones != null)
            {
                foreach (coleccion coleccion in colecciones)
                {
                    HtmlGenericControl listItem = new HtmlGenericControl("li");

                    HtmlAnchor link = new HtmlAnchor();
                    link.Attributes.Add("class", "dropdown-item");
                    link.HRef = "#";

                    CheckBox checkbox = new CheckBox();
                    checkbox.ID = "chk" + coleccion.idColeccion.ToString(); // Asignamos un ID único al checkbox
                    if (coleccion.nombre.Length <= 13)
                    {
                        checkbox.Text = coleccion.nombre;
                    }
                    else
                    {
                        checkbox.Text = coleccion.nombre.Substring(0, 13) + "...";
                    }
                    checkbox.CssClass = "ps-2 text-light";
                    checkbox.CheckedChanged += CheckBox_CheckedChanged;
                    checkbox.AutoPostBack = true;

                    LinkButton linkButton = new LinkButton
                    {
                        ID = "lbColeccion" + coleccion.idColeccion,
                        Text = "<i class='fa-solid fa-pen-to-square'></i>",
                        CssClass = "ps-2 text-light",
                        CommandArgument = coleccion.idColeccion.ToString()
                    };
                    linkButton.Click += lbColeccion_Click;

                    // Agregamos el enlace al elemento de lista
                    listItem.Controls.Add(checkbox);
                    listItem.Controls.Add(linkButton);

                    ddlColecciones.Controls.Add(listItem);
                }
            }
            HtmlGenericControl newItem = new HtmlGenericControl("li");
            LinkButton lbNuevaColeccion = new LinkButton
            {
                ID = "lbNuevaColeccion",
                Text = "<i class='fa-solid fa-plus'></i> Nueva Colección",
                CssClass = "text-decoration-none text-light"
            };
            lbNuevaColeccion.Click += lbNuevaColeccion_Click;
            newItem.Attributes.Add("class", "dropdown-item new-hover-effect");
            newItem.Controls.Add(lbNuevaColeccion);
            ddlColecciones.Controls.Add(newItem);
        }

        protected void CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox checkbox = (CheckBox)sender;
            int idColeccion = int.Parse(checkbox.ID.Replace("chk", ""));

            coleccion coleccion = colecciones.SingleOrDefault(x => x.idColeccion == idColeccion);
            if (coleccion.productos != null)
            {
                BindingList<productoAdquirido> blColeccionProductos = new BindingList<productoAdquirido>(coleccion.productos);
                if (checkbox.Checked)
                {
                    foreach (productoAdquirido producto in blColeccionProductos)
                    {
                        productosColecciones.Add(producto);
                    }
                    nColeccionesActivas++;
                }
                else
                {
                    foreach (productoAdquirido producto in blColeccionProductos)
                    {
                        productoAdquirido productoEliminar = productosColecciones.FirstOrDefault(x => x.idProductoAdquirido == producto.idProductoAdquirido);
                        productosColecciones.Remove(productoEliminar);
                    }
                    nColeccionesActivas--;
                }
            }
            else
            {
                if (checkbox.Checked)
                {
                    nColeccionesActivas++;
                }
                else
                {
                    nColeccionesActivas--;
                }
            }
            Session["nColeccionesActivas"] = nColeccionesActivas;
            Session["productosColecciones"] = productosColecciones;
            generarListaProductosAdquiridos();
            infoPrograma.Visible = false;
            if (nColeccionesActivas > 0) lbLimpiarFiltros.Visible = true;
            else lbLimpiarFiltros.Visible = false;
        }

        protected void lbPrograma_Click(object sender, EventArgs e)
        {
            int idProductoAdquirido = Int32.Parse(((LinkButton)sender).CommandArgument);
            productoAdquirido productoAdquirido = productosAdquiridos.SingleOrDefault(x => x.idProductoAdquirido == idProductoAdquirido);
            producto producto = productoAdquirido.producto;
            imgPrograma.Src = producto.portadaUrl;
            txtTituloPrograma.InnerText = producto.titulo;
            txtDescripcionPrograma.InnerText = producto.descripcion;
            txtFechaEjecucionPrograma.InnerHtml = "<strong>Última ejecución: </strong>" +
                (productoAdquirido.fechaEjecutado.ToString("dd/MM/yyyy") == "01/01/0001" ? "Aún no ejecutado" : productoAdquirido.fechaEjecutado.ToString("dd/MM/yyyy"));
            int horas = Int32.Parse(productoAdquirido.tiempoUso.ToString("HH"));
            int minutos = Int32.Parse(productoAdquirido.tiempoUso.ToString("mm"));
            txtTiempoUsoPrograma.InnerHtml = "<strong>Tiempo de uso: </strong>";
            if (horas > 0 || minutos > 0)
            {
                txtTiempoUsoPrograma.InnerHtml += (horas == 0 ? "" : (horas.ToString() + (horas > 1 ? " horas " : " hora ")))
                    + (minutos == 0 ? "" : (minutos.ToString() + (minutos > 1 ? " minutos" : " minuto")));
            }
            else
            {
                txtTiempoUsoPrograma.InnerHtml += "Aún no usado";
            }
            txtActualizadoPrograma.InnerHtml = "<strong>Actualizado: </strong>" + (productoAdquirido.actualizado ? "Sí" : "No");
            if (productoAdquirido.actualizado) txtEspacioPrograma.InnerHtml = "<strong>Espacio Ocupado</strong>: ";
            else txtEspacioPrograma.InnerHtml = "<strong>Espacio Requerido</strong>: ";

            if (producto.espacioDisco >= 1024)
            {
                double espacioGB = producto.espacioDisco / 1024;
                txtEspacioPrograma.InnerHtml += espacioGB.ToString("N2") + " GB";
            }
            else
            {
                txtEspacioPrograma.InnerHtml += producto.espacioDisco.ToString("N2") + " MB";
            }

            if (producto is juego)
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
                lbJugar.Text = "Agregar Uso";
            }
            infoPrograma.Style.Value = "block";
            infoPrograma.Visible = true;
            Session["productoAdquiridoSeleccionado"] = productoAdquirido;
        }

        protected void lbLogros_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionarLogros.aspx");
        }

        protected void lbColeccion_Click(object sender, EventArgs e)
        {
            int idColeccion = Int32.Parse(((LinkButton)sender).CommandArgument);
            coleccion coleccion = colecciones.SingleOrDefault(x => x.idColeccion == idColeccion);
            Session["coleccion"] = coleccion;
            Response.Redirect("GestionarColeccion.aspx?accion=modificar");
        }

        protected void lbNuevaColeccion_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionarColeccion.aspx");
        }

        protected void RadioButton_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton radioButton = (RadioButton)sender;
            if (productosAdquiridos == null || productosAdquiridos.Count==1) return;
            List<productoAdquirido> productosAdquiridosList = productosAdquiridos.ToList();
            if (radioButton.ID == "rbNombre")
            {
                productosAdquiridosList.Sort((p1, p2) => string.Compare(p1.producto.titulo, p2.producto.titulo));
            }
            else if (radioButton.ID == "rbTiempo")
            {
                productosAdquiridosList.Sort((p1, p2) => -1 * (p1.tiempoUso.ToString("HH:mm:ss").CompareTo(p2.tiempoUso.ToString("HH:mm:ss"))));
            }
            else if (radioButton.ID == "rbTam")
            {
                productosAdquiridosList.Sort((p1, p2) => p1.producto.espacioDisco.CompareTo(p2.producto.espacioDisco));
            }
            else if (radioButton.ID == "rbFechaPub")
            {
                productosAdquiridosList.Sort((p1, p2) => p1.producto.fechaPublicacion.CompareTo(p2.producto.fechaPublicacion));
            }
            else if (radioButton.ID == "rbPrecio")
            {
                productosAdquiridosList.Sort((p1, p2) => p1.producto.precio.CompareTo(p2.producto.precio));
            }
            productosAdquiridos = new BindingList<productoAdquirido>(productosAdquiridosList);
            Session["productosAdquiridos"] = productosAdquiridos;
            generarListaProductosAdquiridos();
        }

        protected void lbLimpiarFiltros_Click(object sender, EventArgs e)
        {
            productosColecciones = new BindingList<productoAdquirido>();
            Session["productosColecciones"] = productosColecciones;
            nColeccionesActivas = 0;
            Session["nColeccionesActivas"] = nColeccionesActivas;
            foreach (Control control in ddlColecciones.Controls)
            {
                if (control is HtmlGenericControl listItem)
                {
                    foreach (Control innerControl in listItem.Controls)
                    {
                        if (innerControl is CheckBox checkbox)
                        {
                            checkbox.Checked = false;
                        }
                    }
                }
            }
            generarListaProductosAdquiridos();
            lbLimpiarFiltros.Visible = false;
        }

        protected void lbJugar_Click(object sender, EventArgs e)
        {
            productoAdquirido productoAdquirido = (productoAdquirido)Session["productoAdquiridoSeleccionado"];
            if (!productoAdquirido.actualizado)
            {
                productoAdquirido.actualizado = true;
                if (daoProductoAdquirido.actualizarProductoAdquirido(productoAdquirido) == 1)
                {
                    productoAdquirido productoAdquiridoEnList = productosAdquiridos.SingleOrDefault(x => x.idProductoAdquirido == productoAdquirido.idProductoAdquirido);
                    productoAdquiridoEnList.actualizado = true;
                    txtActualizadoPrograma.InnerHtml = "<strong>Actualizado: </strong>Sí";
                    txtEspacioPrograma.InnerHtml = "<strong>Espacio Ocupado: </strong>";
                    lbJugar.Text = "Agregar Uso";
                    if (productoAdquirido.producto.espacioDisco >= 1024)
                    {
                        double espacioGB = productoAdquirido.producto.espacioDisco/1024;
                        txtEspacioPrograma.InnerHtml += espacioGB.ToString("N2") + " GB";
                    }
                    else
                    {
                        txtEspacioPrograma.InnerHtml += productoAdquirido.producto.espacioDisco.ToString("N2") + " MB";
                    }
                    notificacion notificacionBiblioteca = new notificacion();
                    notificacionBiblioteca.tipoSpecified = true;
                    notificacionBiblioteca.usuario = (usuario)Session["usuario"];
                    notificacionBiblioteca.tipo = tipoNotificacion.BIBLIOTECA;
                    notificacionBiblioteca.mensaje = "Se actualizó " + productoAdquirido.producto.titulo;
                    int resultado = daoNotificacion.insertarNotificacion(notificacionBiblioteca);
                }
            }
            else
            {
                txtTiempoUsoModalHH.Text = "0";
                txtTiempoUsoModalMM.Text = "0";
                txtTiempoUsoModalSS.Text = "0";
                string script = "window.onload = function() { showModalForm('form-modal-agregarTiempoUso') };";
                ClientScript.RegisterStartupScript(GetType(), "", script, true);
            }

        }

        protected void btnAgregarModal_Click(object sender, EventArgs e)
        {
            int horas, minutos, segundos;

            horas = (txtTiempoUsoModalHH.Text!="")?Convert.ToInt32(txtTiempoUsoModalHH.Text):0;
            minutos = (txtTiempoUsoModalMM.Text!="")?Convert.ToInt32(txtTiempoUsoModalMM.Text):0;
            segundos = (txtTiempoUsoModalSS.Text!="")?Convert.ToInt32(txtTiempoUsoModalSS.Text):0;
            productoAdquirido producto = (productoAdquirido)Session["productoAdquiridoSeleccionado"];
            
            if(horas==0 && minutos==0 && segundos == 0)
            {
                return;
            }

            TimeSpan tiempoUsoAgregado = new TimeSpan(horas, minutos, segundos);

            producto.tiempoUsoSpecified = true;
            producto.fechaEjecutadoSpecified = true;
            producto.tiempoUso = producto.tiempoUso.Add(tiempoUsoAgregado);
            producto.fechaEjecutado = DateTime.Now;

            if (daoProductoAdquirido.actualizarProductoAdquirido(producto) != 0)
            {
                horas = Int32.Parse(producto.tiempoUso.ToString("HH"));
                minutos = Int32.Parse(producto.tiempoUso.ToString("mm"));
                txtTiempoUsoPrograma.InnerHtml = "<strong>Tiempo de uso: </strong>";
                if (horas > 0 || minutos > 0)
                {
                    txtFechaEjecucionPrograma.InnerHtml = "<strong>Última ejecución: </strong>" + producto.fechaEjecutado.ToString("dd/MM/yyyy");
                    txtTiempoUsoPrograma.InnerHtml += (horas == 0 ? "" : (horas.ToString() + (horas > 1 ? " horas " : " hora ")))
                        + (minutos == 0 ? "" : (minutos.ToString() + (minutos > 1 ? " minutos" : " minuto")));
                }
                
            }
        }

        protected void lbReporte_Click(object sender, EventArgs e)
        {
            daoReportes = new ReportesWSClient();
            usuario usuario = (usuario)Session["usuario"];
            tipoMoneda moneda;
            
            moneda = usuario.pais.moneda;
            byte[] reporte = daoReportes.generarReporteProductosAdquiridos(idBiblioteca, usuario.nombreCuenta, moneda.simbolo, moneda.cambioDeDolares);

            Response.Clear();

            Response.ContentType = "application/pdf";

            Response.AddHeader("Content-Disposition", "inline; filename=ReporteProductosAdquiridos.pdf");

            Response.BinaryWrite(reporte);

            Response.End();
        }
    }
}