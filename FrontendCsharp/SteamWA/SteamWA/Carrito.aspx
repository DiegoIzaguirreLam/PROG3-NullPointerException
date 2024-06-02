<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Carrito.aspx.cs" Inherits="SteamWA.Carrito" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
   
     <div class="container">
        <h1 class="mt-4">Tu carro de compra</h1>
         <hr />
         <div class="row">
             <div class="col">
                 <div class="card bg-dark text-light  border-shadow mb-4">
                    
                    <div class="card-body">
                        <h5 class="card-title">Nombre del Programa 2</h5>
                        <p class="card-text">Descripción breve del Programa 2.</p>
                        <p class="card-text">Precio: $17.99</p>
                        <a href="#" class="btn btn-danger">Eliminar</a>
                    </div>
                </div>
             </div>
             <div class="col" >
                 <div class="card bg-dark text-light  border-shadow mb-4">
                 
                    <div class="card-body">
                        <h5 class="card-title">Total estimado $77.69</h5>
                        
                      
                         <asp:LinkButton ID="btmComprar" CssClass="btn btn-primary" 
                             runat="server" OnClick="btmComprar_Click">Comprar todo</asp:LinkButton>
                    </div>
                    
                </div>
             </div>

         </div>
         <div class="row">
             <div class="col">
                 <div class="card bg-dark text-light  border-shadow mb-4">
                   
                    <div class="card-body">
                        <h5 class="card-title">Nombre del Programa 3</h5>
                        <p class="card-text">Descripción breve del Programa 3.</p>
                        <p class="card-text">Precio: $17.99</p>
                        <a href="#" class="btn btn-danger">Eliminar</a>
                    </div>
                </div>
             </div>
             <div class="col" ></div>

         </div>
         <div class="row">
             <div class=" col">
                
                 <div class="card bg-dark text-light border-shadow mb-4">
                  
                    <div class="card-body">
                        <h5 class="card-title">Nombre del Programa 3</h5>
                        <p class="card-text">Descripción breve del Programa 3.</p>
                        <p class="card-text">Precio: $17.99</p>
                        <a href="#" class="btn btn-danger">Eliminar</a>
                    </div>
                </div>
             
             </div>
             <div class="col" ></div>

         </div>
        </div>
</asp:Content>
