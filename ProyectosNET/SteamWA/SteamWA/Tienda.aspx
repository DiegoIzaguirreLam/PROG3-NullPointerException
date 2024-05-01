<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Tienda.aspx.cs" Inherits="SteamWA.Tienda" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <h1 class="mt-4">Catálogo de Videojuegos</h1>
        <hr />
        <div class="row mt-4">
            <!-- Tarjeta de juego 1 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="Images/portada_juego1.jpg" height="200" class="card-img-top" alt="Juego 1">
                    <div class="card-body">
                        <h5 class="card-title">Nombre del Programa 1</h5>
                        <p class="card-text">Descripción breve del Programa 1.</p>
                        <p class="card-text">Precio: $10.99</p>
                        <a href="#" class="btn btn-primary">Añadir al Carrito</a>
                    </div>
                </div>
            </div>
            <!-- Tarjeta de juego 2 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="Images/portada_juego2.jpg" height="200" class="card-img-top" alt="Juego 2">
                    <div class="card-body">
                        <h5 class="card-title">Nombre del Programa 2</h5>
                        <p class="card-text">Descripción breve del Programa 2.</p>
                        <p class="card-text">Precio: $5.99</p>
                        <a href="#" class="btn btn-primary">Añadir al Carrito</a>
                    </div>
                </div>
            </div>
            <!-- Agrega más tarjetas según sea necesario -->
        </div>
    </div>
</asp:Content>
