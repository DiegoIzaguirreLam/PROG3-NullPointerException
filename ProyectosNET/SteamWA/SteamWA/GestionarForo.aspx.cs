﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class GestionarForo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindingList<Subforo> subforos = new BindingList<Subforo>();
            Subforo proff = new Subforo(1, "Batman goood!", "El mejor super de todos!");
            subforos.Add(proff);
            gvSubforos.DataSource = subforos;
            gvSubforos.DataBind();
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

        protected void btnCrearSubforo_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-subforo') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbAbrirSubforo_Click(object sender, EventArgs e)
        {                        
            string nombreForo = "pruebitaSubforo"; //Al crear foro analizará que permita máximo 15 caracteres para el nombre
            //int idForo = Int32.Parse(((LinkButton)sender).CommandArgument);
            //Foro foro = areas.SingleOrDefault(x => x.IdArea == idArea);
            //Session["objeto"]=foro
            Session["foro_nombre"] = foro.Text; //Por ahora manda un String
            Response.Redirect("GestionarSubforo.aspx?subforo=" + nombreForo);
        }

        protected void lbActualizarSubforo_Click(object sender, EventArgs e)
        {
            string script = "window.onload = function() { showModalForm('form-modal-actualizar') };";
            ClientScript.RegisterStartupScript(GetType(), "", script, true);
        }

        protected void lbEliminarSubforo_Click(object sender, EventArgs e)
        {

        }
    }
}