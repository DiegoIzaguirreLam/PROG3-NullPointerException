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
    public partial class GestionarLogros : System.Web.UI.Page
    {
        private ProductoAdquiridoWSClient daoProductoAdquirido;
        private LogroWSClient daoLogro;
        private LogroDesbloqueadoWSClient daoLogroDesbloqueado;
        private productoAdquirido productoAdquirido;
        private BindingList<logro> logros;
        private BindingList<logro> logrosNoDesbloqueados;
        private BindingList<logroDesbloqueado> logrosDesbloqueados;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["productoAdquiridoSeleccionado"] == null)
            {
                Response.Redirect("Biblioteca.aspx");
            }
            else
            {
                productoAdquirido = (productoAdquirido)Session["productoAdquiridoSeleccionado"];
                daoProductoAdquirido = new ProductoAdquiridoWSClient();
                daoLogro = new LogroWSClient();
                daoLogroDesbloqueado = new LogroDesbloqueadoWSClient();
                producto producto = productoAdquirido.producto;

                hGestionarLogros.InnerHtml = "Gestionar Logros: " + producto.titulo;
                logro[] logrosArr = daoLogro.listarLogrosPorIdJuego(producto.idProducto);
                if (logrosArr != null)
                {
                    logros = new BindingList<logro>(logrosArr);
                    logrosNoDesbloqueados = new BindingList<logro>();
                }
                else
                {
                    logros = null;
                    logrosNoDesbloqueados = null;
                }

                if (logros != null)
                {
                    logroDesbloqueado[] logrosDesbloqueadosArr = daoLogroDesbloqueado.listarLogrosDesbloqueadosProductoAdquirido(productoAdquirido.idProductoAdquirido);
                    if (logrosDesbloqueadosArr != null)
                    {
                        logrosDesbloqueados = new BindingList<logroDesbloqueado>(logrosDesbloqueadosArr);
                    }
                    else
                    {
                        logrosDesbloqueados = null;
                    }
                    foreach (logro logro in logros)
                    {
                        if (logrosDesbloqueados != null && logrosDesbloqueados.FirstOrDefault(x => x.logro.idLogro == logro.idLogro) != null) continue;
                        logrosNoDesbloqueados.Add(logro);
                    }

                    if (logrosDesbloqueados != null)
                    {
                        gvLogrosDesbloqueados.DataSource = logrosDesbloqueados;
                        gvLogrosDesbloqueados.DataBind();
                        pLogrosDesbloqueados.Visible = false;
                        gvLogrosDesbloqueados.Visible = true;
                    }
                    else
                    {
                        pLogrosDesbloqueados.InnerText = "Aquí se mostrarán sus logros desbloqueados";
                        pLogrosDesbloqueados.Visible = true;
                        gvLogrosDesbloqueados.Visible = false;
                    }

                    if (logrosNoDesbloqueados.Count != 0)
                    {
                        gvLogrosPorDesbloquear.DataSource = logrosNoDesbloqueados;
                        gvLogrosPorDesbloquear.DataBind();
                        pLogrosPorDesbloquear.Visible = false;
                        gvLogrosPorDesbloquear.Visible = true;
                    }
                    else
                    {
                        pLogrosPorDesbloquear.InnerText = "Felicidades, ha desbloqueado todos los logros de este juego";
                        pLogrosPorDesbloquear.Visible = true;
                        gvLogrosPorDesbloquear.Visible = false;
                    }
                }
                else
                {
                    pLogros.InnerText = "Aún no hay logros disponibles para este juego";
                    gvLogrosDesbloqueados.Visible = false;
                    gvLogrosPorDesbloquear.Visible = false;
                }
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            
        }

        protected void gvLogrosDesbloqueados_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                logroDesbloqueado logroDesbloqueado = (logroDesbloqueado)e.Row.DataItem;
                e.Row.Cells[0].Text = logroDesbloqueado.logro.nombre.ToString();
                e.Row.Cells[1].Text = logroDesbloqueado.logro.descripcion.ToString();
                e.Row.Cells[2].Text = logroDesbloqueado.fechaDesbloqueo.ToString("dd/MM/yyyy");
            }
        }

        protected void gvLogrosPorDesbloquear_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                logro logro = (logro)e.Row.DataItem;
                e.Row.Cells[0].Text = logro.nombre.ToString();
                e.Row.Cells[1].Text = logro.descripcion.ToString();
            }
        }

        protected void btnEliminarLogroDesbloqueado_Click(object sender, EventArgs e)
        {
            Session["idLogroDesbloqueado"] = Int32.Parse(((LinkButton)sender).CommandArgument);
            string script = "window.onload = function() { showModalForm('form-modal-EliminarLogroDesbloqueado') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnDesbloquearLogro_Click(object sender, EventArgs e)
        {
            Session["idLogro"] = Int32.Parse(((LinkButton)sender).CommandArgument);
            string script = "window.onload = function() { showModalForm('form-modal-DesbloquearLogro') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }


        protected void btnEliminarLogroDesbloqueadoConfirmacionModal_OnClick(object sender, EventArgs e)
        {
            int idLogroDesbloqueado = (int)Session["idLogroDesbloqueado"];
            daoLogroDesbloqueado.eliminarLogroDesbloqueado(idLogroDesbloqueado);
            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }

        protected void btnDesbloquearLogroConfirmacionModal_OnClick(object sender, EventArgs e)
        {
            int idLogro = (int)Session["idLogro"];
            logroDesbloqueado logroDesbloqueado = new logroDesbloqueado();
            logroDesbloqueado.logro = logros.SingleOrDefault(x => x.idLogro == idLogro);
            logroDesbloqueado.juego = productoAdquirido;
            daoLogroDesbloqueado.insertarLogroDesbloqueado(logroDesbloqueado);
            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }


        protected void gvLogrosDesbloqueados_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLogrosDesbloqueados.PageIndex = e.NewPageIndex;
            gvLogrosDesbloqueados.DataSource = logrosDesbloqueados;
            gvLogrosDesbloqueados.DataBind();
        }

        protected void gvLogrosPorDesbloquear_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLogrosPorDesbloquear.PageIndex = e.NewPageIndex;
            gvLogrosPorDesbloquear.DataSource = logrosNoDesbloqueados;
            gvLogrosPorDesbloquear.DataBind();
        }
    }
}