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
            cargarAmigos();

            Steam master = (Steam)this.Master;
            master.ItemAmigos.Attributes["class"] = "active";
        }

        protected void cargarAmigos()
        {
            int idUsuario = ((usuario)Session["usuario"]).UID;

            RelacionWSClient daoRelacion = new RelacionWSClient();
            usuario[] listaAmigos = daoRelacion.listarAmigosPorUsuario(idUsuario);

            DataTable dtAmigos = new DataTable();

            dtAmigos.Columns.Add("UID", typeof(int));
            dtAmigos.Columns.Add("NombrePerfil", typeof(string));

            if (listaAmigos != null)
            {
                BindingList<usuario> amigos = new BindingList<usuario>(listaAmigos);

                foreach (usuario amigo in amigos)
                    dtAmigos.Rows.Add(amigo.UID, amigo.nombrePerfil);

                Session["amigos"] = amigos;
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
            // Guardar el ID del amigo que se va a eliminar
            Session["idPorEliminar"] = Int32.Parse(((LinkButton)sender).CommandArgument);

            // Mostrar el modal de confirmación de eliminación
            string script = "window.onload = function() { showModalForm('form-modal-EliminarAmigo') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnBloquearAmigo_Click(object sender, EventArgs e)
        {
            // Guardar el ID del amigo que se va a bloquear
            Session["idPorBloquear"] = Int32.Parse(((LinkButton)sender).CommandArgument);

            // Mostrar el modal de confirmación de bloqueo
            string script = "window.onload = function() { showModalForm('form-modal-BloquearUsuario') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnEliminarAmigoModal_Click(object sender, EventArgs e)
        {
            int idUsuario = ((usuario)Session["usuario"]).UID;
            int idPorEliminar = (int) Session["idPorEliminar"];

            RelacionWSClient daoRelacion = new RelacionWSClient();
            daoRelacion.eliminarAmigo(idUsuario, idPorEliminar);

            cargarAmigos();
        }

        protected void btnBloquearAmigoModal_Click(object sender, EventArgs e)
        {
            int idUsuario = ((usuario)Session["usuario"]).UID;
            int idPorBloquear = (int)Session["idPorBloquear"];

            RelacionWSClient daoRelacion = new RelacionWSClient();
            daoRelacion.bloquearUsuario(idUsuario, idPorBloquear);

            cargarAmigos();
        }
    }
}