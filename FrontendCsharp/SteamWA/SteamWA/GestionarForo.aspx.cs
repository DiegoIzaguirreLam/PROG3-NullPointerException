using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.UI;
using System.Web.UI.WebControls;
using SteamWA.SteamServiceWS;

namespace SteamWA
{
    public partial class GestionarForo : System.Web.UI.Page
    {
        BindingList<subforo> subforos;
        SubforoWSClient daoSubforo;
        HiloWSClient daoHilo;
        MensajeWSClient daoMensaje;
        NotificacionWSClient daoNotificacion;
        ForoUsuarioWSClient daoForoUsuario;
        GestorSancionesWSClient daoGestor;
        int pageIndex;

        protected void Page_Load(object sender, EventArgs e)
        {
            daoSubforo = new SubforoWSClient();
            daoHilo = new HiloWSClient();
            daoMensaje = new MensajeWSClient();
            daoNotificacion = new NotificacionWSClient();
            daoForoUsuario = new ForoUsuarioWSClient();
            daoGestor = new GestorSancionesWSClient();

            if (Session["IndexPagesSubforo"] == null)
            {
                pageIndex = 0;
                Session["IndexPagesSubforo"] = pageIndex;
            }
            else pageIndex = (int)Session["IndexPagesSubforo"];

            if (!IsPostBack)
            {
                pageIndex = 0;
                Session["IndexPagesSubforo"] = pageIndex;
                foro auxForo = (foro)Session["foroPadre"];
                subforo[] aux = daoSubforo.mostrarSubforosForo(auxForo);
                if(aux != null) subforos = new BindingList<subforo>(aux);
                gvSubforos.DataSource = subforos;
                gvSubforos.DataBind();
                Session["subforosAux"] = subforos;
            }
            /*if (IsPostBack && txtBusquedaSubforo.Text != null)
            {
                subforo[] aux1 = daoSubforo.sub(txtBusquedaSubforo.Text);
                if (aux1 != null) subforos = new BindingList<subforo>(aux1);
                gvForos.DataSource = subforos;
                gvForos.DataBind();
                Session["forosAux"] = subforos;
                txtBusquedaSubforo.Focus();
            }*/
            String nombre = Request.QueryString["foro"];
            if(nombre != null)
            {
                foro.Text = nombre;
            }
        }

        protected void btnVolverComunidad_Click(object sender, EventArgs e)
        {
            Response.Redirect("Comunidad.aspx");
        }

        protected void btnActualizarForo_Click(object sender, EventArgs e)
        {
            string nombreForo = ((foro)Session["foroPadre"]).nombre;
            Response.Redirect("GestionarForo.aspx?foro=" + nombreForo);
        }

        protected void btnCrearSubforo_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-subforo') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbActualizarSubforo_Click(object sender, EventArgs e)
        {
            subforos = (BindingList<subforo>)Session["subforosAux"];
            int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            subforo sub = subforos.SingleOrDefault(x => x.idSubforo == idForo);
            Session["subforoActualizar"] = sub;
            txtNSubforo.Text = sub.nombre;
            string script = "window.onload = function() { showModalForm('form-modal-actualizar') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void gvSubforos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSubforos.DataSource = (BindingList<subforo>)Session["subforosAux"];
            gvSubforos.PageIndex = e.NewPageIndex;
            pageIndex = e.NewPageIndex;
            Session["IndexPagesSubforo"] = pageIndex;
            gvSubforos.DataBind();
            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }

