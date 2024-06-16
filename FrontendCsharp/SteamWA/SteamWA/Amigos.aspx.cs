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
            // Crear el DataTable para mostrar las tarjetas
            DataTable dtAmigos = new DataTable();
            dtAmigos.Columns.Add("UID", typeof(int));
            dtAmigos.Columns.Add("NombrePerfil", typeof(string));

            // Cargar los amigos y bloqueados del usuario
            BindingList<usuario> amigos = (BindingList<usuario>)Session["amigos"];

            // Se agregan los amigos al DataTable
            foreach (usuario amigo in amigos)
                dtAmigos.Rows.Add(amigo.UID, amigo.nombrePerfil);

            // Se enlaza el DataTable con el ListView
            lvAmigos.DataSource = dtAmigos;
            lvAmigos.DataBind();

            Steam master = (Steam)this.Master;
            master.ItemAmigos.Attributes["class"] = "active";
        }

        protected void btnAgregarAmigo_Click(object sender, EventArgs e)
        {
            Response.Redirect("BuscarAmigos.aspx");
        }

        protected void btnEliminarAmigo_Click(object sender, EventArgs e)
        {
            string[] argumentos = ((LinkButton)sender).CommandArgument.Split(',');
            string idPorEliminar = argumentos[0];
            string nombrePerfilPorEliminar = argumentos[1];

            // Guardar el ID del amigo que se va a eliminar
            Session["idPorEliminar"] = Int32.Parse(idPorEliminar);
            txtConfirmacionEliminar.InnerText = $"¿Estás seguro de que deseas eliminar a " +
                                                $"{nombrePerfilPorEliminar} (ID = {idPorEliminar}) " +
                                                $"de tu lista de amigos?";

            // Mostrar el modal de confirmación de eliminación
            string script = "window.onload = function() { showModalForm('form-modal-EliminarAmigo') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnBloquearAmigo_Click(object sender, EventArgs e)
        {
            string[] argumentos = ((LinkButton)sender).CommandArgument.Split(',');
            string idPorBloquear = argumentos[0];
            string nombrePerfilPorBloquear = argumentos[1];


            // Guardar el ID del amigo que se va a bloquear
            Session["idPorBloquear"] = Int32.Parse(idPorBloquear);
            txtConfirmacionBloquear.InnerText = $"¿Estás seguro de que deseas bloquear a " +
                                                $"{nombrePerfilPorBloquear} (ID = {idPorBloquear})?";

            // Mostrar el modal de confirmación de bloqueo
            string script = "window.onload = function() { showModalForm('form-modal-BloquearUsuario') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnEliminarAmigoModal_Click(object sender, EventArgs e)
        {
            int idUsuario = ((usuario)Session["usuario"]).UID;
            int idPorEliminar = (int) Session["idPorEliminar"];

            // Eliminación de la base de datos
            RelacionWSClient daoRelacion = new RelacionWSClient();
            daoRelacion.eliminarAmigo(idUsuario, idPorEliminar);

            // Se obtiene una copia de la variable de sesión
            BindingList<usuario> amigos =
                new BindingList<usuario>(((BindingList<usuario>)Session["amigos"]).ToList());

            // Eliminación del amigo
            amigos.Remove(amigos.FirstOrDefault(u => u.UID == idPorEliminar));

            // Actualización de la variable en la sesión
            Session["amigos"] = amigos;
            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }

        protected void btnBloquearAmigoModal_Click(object sender, EventArgs e)
        {
            int idUsuario = ((usuario)Session["usuario"]).UID;
            int idPorBloquear = (int)Session["idPorBloquear"];

            // Bloqueo en la base de datos
            RelacionWSClient daoRelacion = new RelacionWSClient();
            daoRelacion.bloquearUsuario(idUsuario, idPorBloquear);

            // Se crean copias de las variables de sesión
            BindingList<usuario> amigos =
                new BindingList<usuario>(((BindingList<usuario>)Session["amigos"]).ToList());
            BindingList<usuario> bloqueados =
                new BindingList<usuario>(((BindingList<usuario>)Session["bloqueados"]).ToList());

            // Obtener el amigo por bloquear
            usuario amigoPorBloquear = amigos.FirstOrDefault(u => u.UID == idPorBloquear);

            // Mover el amigo por bloquear desde los amigos a los bloqueados
            amigos.Remove(amigoPorBloquear);
            bloqueados.Add(amigoPorBloquear);

            // Actualización de las variables en la sesión
            Session["amigos"] = amigos;
            Session["bloqueados"] = bloqueados;

            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }
    }
}