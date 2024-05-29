using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Security.Cryptography;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SteamWA.SteamServiceWS;

namespace SteamWA
{
    public partial class Comunidad : System.Web.UI.Page
    {
        BindingList<foro> foros;
        BindingList<foro> creados;
        BindingList<foro> suscritos;
        ForoWSClient daoForo;
        SubforoWSClient daoSubforo;
        HiloWSClient daoHilo;
        MensajeWSClient daoMensaje;
        ForoUsuarioWSClient daoForoUsuario;

        protected void Page_Load(object sender, EventArgs e)
        {
            daoForo = new ForoWSClient();
            daoSubforo = new SubforoWSClient();
            daoHilo = new HiloWSClient();
            daoMensaje = new MensajeWSClient();
            daoForoUsuario = new ForoUsuarioWSClient();

            foro[] aux = daoForo.listarForos();
            if(aux != null) foros = new BindingList<foro>(aux);
            //BindingList<Foro> foros = new BindingList<Foro>();
            //Foro proof = new Foro(1, "PRUEBAAA", "Este es un foro", "GianLukaGG", "https://avatars.akamai.steamstatic.com/f698ccb1d89632d7f174c142b789b84d4ec2dab6_full.jpg");
            //foros.Add(proof);
            gvForos.DataSource = foros;
            gvForos.DataBind();
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
            string nombreForo = "pruebita";
            //int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            //Foro foro = areas.SingleOrDefault(x => x.IdArea == idArea);
            //Session["objeto"]=foro
            Response.Redirect("GestionarForo.aspx?foro="+nombreForo);
        }

        protected void lbActualizarInfoForo_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-edicion') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbEliminarForo_Click(object sender, EventArgs e)
        {

        }

        protected void btnGuardarForoModal_Click(object sender, EventArgs e)
        {
            int id;
            foro neoforo = new foro();
            subforo neosubforo = new subforo();
            usuario user = (usuario)Session["usuario"];
            hilo neohilo = new hilo();
            mensaje neomensaje = new mensaje();
            if (user == null) return;
            neoforo.nombre = txtTema.Text;
            neoforo.descripcion = txtDescripcion.Text;
            neoforo.origen = origenForo.USUARIO;
            neoforo.nombreCreador = user.nombrePerfil.ToString();
            id = daoForo.insertarForo(neoforo);
            daoForoUsuario.crearRelacion(id, user.UID);
            neoforo.idForo = id;
            neosubforo.foro = neoforo;
            neosubforo.nombre = txtInicial.Text;
            id = daoSubforo.insertarSubforo(neosubforo);
            neosubforo.idSubforo = id;
            neohilo.fechaCreacion = DateTime.Now;
            neohilo.idCreador = user.UID;
            neohilo.subforo = neosubforo;
            neohilo.fechaModificacion = DateTime.Now;
            neohilo.fijado = true;
            id = daoHilo.insertarHilo(neohilo);
            neohilo.idHilo = id;
            neomensaje.hilo = neohilo;
            neomensaje.fechaPublicacion = DateTime.Now;
            neomensaje.idAutor = user.UID;
            neomensaje.contenido = txtMensajeInicial.Text;
            id = daoMensaje.insertarMensaje(neomensaje);
            Response.Redirect("Comunidad.aspx");
        }
    }
}