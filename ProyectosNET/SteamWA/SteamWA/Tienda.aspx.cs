﻿using SteamWA.SteamServiceWS;
using System;
using System.Collections;
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
        private SteamWA.SteamServiceWS.EtiquetaWSClient daoEtiqueta;
        protected void Page_Load(object sender, EventArgs e)
        {
            Steam master = (Steam)this.Master;
            master.ItemTienda.Attributes["class"] = "active";

            daoProducto = new SteamServiceWS.ProductoWSClient();

            if (!IsPostBack)
            {
                Session["listaProdEt"] = null;
                Session["DicProdEtDic"] = null;
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

        protected void Page_Init(object sender, EventArgs e)
        {
            daoEtiqueta = new SteamWA.SteamServiceWS.EtiquetaWSClient();
            BindingList<etiqueta> etiquetas = new BindingList<etiqueta>(daoEtiqueta.listarEtiquetas());

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
            }

            BindingList<string> tipos = new BindingList<string>();
            tipos.Add("Software");
            tipos.Add("Banda Sonora");
            tipos.Add("Juego");
            for (int i = 0; i < 3; i++)
            {
                CheckBox chk2 = new CheckBox();
                chk2.ID = "chkTipo" + (i + 1).ToString();
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
            }


        }

        private void Chk2_CheckedChanged(object sender, EventArgs e)
        {
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
            foreach (producto pr in listaProductos)
            {
                if (id == 1)
                {
                    software soft = daoTempSoftware.buscarSoftware(pr.idProducto);
                    if (soft.titulo != null)
                    {
                        listaProdsTipo.Add(pr);
                    }
                }
                else if (id == 2)
                {
                    bandaSonora banda = daoTempBs.buscarBandaSonora(pr.idProducto);
                    if (banda.titulo != null)
                    {

                        listaProdsTipo.Add(pr);

                    }
                }
                else if (id == 3)
                {
                    BindingList<juego> juegos = new BindingList<juego>(daoTempJuego.listarJuegos());
                    foreach (juego jue in juegos)
                    {
                        if (jue.idProducto == pr.idProducto)
                        {

                            listaProdsTipo.Add(pr);
                            break;
                        }
                    }

                }

            }
            checkBox.Checked = false;

            mostrarListaProductos(listaProdsTipo);

        }

        private void Chk_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox checkBox = (CheckBox)sender;
            etiqueta et = new etiqueta();
            string idString = (checkBox.ID);
            char idChar = idString[idString.Length - 1];
            int id = Int32.Parse(idChar.ToString());
            et.idEtiqueta = id;
            BindingList<producto> listaProdEtG = (BindingList<producto>)Session["listaProdEt"];
            Dictionary<int, int> DicProdEtG = (Dictionary<int, int>)Session["DicProdEtDic"];

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
                mostrarListaProductos(listaProdEtG);
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


            Session["ListaProductos"] = listaProductos;
            mostrarListaProductos(listaProductos);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "EnviarInformacion", "enviarInformacion('" + json + "');", true);
        }

        public void mostrarListaProductos(BindingList<SteamWA.SteamServiceWS.producto> lProds)
        {
            if (lProds != null)
            {
                HtmlGenericControl divHtmlContainer = new HtmlGenericControl("div");
                divHtmlContainer.Attributes["class"] = "row mt-3 pb-4";
                divHtmlContainer.Attributes["id"] = "contenedorProductos";

                foreach (producto prod in lProds)
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

                    HtmlGenericControl divHtmlCardPrice = new HtmlGenericControl("p");
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
}