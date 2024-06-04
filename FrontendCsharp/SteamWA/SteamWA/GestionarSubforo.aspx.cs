﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SteamWA
{
    public partial class GestionarSubforo : System.Web.UI.Page
    {
        string padre;
        protected void Page_Load(object sender, EventArgs e)
        {
            string nombre = Request.QueryString["subforo"];
            padre = Session["foro_nombre"].ToString();
            if (nombre != null)
            {
                subforo.Text = nombre;
            }
            if(padre != null)
            {
                nombreForo.Text = padre;
            }
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
            Response.Redirect("GestionarForo.aspx?foro=" + padre);
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