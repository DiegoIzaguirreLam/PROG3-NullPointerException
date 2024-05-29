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
    public partial class BuscarAmigos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbBuscarPorID_Click(object sender, EventArgs e)
        {
            UsuarioWSClient usuarioDao = new UsuarioWSClient();

            int idUsuario = Int32.Parse(txtUID.Text);

            BindingList<usuario> usuarios = new BindingList<usuario>();
            usuarios.Add(usuarioDao.buscarUsuarioPorId(idUsuario));

            gvUsuariosPorID.DataSource = usuarios;
            gvUsuariosPorID.DataBind();
        }

        protected void lbBuscarPorNombre_Click(object sender, EventArgs e)
        {
            UsuarioWSClient usuarioDao = new UsuarioWSClient();

            string nombreUsuario = txtNombre.Text;

            BindingList<usuario> usuarios = new BindingList<usuario>();
            usuarios.Add(usuarioDao.buscarUsuarioPorNombreCuenta(nombreUsuario));

            gvUsuariosPorNombre.DataSource = usuarios;
            gvUsuariosPorNombre.DataBind();
        }

        protected void lbAgregarAmigo_Click(object sender, EventArgs e)
        {
            RelacionWSClient relacionDao = new RelacionWSClient();
            int idUsuario = ((usuario)Session["usuario"]).UID;
            int idNuevoAmigo = Int32.Parse(((LinkButton)sender).CommandArgument);
            relacionDao.agregarAmigo(idUsuario, idNuevoAmigo);
            Response.Redirect("Amigos.aspx");
        }

        protected void gvUsuariosPorID_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsuariosPorID.PageIndex = e.NewPageIndex;
            gvUsuariosPorID.DataBind();
        }

        protected void gvUsuariosPorNombre_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsuariosPorNombre.PageIndex = e.NewPageIndex;
            gvUsuariosPorNombre.DataBind();
        }
    }
}