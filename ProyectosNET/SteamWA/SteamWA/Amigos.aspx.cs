using System;
using System.Collections.Generic;
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
            // Datos para simular
            if (!IsPostBack)
            {
                DataTable dtAmigos = new DataTable();
                dtAmigos.Columns.Add("UID", typeof(string));
                dtAmigos.Columns.Add("NombrePerfil", typeof(string));

                dtAmigos.Rows.Add("1", "Amigo 1");
                dtAmigos.Rows.Add("2", "Amigo 2");
                dtAmigos.Rows.Add("3", "Amigo 3");

                lvAmigos.DataSource = dtAmigos;
                lvAmigos.DataBind();
            }
        }

        protected void btnAgregarAmigo_Click(object sender, EventArgs e)
        {
            Response.Redirect("BuscarAmigos.aspx");
        }

        protected void btnEliminarAmigo_Click(object sender, EventArgs e)
        {
            // Modal
        }

        protected void btnBloquearAmigo_Click(object sender, EventArgs e)
        {
            // Modal
        }
    }
}