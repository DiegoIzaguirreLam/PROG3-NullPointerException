using SteamWA.SteamServiceWS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class Amigos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Cargar los amigos del usuario
            if (!IsPostBack) cargarAmigos();

            Steam master = (Steam)this.Master;
            master.ItemAmigos.Attributes["class"] = "active";
        }

        protected void cargarAmigos()
        {
            int idUsuario = ((usuario)Session["usuario"]).UID;

            RelacionWSClient daoRelacion = new RelacionWSClient();
            BindingList<usuario> amigos = new BindingList<usuario>
                (daoRelacion.listarAmigosPorUsuario(idUsuario));

            DataTable dtAmigos = new DataTable();

            dtAmigos.Columns.Add("UID", typeof(int));
            dtAmigos.Columns.Add("NombrePerfil", typeof(string));

            foreach (usuario amigo in amigos)
            {
                dtAmigos.Rows.Add(amigo.UID, amigo.nombrePerfil);
            }

            lvAmigos.DataSource = dtAmigos;
            lvAmigos.DataBind();
        }

        protected void btnAgregarAmigo_Click(object sender, EventArgs e)
        {
            Response.Redirect("BuscarAmigos.aspx");
        }

        protected void btnEliminarAmigo_Click(object sender, EventArgs e)
        {
            // Modal
            string script = "window.onload = function() { showModalForm('form-modal-EliminarAmigo') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);

        }

        protected void btnBloquearAmigo_Click(object sender, EventArgs e)
        {
            // Modal
            string script = "window.onload = function() { showModalForm('form-modal-BloquearUsuario') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);

        }
    }
}