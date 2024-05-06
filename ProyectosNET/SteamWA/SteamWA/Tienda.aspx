<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Tienda.aspx.cs" Inherits="SteamWA.Tienda" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <h1 class="mt-4">Catálogo de Productos</h1>
        <!-- Barra de búsqueda -->
        <div class="input-group mb-3 search-bar" >
            
            <input type="search" class="form-control" placeholder="Buscar programas...">
            
            <button type="submit" class="btn btn-primary input-group-text rounded-right " >
                <i class="fas fa-search"></i>
            </button>
                  
        </div>
        <hr />
        <div class="row mt-4">
            <!-- tarjeta 1 -->
            <div class="col-md-4">
                <div class="card bg-dark-subtle">
                    <img src="Images/portada_juego1.jpg" height="200" class="card-img-top" alt="Juego 1">
                    <div class="card-body">
                        <h5 class="card-title">Nombre del Programa 1</h5>
                        <p class="card-text">Descripción breve del Programa 1.</p>
                        <p class="card-text">Precio: $10.99</p>
                        <a href="#" class="btn btn-primary">Añadir al Carrito</a>
                    </div>
                </div>
            </div>
            <!-- tarjeta 2-->
            <div class="col-md-4">
                <div class="card bg-dark-subtle">
                    <img src="Images/portada_juego2.jpg" height="200" class="card-img-top" alt="Juego 2">
                    <div class="card-body">
                        <h5 class="card-title">Nombre del Programa 2</h5>
                        <p class="card-text">Descripción breve del Programa 2.</p>
                        <p class="card-text">Precio: $5.99</p>
                        <a href="#" class="btn btn-primary">Añadir al Carrito</a>
                    </div>
                </div>
            </div>
            <!-- tarjeta 3-->
            <div class="col-md-4">
                <div class="card bg-dark-subtle">
                    <img src="Images/portada_juego3.jpg" height="200" class="card-img-top" alt="Juego 3">
                    <div class="card-body">
                        <h5 class="card-title">Nombre del Programa 3</h5>
                        <p class="card-text">Descripción breve del Programa 3.</p>
                        <p class="card-text">Precio: $17.99</p>
                        <a href="#" class="btn btn-primary">Añadir al Carrito</a>
                    </div>
                </div>
            </div>
            <!-- mas tarjetas -->
        </div>
    </div>
</asp:Content>
