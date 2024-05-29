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
            //idBiblioteca = 1;
            if (!IsPostBack)
            {
                if (Session["usuario"] != null)
                {
                    int uid = ((usuario)Session["usuario"]).UID;
                    idBiblioteca = daoBiblioteca.buscarBibliotecaPorUID(uid).idBiblioteca;
                    Session["idBiblioteca"] = idBiblioteca;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
                productoAdquirido[] productoArr = daoProductoAdquirido.listarProductosAdquiridosPorIdBiblioteca(idBiblioteca);
                if (productoArr != null)
                {
                    productosAdquiridos = new BindingList<productoAdquirido>(productoArr);
                    generarListaProductosAdquiridos();
                    Session["productosAdquiridos"] = productosAdquiridos;
                }
                else
                {
                    Session["productosAdquiridos"] = null;
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
            foreach (productoAdquirido productoAdquirido in productosAdquiridos)
            {
                if (nColeccionesActivas>0 && productosColecciones.FirstOrDefault(x => x.idProductoAdquirido == productoAdquirido.idProductoAdquirido) == null) continue;
                // Crear el elemento li
                HtmlGenericControl li = new HtmlGenericControl("li");
                li.Attributes["class"] = "list-group-item text-gray bg-transparent";
                li.Attributes["id"] = "liPrograma" + productoAdquirido.idProductoAdquirido;

                // Crear la imagen
                HtmlImage img = new HtmlImage
                {
                    Src = productoAdquirido.producto.logoUrl,
                    Height = 30
                };

                // Crear el LinkButton
                LinkButton linkButton = new LinkButton
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
                    checkbox.Text = coleccion.nombre;
                    checkbox.CheckedChanged += CheckBox_CheckedChanged;
                    checkbox.AutoPostBack = true;

                    LinkButton linkButton = new LinkButton
                    {
                        ID = "lbColeccion" + coleccion.idColeccion,
                        Text = "<i class='fa-solid fa-pen-to-square'></i>",
                        CssClass = "text-decoration-none text-dark justify-content-end",
                        CommandArgument = coleccion.idColeccion.ToString()
                    };
                    linkButton.Click += lbColeccion_Click;

                    // Agregamos el enlace al elemento de lista
                    listItem.Controls.Add(checkbox);
                    listItem.Controls.Add(new Literal { Text = " " });
                    listItem.Controls.Add(linkButton);

                    ddlColecciones.Controls.Add(listItem);
                }
            }
            HtmlGenericControl newItem = new HtmlGenericControl("li");
            HtmlAnchor newCollectionLink = new HtmlAnchor();
            newCollectionLink.Attributes.Add("class", "dropdown-item");
            newCollectionLink.HRef = "GestionarColeccion.aspx";
            HtmlGenericControl newCollectionIcon = new HtmlGenericControl("i");
            newCollectionIcon.Attributes.Add("class", "fa-solid fa-plus me-2");
            newCollectionLink.Controls.Add(newCollectionIcon);
            newCollectionLink.InnerHtml = "<i class='fa-solid fa-plus'></i>Nueva Colección";
            newItem.Controls.Add(newCollectionLink);
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
                    foreach(productoAdquirido producto in blColeccionProductos)
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
                (productoAdquirido.fechaEjecutado.ToString("dd/MM/yyyy")=="01/01/0001" ? "Aún no ejecutado" : productoAdquirido.fechaEjecutado.ToString("dd/MM/yyyy"));
            int horas = Int32.Parse(productoAdquirido.tiempoUso.ToString("HH"));
            int minutos = Int32.Parse(productoAdquirido.tiempoUso.ToString("mm"));
            txtTiempoUsoPrograma.InnerHtml = "<strong>Tiempo de uso: </strong>";
            if (horas > 0 || minutos > 0)
            {
                txtTiempoUsoPrograma.InnerHtml += horas.ToString() + (horas==0 ? "" : (horas > 1 ? " horas " : " hora ")) +
                    minutos.ToString() + (minutos==0 ? "" : (minutos > 1 ? " minutos" : " minuto"));
            }
            else
            {
                txtTiempoUsoPrograma.InnerHtml += "Aún no usado"; 
            }

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

        protected void RadioButton_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton radioButton = (RadioButton)sender;
            List<productoAdquirido> productosAdquiridosList = productosAdquiridos.ToList();
            if (radioButton.ID == "rbNombre")
            {
                productosAdquiridosList.Sort((p1, p2) => string.Compare(p1.producto.titulo, p2.producto.titulo));
            } 
            else if (radioButton.ID == "rbTiempo")
            {
                productosAdquiridosList.Sort((p1, p2) =>  -1*(p1.tiempoUso.ToString("HH:mm:ss").CompareTo(p2.tiempoUso.ToString("HH:mm:ss"))));
            }
            else if(radioButton.ID == "rbTam")
            {
                productosAdquiridosList.Sort((p1, p2) => p1.producto.espacioDisco.CompareTo(p2.producto.espacioDisco));
            }
            else if(radioButton.ID == "rbFechaPub")
            {
                productosAdquiridosList.Sort((p1, p2) => p1.producto.fechaPublicacion.CompareTo(p2.producto.fechaPublicacion));
            }
            else if(radioButton.ID == "rbPrecio")
            {
                productosAdquiridosList.Sort((p1, p2) => p1.producto.precio.CompareTo(p2.producto.precio));
            } 
            productosAdquiridos = new BindingList<productoAdquirido>(productosAdquiridosList);
            Session["productosAdquiridos"] = productosAdquiridos;
            generarListaProductosAdquiridos();
        }
        
    }
}