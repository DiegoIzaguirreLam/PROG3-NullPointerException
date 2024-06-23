using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Threading;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using SteamWA.SteamServiceWS;

namespace SteamWA
{
    public partial class Comunidad : System.Web.UI.Page
    {
        private BindingList<foro> foros;
        private BindingList<foro> creados;
        private BindingList<foro> suscritos;
        private ForoWSClient daoForo;
        private SubforoWSClient daoSubforo;
        private HiloWSClient daoHilo;
        private MensajeWSClient daoMensaje;
        private ForoUsuarioWSClient daoForoUsuario;
        private NotificacionWSClient daoNotificacion;
        private GestorSancionesWSClient daoGestor;
        private PalabrasProhibidasWSClient daoPalabras;
        private ReportesWSClient daoReportes;
        private byte[] foto;

        private int[] pageIndex;

        protected void Page_Load(object sender, EventArgs e)
        {
            daoForo = new ForoWSClient();
            daoSubforo = new SubforoWSClient();
            daoHilo = new HiloWSClient();
            daoMensaje = new MensajeWSClient();
            daoForoUsuario = new ForoUsuarioWSClient();
            daoNotificacion = new NotificacionWSClient();
            daoGestor = new GestorSancionesWSClient();
            daoPalabras = new PalabrasProhibidasWSClient();

            pageIndex = (int[])Session["IndexPages"];
            if (pageIndex == null && !IsPostBack)
            {
                pageIndex = new int[3];
                Session["IndexPages"] = pageIndex;
            }
            else if (IsPostBack) pageIndex = (int[])Session["IndexPages"];
            if (!IsPostBack)
            {
                pageIndex = new int[3];
                Session["IndexPages"] = pageIndex;
                foro[] aux = daoForo.listarForos();
                if (aux != null) foros = new BindingList<foro>(aux);
                gvForos.DataSource = foros;
                gvForos.DataBind();
                Session["forosAux"] = foros;
            }
            if (Session["MostrarCreados"] != null && (Boolean)Session["MostrarCreados"] == true)
            {
                Session["MostrarCreados"] = false;
                creados = (BindingList<foro>)Session["ForosCreados"];
                gvCreados.DataSource = creados;
                gvCreados.DataBind();
                pageIndex = (int[])Session["IndexPages"];
                if (pageIndex[1] >= (int)(creados.Count / 5) && pageIndex[1] > 0)
                {
                    pageIndex[1] = (int)(creados.Count / 5) - 1;
                    Session["IndexPages"] = pageIndex;
                }
                if ((creados.ToList()).Count > 0)
                {
                    string script = "window.onload = function() { showModalForm('form-modal-creados') };";
                    ClientScript.RegisterStartupScript(GetType(), "", script, true);
                }
            }
            if (IsPostBack && txtBusquedaForo.Text != null && txtBusquedaForo.Text.CompareTo("") != 0)
            {
                foro[] aux1 = daoForo.buscarForos(txtBusquedaForo.Text);
                if (aux1 != null) foros = new BindingList<foro>(aux1);
                gvForos.DataSource = foros;
                gvForos.DataBind();
                Session["forosAux"] = foros;
                pageIndex[0] = 0; //Se encuentra en 0 inicialmente
                Session["IndexPages"] = pageIndex;
                txtBusquedaForo.Focus();
            }
            if (txtBusquedaForo.Text.CompareTo("") == 0) txtBusquedaForo.Focus();
            Steam master = (Steam)this.Master;
            master.ItemComunidad.Attributes["class"] = "active";
            //ComunidadWS.ComunidadWSClient a = new ComunidadWS.ComunidadWSClient();
            //a.hello("a");
        }

        protected void btnActualizarComunidad_Click(object sender, EventArgs e)
        {
            Response.Redirect("Comunidad.aspx");
        }

        protected void btnCrearForo_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-foro') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbAbrirForo_Click(object sender, EventArgs e)
        {
            foros = (BindingList<foro>)Session["forosAux"];
            int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            foro foro = foros.SingleOrDefault(x => x.idForo == idForo);
            Session["foroPadre"] = foro;
            Response.Redirect("GestionarForo.aspx?foro=" + foro.nombre);
        }

