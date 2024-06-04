﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
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
        int[] pageIndex;

        protected void Page_Load(object sender, EventArgs e)
        {
            daoForo = new ForoWSClient();
            daoSubforo = new SubforoWSClient();
            daoHilo = new HiloWSClient();
            daoMensaje = new MensajeWSClient();
            daoForoUsuario = new ForoUsuarioWSClient();

            pageIndex = (int[])Session["IndexPages"];
            if (pageIndex == null)
            {
                pageIndex = new int[3];
                Session["IndexPages"] = pageIndex;
            }
            if (!IsPostBack)
            {
                foro[] aux = daoForo.listarForos();
                if (aux != null) foros = new BindingList<foro>(aux);
                gvForos.DataSource = foros;
                gvForos.DataBind();
                Session["forosAux"] = foros;
            }
            
            Steam master = (Steam)this.Master;
            master.ItemComunidad.Attributes["class"] = "active";
            //ComunidadWS.ComunidadWSClient a = new ComunidadWS.ComunidadWSClient();
            //a.hello("a");
        }

        protected void btnActualizarComunidad_Click(object sender, EventArgs e)
        {
            //Response.Redirect("Comunidad.aspx");
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
            foros = (BindingList<foro>)Session["forosAux"];
            int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            foro foro = foros.SingleOrDefault(x => x.idForo == idForo);
            daoForoUsuario.eliminarRelacion(foro.idForo, foro.idCreador);
            if (daoForo.eliminarForo(foro) != 0) Response.Redirect("Comunidad.aspx");
        }

        protected void lbDesuscribir_Click(object sender, EventArgs e)
        {
            foros = (BindingList<foro>)Session["forosAux"];
            usuario user = (usuario)Session["usuario"];
            int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            foro foro = foros.SingleOrDefault(x => x.idForo == idForo);
            if (daoForoUsuario.desuscribirRelacion(foro.idForo, user.UID) != 0) Response.Redirect("Comunidad.aspx");
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
            }
        }

        protected void btnActualizarForo_Click(object sender, EventArgs e)
        {
            foro actforo = (foro)Session["foroParaActualizar"];
            actforo.nombre = txtNTema.Text;
            actforo.descripcion = txtNDescripcion.Text;
            daoForo.editarForo(actforo);
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
            if (user == null) return;
            neoforo.nombre = txtTema.Text;
            neoforo.descripcion = txtDescripcion.Text;
            neoforo.origen = origenForo.USUARIO;
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

        protected void txtBusquedaForo_TextChanged(object sender, EventArgs e)
        {
            foro[] aux = daoForo.buscarForos(txtBusquedaForo.Text);
            if (aux != null) foros = new BindingList<foro>(aux);
            gvForos.DataSource = foros;
            gvForos.DataBind();
        }

        protected void btnSuscritos_Click(object sender, EventArgs e)
        {
            usuario user = (usuario)Session["usuario"];
            foro[] aux = daoForo.listarForosSuscritos(user.UID);
            if (aux != null) creados = new BindingList<foro>(aux);
            gvSuscritos.DataSource = creados;
            gvSuscritos.DataBind();
            Session["ForosSuscritos"] = suscritos;
            string script = "window.onload = function() { showModalForm('form-modal-suscritos') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void btnCreados_Click(object sender, EventArgs e)
        {
            usuario user = (usuario)Session["usuario"];
            foro[] aux = daoForo.listarCreados(user.UID);
            if (aux != null) creados = new BindingList<foro>(aux);
            gvCreados.DataSource = creados;
            gvCreados.DataBind();
            Session["ForosCreados"] = creados;
            string script = "window.onload = function() { showModalForm('form-modal-creados') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void gvForos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvForos.DataSource = (BindingList<foro>)Session["forosAux"];
            gvForos.PageIndex = e.NewPageIndex;
            pageIndex[0] = e.NewPageIndex;
            Session["IndexPages"] = pageIndex;
            gvForos.DataBind();
        }

        protected void gvCreados_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCreados.DataSource = (BindingList<foro>)Session["ForosCreados"];
            gvCreados.PageIndex = e.NewPageIndex;
            pageIndex[1] = e.NewPageIndex;
            Session["IndexPages"] = pageIndex;
            gvCreados.DataBind();
        }

        protected void gvSuscritos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSuscritos.DataSource = (BindingList<foro>)Session["ForosSuscritos"];
            gvSuscritos.PageIndex = e.NewPageIndex;
            pageIndex[2] = e.NewPageIndex;
            Session["IndexPages"] = pageIndex;
            gvSuscritos.DataBind();
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

        
    }
}