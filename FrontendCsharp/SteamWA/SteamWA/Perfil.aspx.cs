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
    public partial class Perfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) lbLogros_Click(null, null);

            cargarDatosUsuario();
            cargarLogrosUsuario();
        }

        protected void cargarDatosUsuario()
        {
            usuario usuario = (usuario)Session["usuario"];

            lblNombreCuenta.InnerText = usuario.nombreCuenta;
            lblUID.Text = usuario.UID.ToString();
            lblCorreo.Text = usuario.correo;
            lblTelefono.Text = usuario.telefono;
            lblFechaNacimiento.Text = usuario.fechaNacimiento.ToString("dd/MM/yyyy");

            if (usuario.verificado)
            {
                lblVerificado.InnerText = "Verificado por Steam";
                lblVerificado.Style["color"] = "green";
                iconVerificado.Style["color"] = "green";
            }
        }

        protected void cargarLogrosUsuario()
        {
            int idUsuario = ((usuario)Session["usuario"]).UID;

            LogroDesbloqueadoWSClient daoLogro = new LogroDesbloqueadoWSClient();
            logroDesbloqueado[] listaLogros = daoLogro.listarLogrosPorUsuario(idUsuario);

            if (listaLogros == null)
            {
                lblNoLogros.Visible = true;
                return;
            }

            BindingList<logroDesbloqueado> logros = new BindingList<logroDesbloqueado>(listaLogros);
            gvLogros.DataSource = logros;
            gvLogros.DataBind();
        }

        protected void lbLogros_Click(object sender, EventArgs e)
        {
            lbLogros.CssClass = "nav-link bg-navy text-light bg-gradient";
            lbActividad.CssClass = "nav-link bg-navy text-light";
            lbInfoPersonal.CssClass = "nav-link bg-navy text-light";
            MultiView1.SetActiveView(ViewLogrosObtenidos);
        }

        protected void lbActividad_Click(object sender, EventArgs e)
        {
            lbLogros.CssClass = "nav-link bg-navy text-light";
            lbActividad.CssClass = "nav-link bg-navy text-light bg-gradient";
            lbInfoPersonal.CssClass = "nav-link bg-navy text-light";
            MultiView1.SetActiveView(ViewActividadReciente);
        }

        protected void lbInfoPersonal_Click(object sender, EventArgs e)
        {
            lbLogros.CssClass = "nav-link bg-navy text-light";
            lbActividad.CssClass = "nav-link bg-navy text-light";
            lbInfoPersonal.CssClass = "nav-link bg-navy text-light bg-gradient";
            MultiView1.SetActiveView(ViewInfoPersonal);
        }

        protected void gvLogros_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLogros.PageIndex = e.NewPageIndex;
            gvLogros.DataBind();
        }

        protected void gvLogros_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                logroDesbloqueado logro = (logroDesbloqueado)e.Row.DataItem;
                HtmlImage img = new HtmlImage();
                img.Src = logro.juego.producto.logoUrl;
                img.Height = 50;
                img.Width = 50;
                e.Row.Cells[0].Controls.Add(img);
                e.Row.Cells[1].Text = logro.juego.producto.titulo;
                e.Row.Cells[2].Text = logro.logro.nombre;
                e.Row.Cells[3].Text = logro.logro.descripcion;
                e.Row.Cells[4].Text = logro.fechaDesbloqueo.ToString("dd/MM/yyyy");
            }
        }
    }
}


/*public string TituloJuego
        {
            get { return this.juego.producto.titulo; }
        }

        public string NombreLogro
        {
            get { return this.logro.nombre; }
        }

        public string DescripcionLogro
        {
            get { return this.logro.descripcion; }
        }*/