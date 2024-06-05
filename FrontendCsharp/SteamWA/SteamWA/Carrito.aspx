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
            
             <div class="col" >
                 <div class="card bg-dark text-light  border-shadow mb-4">
                 
                    <div class="card-body">
                        <h5 id="labelTotalCarrito" runat="server" class="card-title">Total estimado: S/.0.00</h5>
                        
                        <asp:HiddenField ID="valorTotal" runat="server" Value="0"/>
                         <asp:LinkButton ID="btmComprar" CssClass="btn btn-primary" 
                             runat="server" OnClick="btmComprar_Click">Comprar todo</asp:LinkButton>
                        <asp:Label ID="LabelFaltaFondos" CssClass="pt-1" runat="server" Text="Fondos insuficientes para realizar la operación" style="display: none; color: limegreen;" ></asp:Label>
                    </div>
                     
                    
                </div>
             </div>

         </div>
         <hr />
           <asp:PlaceHolder ID="placeholderProductosCarrito" runat="server"></asp:PlaceHolder>
       </div>  
</asp:Content>
