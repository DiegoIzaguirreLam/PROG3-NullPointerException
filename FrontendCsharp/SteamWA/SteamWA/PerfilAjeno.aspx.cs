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
    public partial class PerfilAjeno : System.Web.UI.Page
    {
        private UsuarioWSClient daoUsuario;
        private LogroDesbloqueadoWSClient daoLogroDesbloqueado;
        int idUsuarioAjeno;
        protected void Page_Load(object sender, EventArgs e)
        {
            // Para que la pantalla inicie en la vista de logros
            if (!IsPostBack) lbLogros_Click(null, null);

            // Mostrar los datos del usuario en los labels
            cargarDatosUsuario();

            daoLogroDesbloqueado = new LogroDesbloqueadoWSClient();
            logroDesbloqueado[] logros = daoLogroDesbloqueado.listarLogrosPorUsuario(idUsuarioAjeno);

            if (logros == null)
            {
                gvLogros.DataSource = null;
            }
            else
            {
                gvLogros.DataSource = new BindingList<logroDesbloqueado>(logros);
            }
            gvLogros.DataBind();
            Steam master = (Steam)this.Master;
            master.ItemAmigos.Attributes["class"] = "active";
        }

        protected void cargarDatosUsuario()
        {
            string uid = Request.QueryString["uid"];
            if (uid == null)
                Response.Redirect("Amigos.aspx");
            idUsuarioAjeno = Int32.Parse(uid);
            daoUsuario = new UsuarioWSClient();
            usuario usuario = daoUsuario.buscarUsuarioPorId(idUsuarioAjeno);

            lblNombreCuenta.InnerText = usuario.nombreCuenta;
            lblUID.Text = usuario.UID.ToString();
            lblCorreo.Text = usuario.correo;
            lblTelefono.Text = usuario.telefono;
            lblFechaNacimiento.Text = usuario.fechaNacimiento.ToString("dd/MM/yyyy");
            imgPerfil.ImageUrl = usuario.fotoURL;
            btnPerfilAmigo.Text = "Perfil de " + usuario.nombrePerfil;
            if (usuario.verificado)
            {
                lblVerificado.InnerText = "Verificado por Steam";
                lblVerificado.Style["color"] = "green";
                iconVerificado.Style["color"] = "green";
            }
        }

        protected void lbLogros_Click(object sender, EventArgs e)
        {
            lbLogros.CssClass = "nav-link bg-navy text-light bg-gradient";
            MultiView1.SetActiveView(ViewLogrosObtenidos);
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

        protected void volverPaginaAmigos_Click(object sender, EventArgs e)
        {
            Response.Redirect("Amigos.aspx");
        }

    }
}