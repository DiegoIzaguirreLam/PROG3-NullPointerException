using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
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