        protected void lbActualizarInfoForo_Click(object sender, EventArgs e)
        {
            foros = (BindingList<foro>)Session["forosAux"];
            int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            foro foro = foros.SingleOrDefault(x => x.idForo == idForo);
            Session["foroParaActualizar"] = foro;
            txtNTema.Text = foro.nombre;
            txtNDescripcion.Text = foro.descripcion;
            string script = "window.onload = function() { showModalForm('form-modal-edicion') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbEliminarForo_Click(object sender, EventArgs e)
        {
            foros = (BindingList<foro>)Session["ForosCreados"];
            int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            foro foro = foros.SingleOrDefault(x => x.idForo == idForo);
            daoForoUsuario.eliminarRelacion(foro.idForo, foro.idCreador);
            Session["MostrarCreados"] = true;
            List<foro> aux = foros.ToList();
            aux.Remove(foro);
            foros = new BindingList<foro>(aux);
            Session["ForosCreados"] = foros;
            if (daoForo.eliminarForo(foro) != 0) Response.Redirect("Comunidad.aspx");
        }

        protected void lbDesuscribir_Click(object sender, EventArgs e)
        {
            foros = (BindingList<foro>)Session["ForosSuscritos"];
            usuario user = (usuario)Session["usuario"];
            int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            foro foro = foros.SingleOrDefault(x => x.idForo == idForo);
            Session["MostrarSuscritos"] = true;
            List<foro> aux = foros.ToList();
            aux.Remove(foro);
            foros = new BindingList<foro>(aux);
            if (daoForoUsuario.desuscribirRelacion(foro.idForo, user.UID) != 0)
            {
                gvSuscritos.DataSource = foros;
                gvSuscritos.DataBind();
                Session["ForosSuscritos"] = foros;
                pageIndex = (int[])Session["IndexPages"];
                if (pageIndex[2] >= (int)(foros.Count / 5) && pageIndex[2] > 0)
                {
                    pageIndex[2] = (int)(foros.Count / 5) - 1;
                    Session["IndexPages"] = pageIndex;
                }
                if (aux.Count > 0)
                {
                    string script = "window.onload = function() { showModalForm('form-modal-suscritos') };";
                    ClientScript.RegisterStartupScript(GetType(), "", script, true);
                }
            }
        }

        protected void lbSuscribirForo_Click(object sender, EventArgs e)
        {
            foros = (BindingList<foro>)Session["forosAux"];
            int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            foro foro = foros.SingleOrDefault(x => x.idForo == idForo);
            usuario user = (usuario)Session["usuario"];
            foro[] aux = daoForo.listarForosSuscritos(user.UID);
            foro checker = null;
            if (aux != null)
            {
                BindingList<foro> auxSuscritos = new BindingList<foro>(aux);
                checker = auxSuscritos.SingleOrDefault(x => x.idForo == idForo);
            }
            if (checker == null) //No debe de encontrarlo para que pueda suscribirse, así evita suscribirse n veces
            {
                daoForoUsuario.suscribirRelacion(Int32.Parse(((LinkButton)sender).CommandArgument), user.UID);
                notificacion notificacionForo = new notificacion();
                notificacionForo.tipoSpecified = true;
                notificacionForo.usuario = (usuario)Session["usuario"];
                notificacionForo.tipo = tipoNotificacion.FOROS;
                notificacionForo.mensaje = "Te has suscrito al foro " + foro.nombre;
                int resultado = daoNotificacion.insertarNotificacion(notificacionForo);
            }
        }

        protected void btnActualizarForo_Click(object sender, EventArgs e)
        {
            foro actforo = (foro)Session["foroParaActualizar"];
            string nAntiguo = actforo.nombre;
            actforo.nombre = txtNTema.Text;
            actforo.descripcion = txtNDescripcion.Text;
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
            if (txtNTema.Text.CompareTo("") == 0 || txtNDescripcion.Text.CompareTo("") == 0)
            {
                string script = "window.onload = function() { showModalForm('form-modal-faltan-datos') };";
                ClientScript.RegisterStartupScript(GetType(), "", script, true);
                return;
            }
            if (daoPalabras.buscarPalabraProhibida(txtNTema.Text) || daoPalabras.buscarPalabraProhibida(txtNDescripcion.Text))
            {
                gestor.contadorFaltas++;
                if (gestor.maxFaltas > gestor.contadorFaltas)
                {
                    txtMensajeFalta.Text = "Usted ha cometido una falta, le quedan " + (gestor.maxFaltas - gestor.contadorFaltas) + " oportunidades.";
                    string script = "window.onload = function() { showModalForm('form-modal-falta') };";
                    ClientScript.RegisterStartupScript(GetType(), "", script, true);
                }
                else
                {
                    //gestor.fechaFinBan = date DateTime.Now.AddDays(3); //Se le banea por 3 días
                    gestor.contadorBaneos = 1;
                    txtMensajeFalta.Text = "Usted ha sido baneado hasta " + gestor.fechaFinBan;
                    string script = "window.onload = function() { showModalForm('form-modal-falta') };";
                    ClientScript.RegisterStartupScript(GetType(), "", script, true);
                }
                daoGestor.actualizarGestor(gestor);
                return;
            }
            daoForo.editarForo(actforo);
            notificacion notificacionForo = new notificacion();
            notificacionForo.tipoSpecified = true;
            notificacionForo.usuario = (usuario)Session["usuario"];
            notificacionForo.tipo = tipoNotificacion.FOROS;
            if(nAntiguo.CompareTo(actforo.nombre) != 0) notificacionForo.mensaje = "Has actualiazado el foro " + nAntiguo + " ahora llamado " + actforo.nombre;
            int resultado = daoNotificacion.insertarNotificacion(notificacionForo);
            Response.Redirect("Comunidad.aspx");
        }

        protected void btnGuardarForoModal_Click(object sender, EventArgs e)
        {
            int id;
            foro neoforo = new foro();
            subforo neosubforo = new subforo();
            usuario user = (usuario)Session["usuario"];
            hilo neohilo = new hilo();
            mensaje neomensaje = new mensaje();
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
            if (user == null || txtTema.Text.CompareTo("") == 0 || txtDescripcion.Text.CompareTo("") == 0 || txtInicial.Text.CompareTo("") == 0 || txtMensajeInicial.Text.CompareTo("") == 0)
            {
                string script = "window.onload = function() { showModalForm('form-modal-faltan-datos') };";
                ClientScript.RegisterStartupScript(GetType(), "", script, true);
                return;
            }
            if(daoPalabras.buscarPalabraProhibida(txtTema.Text) || daoPalabras.buscarPalabraProhibida(txtDescripcion.Text)
                || daoPalabras.buscarPalabraProhibida(txtInicial.Text) || daoPalabras.buscarPalabraProhibida(txtMensajeInicial.Text))
            {
                gestor.contadorFaltas++;
                if (gestor.maxFaltas > gestor.contadorFaltas)
                {
                    txtMensajeFalta.Text = "Usted ha cometido una falta, le quedan " + (gestor.maxFaltas - gestor.contadorFaltas) + " oportunidades.";
                    string script = "window.onload = function() { showModalForm('form-modal-falta') };";
                    ClientScript.RegisterStartupScript(GetType(), "", script, true);
                }
                else
                {
                    //gestor.fechaFinBan = date DateTime.Now.AddDays(3); //Se le banea por 3 días
                    gestor.contadorBaneos = 1;
                    txtMensajeFalta.Text = "Usted ha sido baneado hasta " + gestor.fechaFinBan;
                    string script = "window.onload = function() { showModalForm('form-modal-falta') };";
                    ClientScript.RegisterStartupScript(GetType(), "", script, true);
                }                
                daoGestor.actualizarGestor(gestor);
                return;
            }
            neoforo.nombre = txtTema.Text;
            neoforo.descripcion = txtDescripcion.Text;
            neoforo.nombreCreador = user.nombrePerfil.ToString();
            id = daoForo.insertarForo(neoforo);
            daoForoUsuario.crearRelacion(id, user.UID);
            daoForoUsuario.suscribirRelacion(id, user.UID);
            neoforo.idForo = id;
            neosubforo.foro = neoforo;
            neosubforo.nombre = txtInicial.Text;
            id = daoSubforo.insertarSubforo(neosubforo);
            neosubforo.idSubforo = id;
            neohilo.fechaCreacion = DateTime.Now;
            neohilo.idCreador = user.UID;
            neohilo.subforo = neosubforo;
            neohilo.fechaModificacion = DateTime.Parse(DateTime.Now.ToString());
            neohilo.fijado = true;

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
            
            neohilo.imagenUrl = "Uploads/" + filename;

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
            notificacionForo.mensaje = "Has creado el foro " + neoforo.nombre;
            int resultado = daoNotificacion.insertarNotificacion(notificacionForo);
            Response.Redirect("Comunidad.aspx");
        }

        //[WebMethod]
        protected void txtBusquedaForo_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnSuscritos_Click(object sender, EventArgs e)
        {
            usuario user = (usuario)Session["usuario"];
            foro[] aux = daoForo.listarForosSuscritos(user.UID);
            string script;
            if (aux != null)
            {
                suscritos = new BindingList<foro>(aux);
                foreach (foro f in suscritos)
				{
                    if (f.nombreCreador.Length > 10)
                    {
                        f.nombreCreador = f.nombreCreador.Substring(0, 10);
                        f.nombreCreador += "...";
						
                    }
					if (f.descripcion.Length > 20)
                    {
                        f.descripcion = f.descripcion.Substring(0, 20);
                        f.descripcion += "...";
						
                    }
				}
                gvSuscritos.DataSource = suscritos;
                pageIndex = (int[])Session["IndexPages"];
                pageIndex[2] = 0;
                Session["IndexPages"] = pageIndex;
                gvSuscritos.DataBind();
                gvSuscritos.PageIndex = 0;
                Session["ForosSuscritos"] = suscritos;
                script = "window.onload = function() { showModalForm('form-modal-suscritos') };";
            } else script = "window.onload = function() { showModalForm('form-modal-sin-suscritos') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnCreados_Click(object sender, EventArgs e)
        {
            usuario user = (usuario)Session["usuario"];
            foro[] aux = daoForo.listarCreados(user.UID);
            string script;
            if (aux != null) 
            {
                creados = new BindingList<foro>(aux);
                foreach (foro f in creados)
				{
                    if (f.nombreCreador.Length > 10)
                    {
                        f.nombreCreador = f.nombreCreador.Substring(0, 10);
                        f.nombreCreador += "...";
						
                    }
					if (f.descripcion.Length > 20)
                    {
                        f.descripcion = f.descripcion.Substring(0, 20);
                        f.descripcion += "...";
						
                    }
				}
                gvCreados.DataSource = creados;
                pageIndex = (int[])Session["IndexPages"];
                pageIndex[1] = 0;
                Session["IndexPages"] = pageIndex;
                gvCreados.DataBind();
                gvCreados.PageIndex = 0;
                Session["ForosCreados"] = creados;
                script = "window.onload = function() { showModalForm('form-modal-creados') };";
            } else script = "window.onload = function() { showModalForm('form-modal-sin-creados') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void gvForos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvForos.DataSource = (BindingList<foro>)Session["forosAux"];
            gvForos.PageIndex = e.NewPageIndex;
            pageIndex[0] = e.NewPageIndex;
            Session["IndexPages"] = pageIndex;
            gvForos.DataBind();
            ScriptManager.RegisterStartupScript(this, GetType(), "", "__doPostBack('','');", true);
        }

        protected void gvCreados_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //gvCreados.DataSource = (BindingList<foro>)Session["ForosCreados"];
            gvCreados.PageIndex = e.NewPageIndex;
            pageIndex[1] = e.NewPageIndex;
            Session["IndexPages"] = pageIndex;
            //gvCreados.DataBind();
            gvCreados.DataSource = creados = (BindingList<foro>)Session["ForosCreados"];
            gvCreados.DataBind();
            Session["ForosCreados"] = creados;
            string script = "window.onload = function() { showModalForm('form-modal-creados') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void gvSuscritos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //gvSuscritos.DataSource = (BindingList<foro>)Session["ForosSuscritos"];
            gvSuscritos.PageIndex = e.NewPageIndex;
            pageIndex[2] = e.NewPageIndex;
            Session["IndexPages"] = pageIndex;
            //gvSuscritos.DataBind();
            gvSuscritos.DataSource = suscritos = (BindingList<foro>)Session["ForosSuscritos"];
            gvSuscritos.DataBind();
            Session["ForosSuscritos"] = suscritos;
            string script = "window.onload = function() { showModalForm('form-modal-suscritos') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void gvForos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            pageIndex = (int[])Session["IndexPages"];
            if(e.CommandName == "AbrirForo")
            {
                foros = (BindingList<foro>)Session["forosAux"];
                int idForo = Convert.ToInt32(e.CommandArgument);
                foro foro = foros[idForo + 5 * pageIndex[0]];
                Session["foroPadre"] = foro;
                Response.Redirect("GestionarForo.aspx?foro=" + foro.nombre);
            }
            if (e.CommandName == "AbrirForoCreado")
            {
                creados = (BindingList<foro>)Session["ForosCreados"];
                int idForo = Convert.ToInt32(e.CommandArgument);
                foro foro = creados[idForo + 5 * pageIndex[1]];
                Session["foroPadre"] = foro;
                Response.Redirect("GestionarForo.aspx?foro=" + foro.nombre);
            }
            if (e.CommandName == "AbrirForoSuscrito")
            {
                suscritos = (BindingList<foro>)Session["ForosSuscritos"];
                int idForo = Convert.ToInt32(e.CommandArgument);
                foro foro = suscritos[idForo+5 * pageIndex[2]];
                Session["foroPadre"] = foro;
                Response.Redirect("GestionarForo.aspx?foro=" + foro.nombre);
            }
        }

        protected void lbReporte_Click(object sender, EventArgs e)
        {
            daoReportes = new ReportesWSClient();
            usuario usuario = (usuario)Session["usuario"];

            byte[] reporte = daoReportes.generarReporteMensajesEnviados(usuario.UID, usuario.nombreCuenta);

            Response.Clear();

            Response.ContentType = "application/pdf";

            Response.AddHeader("Content-Disposition", "inline; filename=ReporteMensajesEnviados.pdf");

            Response.BinaryWrite(reporte);

            Response.End();
        }
    }
}