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
        NotificacionWSClient daoNotificacion;
        ForoUsuarioWSClient daoForoUsuario;

        protected void Page_Load(object sender, EventArgs e)
        {
            daoHilo = new HiloWSClient();
            daoMensaje = new MensajeWSClient();
            daoUsuario = new UsuarioWSClient();
            daoNotificacion = new NotificacionWSClient();
            daoForoUsuario = new ForoUsuarioWSClient();

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
            padre = (foro)Session["foroPadre"];
            Response.Redirect("GestionarForo.aspx?foro=" + padre.nombre);
        }

        protected void btnActualizarSubforo_Click(object sender, EventArgs e)
        {
            string nombreForo = ((subforo)Session["subforoPadre"]).nombre; //Al crear foro analizará que permita máximo 15 caracteres para el nombre
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

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (txtMensajeInicial.Text.CompareTo("") == 0){
                string script = "window.onload = function() { showModalForm('form-modal-faltan-datos') };";
                ClientScript.RegisterStartupScript(GetType(), "", script, true);
                return;
            }
            int id;
            hilo neoHilo = new hilo();
            mensaje neomensaje = new mensaje();
            foro pad = (foro)Session["foroPadre"]; 
            usuario user = (usuario)Session["usuario"];
            int[] auxSubs;
            BindingList<int> subs = new BindingList<int>();
            neoHilo.subforo = (subforo)Session["subforoPadre"];
            neoHilo.fechaCreacion = DateTime.Now;
            neoHilo.idCreador = user.UID;
            neoHilo.fechaModificacion = DateTime.Parse(DateTime.Now.ToString());
            neoHilo.fijado = true;
            neoHilo.imagenUrl = "asdds";
            id = daoHilo.insertarHilo(neoHilo);
            neoHilo.idHilo = id;
            neomensaje.hilo = neoHilo;
            neomensaje.fechaPublicacion = DateTime.Now;
            neomensaje.idAutor = user.UID;
            neomensaje.contenido = txtMensajeInicial.Text;
            id = daoMensaje.insertarMensaje(neomensaje);
            notificacion notificacionForo = new notificacion();
            notificacionForo.tipoSpecified = true;
            notificacionForo.usuario = (usuario)Session["usuario"];
            notificacionForo.tipo = tipoNotificacion.FOROS;
            notificacionForo.mensaje = "Has creado un hilo con el mensaje " + neomensaje.contenido;
            int resultado = daoNotificacion.insertarNotificacion(notificacionForo);
            notificacionForo.mensaje = user.nombrePerfil + " ha creado un hilo con mensaje " + neomensaje.contenido + " en el subforo " + ((subforo)Session["subforoPadre"]).nombre + " del foro " + ((foro)Session["foroPadre"]).nombre;
            auxSubs = daoForoUsuario.listarSuscriptores(pad.idForo);
            if (auxSubs != null) subs = new BindingList<int>(auxSubs);
            usuario auxUser = new usuario();
            foreach (int suscriptor in subs)
            {
                auxUser.UID = suscriptor;
                notificacionForo.usuario = auxUser;
                resultado = daoNotificacion.insertarNotificacion(notificacionForo); //Envía la notificación a cada suscriptor
            }
            Response.Redirect("GestionarSubforo.aspx?subforo=" + ((subforo)Session["subforoPadre"]).nombre);
        }
    }
}