        protected void gvSubforos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AbrirSubforo")
            {
                subforos = (BindingList<subforo>)Session["subforosAux"];
                int idSubforo = Convert.ToInt32(e.CommandArgument);
                subforo sub = subforos[idSubforo + 5 * pageIndex];
                Session["subforoPadre"] = sub;
                Response.Redirect("GestionarSubforo.aspx?subforo=" + sub.nombre);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            int id;
            foro pad = (foro)Session["foroPadre"];
            subforo neosubforo = new subforo();
            hilo neohilo = new hilo();
            mensaje neomensaje = new mensaje();
            usuario user = (usuario)Session["usuario"];
            int[] auxSubs;
            BindingList<int> subs = new BindingList<int>();
            gestorSanciones gestor = daoGestor.buscarGestor(user.UID);
            if (gestor.contadorBaneos == 1 && gestor.fechaFinBan < DateTime.Now)
            {
                txtMensajeFalta.Text = "Usted se encuentra baneado hasta " + gestor.fechaFinBan;
                string script = "window.onload = function() { showModalForm('form-modal-falta') };";
                ClientScript.RegisterStartupScript(GetType(), "", script, true);
                return;
            }
            else if (gestor.contadorBaneos == 1)
            {
                gestor.contadorBaneos = 0; //Se le desbanea
                gestor.contadorFaltas = 0;
            }
            if (txtSubforo.Text.CompareTo("") == 0 || txtMensajeInicial.Text.CompareTo("") == 0)
            {
                string script = "window.onload = function() { showModalForm('form-modal-faltan-datos') };";
                ClientScript.RegisterStartupScript(GetType(), "", script, true);
                return;
            }
            if (txtSubforo.Text.CompareTo("GianLuca") == 0)
            {
                gestor.contadorFaltas++;
                if (gestor.maxFaltas > gestor.contadorFaltas)
                {
                    txtMensajeFalta.Text = "Usted ha cometido una falta, le quedan " + (gestor.maxFaltas - gestor.cantFaltas) + " oportunidades.";
                    string script = "window.onload = function() { showModalForm('form-modal-falta') };";
                    ClientScript.RegisterStartupScript(GetType(), "", script, true);
                }
                else
                {
                    gestor.fechaFinBan = DateTime.Now.AddDays(3); //Se le banea por 3 días
                    gestor.contadorBaneos = 1;
                    txtMensajeFalta.Text = "Usted ha sido baneado hasta " + gestor.fechaFinBan;
                    string script = "window.onload = function() { showModalForm('form-modal-falta') };";
                    ClientScript.RegisterStartupScript(GetType(), "", script, true);
                }
                daoGestor.actualizarGestor(gestor);
                return;
            }
            neosubforo.nombre = txtSubforo.Text;
            neosubforo.foro = (foro)Session["foroPadre"];
            id = daoSubforo.insertarSubforo(neosubforo);
            neosubforo.idSubforo = id;
            neohilo.fechaCreacion = DateTime.Now;
            neohilo.idCreador = user.UID;
            neohilo.subforo = neosubforo;
            neohilo.fechaModificacion = DateTime.Parse(DateTime.Now.ToString());
            neohilo.fijado = true;
            neohilo.imagenUrl = "asdds";
            id = daoHilo.insertarHilo(neohilo);
            neohilo.idHilo = id;
            neomensaje.hilo = neohilo;
            neomensaje.fechaPublicacion = DateTime.Now;
            neomensaje.idAutor = user.UID;
            neomensaje.contenido = txtMensajeInicial.Text;
            id = daoMensaje.insertarMensaje(neomensaje);
            notificacion notificacionForo = new notificacion();
            notificacionForo.tipoSpecified = true;
            notificacionForo.usuario = (usuario)Session["usuario"];
            notificacionForo.tipo = tipoNotificacion.FOROS;
            notificacionForo.mensaje = "Has creado el subforo " + neosubforo.nombre;
            int resultado = daoNotificacion.insertarNotificacion(notificacionForo);
            notificacionForo.mensaje = user.nombrePerfil + " ha creado el subforo " + neosubforo.nombre + " en " + ((foro)Session["foroPadre"]).nombre;
            auxSubs = daoForoUsuario.listarSuscriptores(pad.idForo);
            if (auxSubs != null) subs = new BindingList<int>(auxSubs);
            usuario auxUser = new usuario();
            foreach (int suscriptor in subs)
            {
                auxUser.UID = suscriptor;
                notificacionForo.usuario = auxUser;
                resultado = daoNotificacion.insertarNotificacion(notificacionForo); //Envía la notificación a cada suscriptor
            }
            Response.Redirect("GestionarForo.aspx?foro=" + ((foro)Session["foroPadre"]).nombre);
        }

        protected void btnActualizaSubforo_Click(object sender, EventArgs e)
        {
            usuario user = (usuario)Session["usuario"];
            gestorSanciones gestor = daoGestor.buscarGestor(user.UID);
            
            if (gestor.contadorBaneos == 1 && gestor.fechaFinBan < DateTime.Now)
            {
                txtMensajeFalta.Text = "Usted se encuentra baneado hasta " + gestor.fechaFinBan;
                string script = "window.onload = function() { showModalForm('form-modal-falta') };";
                ClientScript.RegisterStartupScript(GetType(), "", script, true);
                return;
            }
            else if (gestor.contadorBaneos == 1)
            {
                gestor.contadorBaneos = 0; //Se le desbanea
                gestor.contadorFaltas = 0;
            }
            if (txtNSubforo.Text.CompareTo("") == 0)
            {
                string script = "window.onload = function() { showModalForm('form-modal-faltan-datos') };";
                ClientScript.RegisterStartupScript(GetType(), "", script, true);
                return;
            }
            if (txtSubforo.Text.CompareTo("GianLuca") == 0)
            {
                gestor.contadorFaltas++;
                if (gestor.maxFaltas > gestor.contadorFaltas)
                {
                    txtMensajeFalta.Text = "Usted ha cometido una falta, le quedan " + (gestor.maxFaltas - gestor.cantFaltas) + " oportunidades.";
                    string script = "window.onload = function() { showModalForm('form-modal-falta') };";
                    ClientScript.RegisterStartupScript(GetType(), "", script, true);
                }
                else
                {
                    gestor.fechaFinBan = DateTime.Now.AddDays(3); //Se le banea por 3 días
                    gestor.contadorBaneos = 1;
                    txtMensajeFalta.Text = "Usted ha sido baneado hasta " + gestor.fechaFinBan;
                    string script = "window.onload = function() { showModalForm('form-modal-falta') };";
                    ClientScript.RegisterStartupScript(GetType(), "", script, true);
                }
                daoGestor.actualizarGestor(gestor);
                return;
            }
            subforo neo = (subforo)Session["subforoActualizar"];
            string nAntiguo = neo.nombre;
            neo.nombre = txtNSubforo.Text;
            daoSubforo.editarSubforo(neo);
            notificacion notificacionForo = new notificacion();
            notificacionForo.tipoSpecified = true;
            notificacionForo.usuario = (usuario)Session["usuario"];
            notificacionForo.tipo = tipoNotificacion.FOROS;
            if (nAntiguo.CompareTo(neo.nombre) != 0) notificacionForo.mensaje = "Has actualiazado el subforo " + nAntiguo + " ahora llamado " + neo.nombre;
            int resultado = daoNotificacion.insertarNotificacion(notificacionForo);
            Response.Redirect("GestionarForo.aspx?foro=" + ((foro)Session["foroPadre"]).nombre);
        }

        protected void txtBusquedaSubforo_TextChanged(object sender, EventArgs e)
        {

        }
    }
}