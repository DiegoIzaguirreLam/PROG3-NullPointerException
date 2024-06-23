using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SteamWA.SteamServiceWS;

namespace SteamWA
{
    public partial class GestionarSubforo : System.Web.UI.Page
    {
        private foro padre;
        private subforo subPadre;
        private BindingList<hilo> hilos;
        private HiloWSClient daoHilo;
        private MensajeWSClient daoMensaje;
        private UsuarioWSClient daoUsuario;
        private NotificacionWSClient daoNotificacion;
        private ForoUsuarioWSClient daoForoUsuario;
        private GestorSancionesWSClient daoGestor;
        private PalabrasProhibidasWSClient daoPalabras;

        protected void Page_Load(object sender, EventArgs e)
        {
            daoHilo = new HiloWSClient();
            daoMensaje = new MensajeWSClient();
            daoUsuario = new UsuarioWSClient();
            daoNotificacion = new NotificacionWSClient();
            daoForoUsuario = new ForoUsuarioWSClient();
            daoGestor = new GestorSancionesWSClient();
            daoPalabras = new PalabrasProhibidasWSClient();

            subPadre = (subforo)Session["subforoPadre"];

            string nombre = Request.QueryString["subforo"];
            padre = (foro)Session["foroPadre"];
            gestorSanciones gestor = daoGestor.buscarGestor(((usuario)Session["usuario"]).UID);
            txtCrearMensaje.Enabled = true;
            if (gestor.contadorBaneos == 1 && gestor.fechaFinBan > DateTime.Now)
            {
                txtCrearMensaje.Text = "Estas baneado hasta " + gestor.fechaFinBan;
                txtCrearMensaje.Enabled = false;
            }
                if (!IsPostBack)
            {
                DataTable dtHilos = new DataTable();
                dtHilos.Columns.Add("NombreUsuario", typeof(string));
                dtHilos.Columns.Add("FotoPerfil", typeof(string));
                dtHilos.Columns.Add("URLImagen", typeof(string));
                dtHilos.Columns.Add("idHilo", typeof(int));

                hilo[] aux = daoHilo.mostrarHilosSubforo(subPadre);
                if (aux != null) hilos = new BindingList<hilo>(aux);
                Session["auxHilos"] = hilos;

                foreach (hilo h in hilos) dtHilos.Rows.Add(h.nombre, h.fotoPerfil, h.imagenUrl, h.idHilo);
                
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
            master.ItemComunidad.Attributes["class"] = "active";
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
            txtCrearMensaje.Text = "";
            hilos = (BindingList<hilo>)Session["auxHilos"];
            DataTable dtHilos = new DataTable();
            dtHilos.Columns.Add("Contenido", typeof(string));
            dtHilos.Columns.Add("Creador", typeof(string));
            dtHilos.Columns.Add("URLImagen", typeof(string));
            int idHilo = Int32.Parse(((LinkButton)sender).CommandArgument);
            hilo hiloAux = hilos.SingleOrDefault(x => x.idHilo == idHilo);
            Session["hiloAux"] = hiloAux;
            mensaje[] aux = daoMensaje.mostrarMensajesHilo(hiloAux);
            BindingList<mensaje> mensajesHilo = new BindingList<mensaje>();
            if (aux != null) mensajesHilo = new BindingList<mensaje>(aux);
            bool flag = false;
            lblTitulo.Text = mensajesHilo[0].contenido + " - " + mensajesHilo[0].nombreUsuario;
            Session["primerMensaje"] = mensajesHilo[0].contenido;
            foreach (mensaje m in mensajesHilo)
            {
                if(m.nombreUsuario.Length > 10)
                {
                    m.nombreUsuario = m.nombreUsuario.Substring(0, 10);
                    m.nombreUsuario += "...";
                }
                if (flag) dtHilos.Rows.Add(m.contenido, m.nombreUsuario, m.fotoPerfil);
                flag = true;
            }
            lvMensajes.DataSource = dtHilos;
            lvMensajes.DataBind();
            string script = "window.onload = function() { showModalForm('form-modal-hilo-lector') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            usuario user = (usuario)Session["usuario"];
            gestorSanciones gestor = daoGestor.buscarGestor(user.UID);
            if (txtCrearMensaje.Enabled == false || (gestor.contadorBaneos == 1 && gestor.fechaFinBan > DateTime.Now))
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
            if (txtMensajeInicial.Text.CompareTo("") == 0){
                string script = "window.onload = function() { showModalForm('form-modal-faltan-datos') };";
                ClientScript.RegisterStartupScript(GetType(), "", script, true);
                return;
            }
            if (daoPalabras.buscarPalabraProhibida(txtMensajeInicial.Text))
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
            int id;
            hilo neoHilo = new hilo();
            mensaje neomensaje = new mensaje();
            foro pad = (foro)Session["foroPadre"]; 
            int[] auxSubs;
            BindingList<int> subs = new BindingList<int>();
            neoHilo.subforo = (subforo)Session["subforoPadre"];
            neoHilo.fechaCreacion = DateTime.Now;
            neoHilo.idCreador = user.UID;
            neoHilo.fechaModificacion = DateTime.Parse(DateTime.Now.ToString());
            neoHilo.fijado = true;

            string filename = "default.jpg";
            if (fileUpdloadFotoHilo.HasFile)
            {
                // Obtener la extensión del archivo
                string extension = System.IO.Path.GetExtension(fileUpdloadFotoHilo.FileName);
                // Verificar si el archivo es una imagen
                if (extension.ToLower() == ".jpg" || extension.ToLower() == ".jpeg" || extension.ToLower() == ".png" || extension.ToLower() == ".gif")
                {
                    // Guardar la imagen en el servidor
                    filename = Guid.NewGuid().ToString() + extension;
                    string filepath = Server.MapPath("~/Uploads/") + filename;
                    fileUpdloadFotoHilo.SaveAs(Server.MapPath("~/Uploads/") + filename);
                    // Mostrar la imagen en la página
                    //imgFotoGrupo.ImageUrl = "~/Uploads/" + filename;
                    //imgFotoGrupo.Visible = true;
                    // Guardamos la referencia en una variable de sesión llamada foto
                    FileStream fs = new FileStream(filepath, FileMode.Open, FileAccess.Read);
                    BinaryReader br = new BinaryReader(fs);
                    Session["foto"] = br.ReadBytes((int)fs.Length);
                    fs.Close();
                }
                else
                {
                    // Mostrar un mensaje de error si el archivo no es una imagen
                    Response.Write("Por favor, selecciona un archivo de imagen válido.");
                }
            }

            neoHilo.imagenUrl = "Uploads/" + filename;

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

        protected void btnEnviarMensaje_Click(object sender, EventArgs e)
        {
            string mensajeAux = txtCrearMensaje.Text;
            txtCrearMensaje.Text = "";
            usuario user = (usuario)Session["usuario"];
            gestorSanciones gestor = daoGestor.buscarGestor(user.UID);
            if (gestor.contadorBaneos == 1 && gestor.fechaFinBan > DateTime.Now)
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
            if (mensajeAux.CompareTo("") == 0) return;
            if (daoPalabras.buscarPalabraProhibida(mensajeAux))
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
            mensaje neomensaje = new mensaje();
            hilo pert = (hilo)Session["hiloAux"];
            foro pad = (foro)Session["foroPadre"];
            int[] auxSubs;
            BindingList<int> subs = new BindingList<int>();
            neomensaje.hilo = pert;
            neomensaje.fechaPublicacion = DateTime.Now;
            neomensaje.idAutor = user.UID;
            neomensaje.contenido = mensajeAux;
            int id = daoMensaje.insertarMensaje(neomensaje);
            notificacion notificacionForo = new notificacion();
            notificacionForo.tipoSpecified = true;
            notificacionForo.usuario = (usuario)Session["usuario"];
            notificacionForo.tipo = tipoNotificacion.FOROS;
            notificacionForo.mensaje = "Has comentado el hilo " + (string)Session["primerMensaje"] + " con el mensaje " + neomensaje.contenido;
            int resultado = daoNotificacion.insertarNotificacion(notificacionForo);
            notificacionForo.mensaje = user.nombrePerfil + " ha comentado el hilo " + (string)Session["primerMensaje"] + " con el mensaje " + neomensaje.contenido + " en el subforo " + ((subforo)Session["subforoPadre"]).nombre + " del foro " + ((foro)Session["foroPadre"]).nombre;
            auxSubs = daoForoUsuario.listarSuscriptores(pad.idForo);
            if (auxSubs != null) subs = new BindingList<int>(auxSubs);
            usuario auxUser = new usuario();
            foreach (int suscriptor in subs)
            {
                auxUser.UID = suscriptor;
                notificacionForo.usuario = auxUser;
                resultado = daoNotificacion.insertarNotificacion(notificacionForo); //Envía la notificación a cada suscriptor
            }
            ((LinkButton)sender).CommandArgument = pert.idHilo.ToString();
            btnAbrirHilo_Click(sender, e);
        }
    }
}