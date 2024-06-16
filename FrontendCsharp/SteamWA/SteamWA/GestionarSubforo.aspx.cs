using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SteamWA.SteamServiceWS;

namespace SteamWA
{
    public partial class GestionarSubforo : System.Web.UI.Page
    {
        foro padre;
        subforo subPadre;
        BindingList<hilo> hilos;
        HiloWSClient daoHilo;
        MensajeWSClient daoMensaje;
        UsuarioWSClient daoUsuario;

        protected void Page_Load(object sender, EventArgs e)
        {
            daoHilo = new HiloWSClient();
            daoMensaje = new MensajeWSClient();
            daoUsuario = new UsuarioWSClient();

            subPadre = (subforo)Session["subforoPadre"];

            string nombre = Request.QueryString["subforo"];
            padre = (foro)Session["foroPadre"];

            if (!IsPostBack)
            {
                DataTable dtHilos = new DataTable();
                dtHilos.Columns.Add("NombreUsuario", typeof(string));
                dtHilos.Columns.Add("URLImagen", typeof(string));
                dtHilos.Columns.Add("idHilo", typeof(int));

                hilo[] aux = daoHilo.mostrarHilosSubforo(subPadre);
                if (aux != null) hilos = new BindingList<hilo>(aux);
                BindingList<usuario> usuarios = new BindingList<usuario>();
                usuario[] aux1 = daoUsuario.listarUsuarios();
                if (aux1 != null) usuarios = new BindingList<usuario>(aux1);

                foreach (hilo h in hilos)
                {
                    usuario u = usuarios.SingleOrDefault(x => x.UID == h.idCreador);
                    if (u != null) dtHilos.Rows.Add(u.nombrePerfil, h.imagenUrl, h.idHilo);
                }

                lvHilos.DataSource = dtHilos;
                lvHilos.DataBind();
            }
            if (nombre != null)
            {
                subforo.Text = nombre;
            }
            if(padre != null)
            {
                nombreForo.Text = padre.nombre;
            }

            Steam master = (Steam)this.Master;
            master.ItemAmigos.Attributes["class"] = "active";
        }

        protected void btnVolverComunidad_Click(object sender, EventArgs e)
        {
            Response.Redirect("Comunidad.aspx");
        }

        protected void btnVolverForo_Click(object sender, EventArgs e)
        {
            //int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            //Foro foro = areas.SingleOrDefault(x => x.IdArea == idArea);
            //Session["objeto"]=foro
            Response.Redirect("GestionarForo.aspx?foro=" + padre.nombre);
        }

        protected void btnActualizarSubforo_Click(object sender, EventArgs e)
        {
            string nombreForo = "pruebitaSubforo"; //Al crear foro analizará que permita máximo 15 caracteres para el nombre
            //int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            //Foro foro = areas.SingleOrDefault(x => x.IdArea == idArea);
            //Session["objeto"]=foro
            Session["foro_nombre"] = padre; //Por ahora manda un String
            Response.Redirect("GestionarSubforo.aspx?subforo=" + nombreForo);
        }

        protected void btnCrearHilo_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-hilo') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnAbrirHilo_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-hilo-lector') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }
    }
}