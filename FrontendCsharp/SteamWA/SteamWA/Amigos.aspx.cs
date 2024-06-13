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
            BindingList<usuario> bloqueados = (BindingList<usuario>)Session["bloqueados"];

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

            // Eliminación de la base de datos
            RelacionWSClient daoRelacion = new RelacionWSClient();
            daoRelacion.eliminarAmigo(idUsuario, idPorEliminar);

            // Se obtiene la variable ReadOnly
            BindingList<usuario> amigosReadOnly = (BindingList<usuario>)Session["amigos"];
            // Se crea una copia de la variable ReadOnly
            BindingList<usuario> amigos = new BindingList<usuario>(amigosReadOnly.ToList());

            // Eliminación del amigo
            usuario amigoPorEliminar = amigos.FirstOrDefault(u => u.UID == idPorEliminar);
            if (amigoPorEliminar != null) amigos.Remove(amigoPorEliminar);

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

            // Se obtienen las variables ReadOnly
            BindingList<usuario> amigosReadOnly = (BindingList<usuario>)Session["amigos"];
            BindingList<usuario> bloqueadosReadOnly = (BindingList<usuario>)Session["bloqueados"];

            // Se crean copias de las variables ReadOnly
            BindingList<usuario> amigos = new BindingList<usuario>(amigosReadOnly.ToList());
            BindingList<usuario> bloqueados = new BindingList<usuario>(bloqueadosReadOnly.ToList());

            // Obtener el amigo por bloquear
            usuario amigoPorBloquear = amigos.FirstOrDefault(u => u.UID == idPorBloquear);

            // Mover el amigo por bloquear desde los amigos a los bloqueados
            if (amigoPorBloquear != null) amigos.Remove(amigoPorBloquear);
            if (amigoPorBloquear != null) bloqueados.Add(amigoPorBloquear);

            // Actualización de las variables en la sesión
            Session["amigos"] = amigos;
            Session["bloqueados"] = bloqueados;

            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }
    }
}