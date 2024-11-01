﻿using SteamWA.SteamServiceWS;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing.Printing;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Tienda : System.Web.UI.Page
    {
        private tipoMoneda moneda;
        private SteamWA.SteamServiceWS.ProductoWSClient daoProducto;
        private SteamServiceWS.PaisWSClient daoPais;
        private BindingList<SteamWA.SteamServiceWS.producto> listaProductos;
        private SteamWA.SteamServiceWS.EtiquetaWSClient daoEtiqueta;
        private SteamWA.SteamServiceWS.BibliotecaWSClient daoBiblioteca;
        private SteamWA.SteamServiceWS.ProductoAdquiridoWSClient daoProductoAdquirido;
        private int idBiblioteca;
        private BindingList<productoAdquirido> listaProductoAdq;
        protected void Page_Load(object sender, EventArgs e)
        {

            Steam master = (Steam)this.Master;
            master.ItemTienda.Attributes["class"] = "active";
            int uid;
            if (Session["usuario"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            uid = ((usuario)Session["usuario"]).UID;
            daoBiblioteca = new SteamServiceWS.BibliotecaWSClient();
            daoProductoAdquirido = new SteamServiceWS.ProductoAdquiridoWSClient();
            if (Session["idBiblioteca"] == null)
            {
                idBiblioteca = daoBiblioteca.buscarBibliotecaPorUID(uid).idBiblioteca;
                Session["idBiblioteca"] = idBiblioteca;
            }
            else
            {
                idBiblioteca = (int)Session["idBiblioteca"];
            }
            if (!IsPostBack)
            {
                productoAdquirido[] arrProdAdq = daoProductoAdquirido.listarProductosAdquiridosPorIdBiblioteca(idBiblioteca);
                if (arrProdAdq == null)
                {
                    listaProductoAdq = null;
                }
                else
                {
                    listaProductoAdq = new BindingList<productoAdquirido>(arrProdAdq);

                }
                Session["productosAdquiridos"] = listaProductoAdq;
            }
            else
            {
                listaProductoAdq = (BindingList<productoAdquirido>)Session["productosAdquiridos"];
                Session["busqueda"] = search_autocomplete.Text;
            }

            //Moneda y tipo de cambio
            if (Session["moneda"] != null) moneda = (tipoMoneda)Session["moneda"];
            else
            {
                daoPais = new PaisWSClient();
                pais pais = daoPais.buscarPais(((usuario)Session["usuario"]).pais.idPais);
                moneda = pais.moneda;
                Session["moneda"] = moneda;
            }
            monedaSimboloTipoCambio.Value = (moneda.simbolo).ToString() + "?" + (moneda.cambioDeDolares).ToString();
            daoProducto = new SteamServiceWS.ProductoWSClient();

            if (!IsPostBack)
            {
                listaProductos = new BindingList<SteamWA.SteamServiceWS.producto>(daoProducto.listarProductos());
                List<string> nombresProductos = listaProductos.Select(p => p.titulo).ToList();

                var listaNombresProductosJson = new JavaScriptSerializer().Serialize(nombresProductos.ToList());

                listaNombresProductos.Value = listaNombresProductosJson;
                Session["ListaProductos"] = listaProductos;
            }
            else
            {
                listaProductos = (BindingList<producto>)Session["ListaProductos"];
            }
            
            if (Session["ElementosCarrito"] == null)
            {
                BindingList<producto> listaCarrito = new BindingList<producto>();
                Session["ElementosCarrito"] = listaCarrito;
            }


            //Carousel Destacados:
            if (!IsPostBack)
            {
                int[] idDestacados = daoProducto.listarIdProductosDestacados();
                listaProductos = new BindingList<SteamWA.SteamServiceWS.producto>(daoProducto.listarProductos());
                if (listaProductos.FirstOrDefault(x => x.idProducto == idDestacados[0]) != null) imgDest1.ImageUrl = listaProductos[idDestacados[0] - 1].portadaUrl;
                if (listaProductos.FirstOrDefault(x => x.idProducto == idDestacados[1]) != null) imgDest2.ImageUrl = listaProductos[idDestacados[1] - 1].portadaUrl;
                if (listaProductos.FirstOrDefault(x => x.idProducto == idDestacados[2]) != null) imgDest3.ImageUrl = listaProductos[idDestacados[2] - 1].portadaUrl;
            }
            //Filtro de barrra de precios
            BindingList<producto> listaTemp =
            new BindingList<SteamWA.SteamServiceWS.producto>();
            if (Request.Form[barRangoPrecio.UniqueID] != null && Request.Form[barRangoPrecio.UniqueID]!="5")
            {
                //limpiarCamposFiltros(4);
                string valor = Request.Form[barRangoPrecio.UniqueID];
                foreach (producto p in listaProductos)
                {
                    if ((p.precio * moneda.cambioDeDolares) <= (double.Parse(valor) * 7 * moneda.cambioDeDolares))
                    {
                        listaTemp.Add(p);
                    }
                }
                labelito.InnerText = moneda.simbolo + " " + ((double.Parse(valor) * 7) * moneda.cambioDeDolares).ToString();
                if (double.Parse(valor) == 5)
                {
                    labelito.InnerText = "Todos";
                }
                else if (double.Parse(valor) == 0)
                {
                    labelito.InnerText = "Gratis";
                }
                listaProductos = listaTemp;
                if((double.Parse(valor)) == 5){
                    Session["listaProdRangoPrecio"] = null;
                }
                else
                {
                    Session["listaProdRangoPrecio"] = listaTemp;
                }
                
            }
            else
            {
                barRangoPrecio.Value = "5";
                labelito.InnerText = "Todos";
            }
            //Mostrar productos incial;
            mostrarListaProductos(listaProductos);

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "EnviarInformacion", "enviarInformacion('" + json + "');", true
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            daoEtiqueta = new SteamWA.SteamServiceWS.EtiquetaWSClient();
            BindingList<etiqueta> etiquetas = new BindingList<etiqueta>();
            try
            {
            etiquetas = new BindingList<etiqueta>(daoEtiqueta.listarEtiquetas());

            }
            catch
            {
                etiquetas = new BindingList<etiqueta>();
                etiquetas = new BindingList<etiqueta>((daoEtiqueta.listarEtiquetas()).ToList());
            }
            BindingList<CheckBox> CheckBoxFiltroEtiqueta = new BindingList<CheckBox>();

            foreach (etiqueta et in etiquetas)
            {
                CheckBox chk = new CheckBox();
                chk.ID = "chk" + (et.idEtiqueta).ToString();
                HtmlGenericControl liEti = new HtmlGenericControl("li");
                HtmlGenericControl contr = new HtmlGenericControl("div");
                contr.Attributes["class"] = "d-flex ps-2";
                chk.CheckedChanged += Chk_CheckedChanged;
                chk.AutoPostBack = true;
                liEti.Attributes["class"] = "ps-2 text-light";
                liEti.InnerText = et.nombre;

                contr.Controls.Add(chk);
                contr.Controls.Add(liEti);
                ddlEtiquetas.Controls.Add(contr);
                CheckBoxFiltroEtiqueta.Add(chk);
            }
            Session["CheckBoxFiltroEtiqueta"] = CheckBoxFiltroEtiqueta;
            BindingList<string> tipos = new BindingList<string>();
            tipos.Add("Todos");
            tipos.Add("Software");
            tipos.Add("Banda Sonora");
            tipos.Add("Juego");
            BindingList<RadioButton> CheckBoxFiltroTipo = new BindingList<RadioButton>();

            for (int i = 0; i < 4; i++)
            {
                RadioButton chk2 = new RadioButton();
                chk2.GroupName = "ListaRadioTipo";
                chk2.ID = "chkTipo" + (i).ToString();
                if (i == 0)
                {
                    chk2.Checked = true;
                }
                HtmlGenericControl liEti2 = new HtmlGenericControl("li");
                HtmlGenericControl contr2 = new HtmlGenericControl("div");
                contr2.Attributes["class"] = "d-flex ps-2";
                chk2.CheckedChanged += Chk2_CheckedChanged;
                chk2.AutoPostBack = true;
                liEti2.Attributes["class"] = "ps-2 text-light";
                liEti2.InnerText = tipos[i];

                contr2.Controls.Add(chk2);
                contr2.Controls.Add(liEti2);
                ddlTipos.Controls.Add(contr2);
                CheckBoxFiltroTipo.Add(chk2);
                
            }
            Session["CheckBoxFiltroTipo"] = CheckBoxFiltroTipo;


        }

        //Filtro Tipo
        private void Chk2_CheckedChanged(object sender, EventArgs e)
        {
            limpiarCamposFiltros(1);
            BindingList<RadioButton> CheckBoxFiltroTipo = (BindingList<RadioButton>)Session["CheckBoxFiltroTipo"];
            CheckBox checkBox = (CheckBox)sender;
            string idString = (checkBox.ID);
            char idChar = idString[idString.Length - 1];
            int id = Int32.Parse(idChar.ToString());
            listaProductos =
             new BindingList<producto>(daoProducto.listarProductos());
            BindingList<producto> listaProdsTipo = new BindingList<producto>();
            JuegoWSClient daoTempJuego = new JuegoWSClient();
            BandaSonoraWSClient daoTempBs = new BandaSonoraWSClient();
            SoftwareWSClient daoTempSoftware = new SoftwareWSClient();
            producto[] arrProd = null;
            if (id == 0)
            {
                arrProd = daoProducto.listarProductos();
            }
            else if (id == 1)
            {
                arrProd =  daoTempSoftware.listarSoftwares();
            }
            else if (id == 2)
            {
                arrProd = daoTempBs.listarBandaSonoras();
            }
            else if (id == 3)
            {
                arrProd = daoTempJuego.listarJuegos();
            }
            
            if (arrProd != null)
            {
                listaProdsTipo = new BindingList<producto>(arrProd);
                if (id != 0) Session["listaProdsTipo"] = listaProdsTipo;
                else Session["listaProdsTipo"] = null;
            }
            else
            {
                listaProdsTipo = null;
            }
            //Session["listaProdEt"] = listaProdsTipo;
            /*foreach(CheckBox ch in CheckBoxFiltroTipo)
            {
                ch.Checked= false;
            }
            checkBox.Checked = true;
            */
            mostrarListaProductos(listaProdsTipo);

        }

        //Filtro Etiqueta
        private void Chk_CheckedChanged(object sender, EventArgs e)
        {
            limpiarCamposFiltros(2);
            CheckBox checkBox = (CheckBox)sender;
            etiqueta et = new etiqueta();
            string idString = (checkBox.ID);
            char idChar = idString[idString.Length - 1];
            int id = Int32.Parse(idChar.ToString());
            et.idEtiqueta = id;
            BindingList<producto> listaProdEtG = (BindingList<producto>)Session["listaProdEt"];
            Dictionary<int, int> DicProdEtG = (Dictionary<int, int>)Session["DicProdEtDic"];
            
            BindingList<CheckBox> CheckBoxFiltroEtiqueta = (BindingList<CheckBox>)Session["CheckBoxFiltroEtiqueta"];
            //Para mostrar todos los productos en el caso de que no hayan ninguna etiqueta seleccionada
            if (!(checkBox.Checked))
            {
                int val = 0;
                foreach(CheckBox chx in CheckBoxFiltroEtiqueta)
                {
                    if(chx.Checked == true)
                    {
                        val = 1;
                    }

                }
                if(val == 0)
                {
                    Session["listaProdEt"] = null;
                    Session["DicProdEtDic"] = null;
                    mostrarListaProductos((BindingList<producto>)Session["ListaProductos"]);
                    return;
                }
                
            }
            try
            {
                listaProductos =
             new BindingList<producto>(daoProducto.listarProductosPorEtiqueta(et));

                if (checkBox.Checked)
                {
                    if (listaProdEtG == null)
                    {
                        listaProdEtG = new BindingList<producto>();
                    }
                    if (DicProdEtG == null)
                    {
                        DicProdEtG = new Dictionary<int, int>();
                    }
                    foreach (producto pr in listaProductos)
                    {
                        producto prodEncontrado = listaProdEtG.FirstOrDefault(p => p.idProducto == pr.idProducto);
                        if (prodEncontrado != null)
                        {
                            DicProdEtG[pr.idProducto] += 1;
                        }
                        else
                        {
                            if (!DicProdEtG.ContainsKey(pr.idProducto))
                            {
                                DicProdEtG.Add(pr.idProducto, 0);
                            }
                            DicProdEtG[pr.idProducto] += 1;
                            listaProdEtG.Add(pr);
                        }
                    }
                    Session["listaProdEt"] = listaProdEtG;
                    Session["DicProdEtDic"] = DicProdEtG;
                    mostrarListaProductos(listaProdEtG);
                }
                else
                {
                    if (listaProdEtG != null)
                    {

                        foreach (producto pr in listaProductos)
                        {
                            producto prodEncontrado = listaProdEtG.FirstOrDefault(p => p.idProducto == pr.idProducto);
                            if (prodEncontrado != null)
                            {
                                if (DicProdEtG[prodEncontrado.idProducto] == 1)
                                {
                                    DicProdEtG.Remove(prodEncontrado.idProducto);
                                    listaProdEtG.Remove(prodEncontrado);
                                }
                                else
                                {
                                    DicProdEtG[prodEncontrado.idProducto] -= 1;
                                }
                            }
                            else
                            {

                            }

                        }

                    }
                    else
                    {
                        listaProdEtG = new BindingList<producto>();
                        DicProdEtG = new Dictionary<int, int>();
                    }
                    Session["listaProdEt"] = listaProdEtG;
                    Session["DicProdEtDic"] = DicProdEtG;
                    mostrarListaProductos(listaProdEtG);
                }
            }
            catch
            {
                if (listaProdEtG == null)
                {
                    listaProdEtG = new BindingList<producto>();
                }
                mostrarListaProductos(listaProdEtG);
            }
        }

        protected void btnCarrito1_Click(object sender, CommandEventArgs e)
        {
            string argumentos = (e.CommandArgument.ToString());
            string[] listarArgs = argumentos.Split('¿');
            int id = Int32.Parse(listarArgs[0]);
            string url = (listarArgs[1]);
            string titulo = (listarArgs[2]);
            modalImagen.ImageUrl = url;
            labelModal.InnerText = titulo;
            BindingList<producto> listaProd = new BindingList<producto>((BindingList<producto>)Session["ListaProductos"]);
            if (Session["ElementosCarrito"] != null)
            {
                BindingList<producto> listaCarrito = (BindingList<producto>)Session["ElementosCarrito"];
                producto prodEncontrado = listaCarrito.FirstOrDefault(p => p.idProducto == id);
                if (prodEncontrado == null)
                {
                    producto prodCarrito = listaProd.FirstOrDefault(p => p.idProducto == id);
                    listaCarrito.Add(prodCarrito);
                    Session["ElementosCarrito"] = listaCarrito;

                }
            }
            limpiarCamposFiltros(0);
            string script = "window.onload = function() { showModalForm('form-modal-añadido-carrito') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
            mostrarListaProductos(listaProd);

        }

        protected void btnCarro_Click(object sender, EventArgs e)
        {
            Response.Redirect("Carrito.aspx");
        }

        protected void search_Click(object sender, EventArgs e)
        {

            BindingList<SteamWA.SteamServiceWS.producto> lista =
              new BindingList<SteamWA.SteamServiceWS.producto>();
            SteamWA.SteamServiceWS.etiqueta etiqueta = new SteamWA.SteamServiceWS.etiqueta();
            etiqueta.nombre = "accion";
            if (listaProductos == null)
            {
                listaProductos =
           new BindingList<SteamWA.SteamServiceWS.producto>(daoProducto.listarProductos());
            }
            try
            {
                lista =
               new BindingList<SteamWA.SteamServiceWS.producto>(daoProducto.listarProductosPorTituloDesarrollador(search_autocomplete.Text));
               
            }
            catch
            {
                lista = null;
            }
            limpiarCamposFiltros(0);
            search_autocomplete.Text = (String)Session["busqueda"];
            Session["listaProdBuscarTituloDesarrollador"] = lista;
            mostrarListaProductos(lista);

           
        }

        public void mostrarListaProductos(BindingList<SteamWA.SteamServiceWS.producto> lProds)
        {
            if (Session["ElementosCarrito"] != null)
            {
                BindingList<producto> listaCarrito = (BindingList<producto>)Session["ElementosCarrito"];
            }
            placeholderProductos.Controls.Clear();
            if (lProds != null)
            {
                if(rdbPrecio.Checked) lProds = new BindingList<producto>(lProds.OrderBy(producto => producto.precio).ToList());
                if(rdbNombre.Checked) lProds = new BindingList<producto>(lProds.OrderBy(producto => producto.titulo).ToList());
                HtmlGenericControl divHtmlContainer = new HtmlGenericControl("div");
                
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
                    divHtmlCardPrice.InnerText = "Precio: "+moneda.simbolo +" "+ (prod.precio * moneda.cambioDeDolares).ToString("N2");

                    LinkButton buttonCarrito = new LinkButton();
                    buttonCarrito.CssClass = "btn btn-primary";
                    buttonCarrito.ID = "btnCarritos" + prod.idProducto;
                 
                    buttonCarrito.CommandArgument = (prod.idProducto).ToString() + "¿" + (prod.portadaUrl).ToString() + "¿" +
                        (prod.titulo).ToString();


                    buttonCarrito.Command += btnCarrito1_Click;
                    buttonCarrito.Text = "Añadir al carrito";

                     if (Session["ElementosCarrito"] != null)
                         {
                BindingList<producto> listaCarrito = (BindingList<producto>)Session["ElementosCarrito"];
                        producto prodCarrito = listaCarrito.FirstOrDefault(p => p.idProducto == prod.idProducto);
                      
                        
                        if (prodCarrito !=null){
                            buttonCarrito.Enabled = false;
                            buttonCarrito.BackColor = System.Drawing.Color.Gray;
                            buttonCarrito.BorderColor = System.Drawing.Color.Transparent;
                            buttonCarrito.Text = "Ya añadido";
                        }

                    }
                    if (listaProductoAdq != null)
                    {
                        foreach (productoAdquirido p in listaProductoAdq)
                        {
                            if ((p.producto).idProducto == prod.idProducto)
                            {
                                buttonCarrito.Enabled = false;
                                buttonCarrito.BackColor = System.Drawing.Color.Green;
                                buttonCarrito.BorderColor = System.Drawing.Color.Transparent;
                                buttonCarrito.Text = "Adquirido";
                            }
                        }
                    }
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

        protected void btnLimpFiltro_Click(object sender, EventArgs e)
        {
            limpiarCamposFiltros(0);
            rdbNombre.Checked = false;
            rdbPrecio.Checked = false;
            mostrarListaProductos( new BindingList<producto>(daoProducto.listarProductos()));
        }
        protected void limpiarCamposFiltros(int opc)
        {
            BindingList<RadioButton> CheckBoxFiltroTipo = (BindingList<RadioButton>)Session["CheckBoxFiltroTipo"];
            BindingList<CheckBox> CheckBoxFiltroEtiqueta = (BindingList<CheckBox>)Session["CheckBoxFiltroEtiqueta"];
            if (opc != 1)
            {
                foreach (RadioButton r in CheckBoxFiltroTipo)
                {
                    string idString = (r.ID);
                    char idChar = idString[idString.Length - 1];
                    int id = Int32.Parse(idChar.ToString());
                    r.Checked = false;
                    if (id == 0)
                    {
                        r.Checked = true;
                    }
                }
                Session["listaProdsTipo"] = null;
            }
            if (opc != 2)
            {
                foreach (CheckBox c in CheckBoxFiltroEtiqueta)
                {
                    c.Checked = false;
                }
                Session["listaProdEt"] = null;
                Session["DicProdEtDic"] = null;
            }
            if (opc != 4)
            {
                Session["listaProdRangoPrecio"] = null;
                barRangoPrecio.Value = "5";
                labelito.InnerText = "Todos";
            }
            Session["listaProdBuscarTituloDesarrollador"] = null;
            search_autocomplete.Text= string.Empty;
           
        }

        protected void rdbPrecio_CheckedChanged(object sender, EventArgs e)
        {
            BindingList<producto> listaMostrar = listaProductos;
            //limpiarCamposFiltros(3);
            //listaProductos = new BindingList<producto>(listaProductos.OrderBy(producto => producto.precio).ToList());
            //Session["ListaProductos"] = listaProductos;
            if (Session["listaProdRangoPrecio"] != null)
            {
                listaMostrar = (BindingList<producto>)Session["listaProdRangoPrecio"];
            }
            else if (Session["listaProdBuscarTituloDesarrollador"] != null)
            {
                listaMostrar = (BindingList<producto>)Session["listaProdBuscarTituloDesarrollador"];
            }
            else
            {
                if (Session["listaProdEt"] != null) listaMostrar = (BindingList<producto>)Session["listaProdEt"];
                else if (Session["listaProdsTipo"] != null) listaMostrar = (BindingList<producto>)Session["listaProdsTipo"];
            }
            mostrarListaProductos(listaMostrar);
        }

        protected void rdbNombre_CheckedChanged(object sender, EventArgs e)
        {
            BindingList<producto> listaMostrar = listaProductos;
            
            if (Session["listaProdRangoPrecio"] != null)
            {
                listaMostrar = (BindingList<producto>)Session["listaProdRangoPrecio"];
            }
            else if (Session["listaProdBuscarTituloDesarrollador"] != null)
            {
                listaMostrar = (BindingList<producto>)Session["listaProdBuscarTituloDesarrollador"];
            }
            else{
                if (Session["listaProdEt"] != null) listaMostrar = (BindingList<producto>)Session["listaProdEt"];
                else if (Session["listaProdsTipo"] != null) listaMostrar = (BindingList<producto>)Session["listaProdsTipo"];
            }
            mostrarListaProductos(listaMostrar);
        }

        protected void rangeInput_ServerChange(object sender, EventArgs e)
        {
            limpiarCamposFiltros(4);
        }

    }
}