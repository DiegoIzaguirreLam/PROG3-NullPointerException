<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="GestionarCartera.aspx.cs" Inherits="SteamWA.GestionarCartera" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .bg-gradient-gray {
            background: linear-gradient(to right, rgba(128,128,128,0.5), rgba(192,192,192,0.9)); /* Más gris a más plata */
            color: #fff; /* Texto en color blanco */
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <h1 class="mt-4 mb-4">Cartera</h1>
        <h2 id="hCartera" runat="server" class="mb-3">Agregar fondos a la cartera de 'Usuario'</h2>
        <p class="mb-4">Los fondos en su cartera de Stream pueden ser usados para comprar cualquiera de los productos que puede encontrar en la tienda.
            <br /> Vas a tener la oportunidad de revisar tu orden antes de que sea colocada.</p>
        
        <div class="row">
            <!-- Columna de recuadros de montos -->
            <div class="col-md-6">
                <div class="mb-4 bg-gradient-gray p-3 rounded position-relative">
                    <h3 id="hAgregar15" runat="server" class="text-light mb-3">Agregar S/.15.00</h3>
                    <div class="d-flex justify-content-between">
                        <p>Monto mínimo permitido por STREAM</p>
                        <asp:LinkButton ID="btnAgregar15" runat="server" Text="Agregar fondos" CssClass="btn btn-success ms-2" OnClick="btnAgregar_Click" CommandArgument="15.00"/>
                    </div>
                </div>
                <div class="mb-4 bg-gradient-gray p-3 rounded position-relative">
                    <h3 id="hAgregar30" runat="server" class="text-light mb-3">Agregar S/.30.00</h3>
                    <div class="d-flex justify-content-end">
                        <asp:LinkButton ID="btnAgregar30" runat="server" Text="Agregar fondos" CssClass="btn btn-success ms-2" OnClick="btnAgregar_Click" CommandArgument="30.00"/>
                    </div>
                </div>
                <div class="mb-4 bg-gradient-gray p-3 rounded position-relative">
                    <h3 id="hAgregar50" runat="server" class="text-light mb-3">Agregar S/.50.00</h3>
                    <div class="d-flex justify-content-end">
                        <asp:LinkButton ID="btnAgregar50" runat="server" Text="Agregar fondos" CssClass="btn btn-success ms-2" OnClick="btnAgregar_Click" CommandArgument="50.00"/>
                    </div>
                </div>
                <div class="mb-4 bg-gradient-gray p-3 rounded position-relative">
                    <h3 id="hAgregar100" runat="server" class="text-light mb-3">Agregar S/.100.00</h3>
                    <div class="d-flex justify-content-end">
                        <asp:LinkButton ID="btnAgregar100" runat="server" Text="Agregar fondos" CssClass="btn btn-success ms-2" OnClick="btnAgregar_Click" CommandArgument="100.00"/>
                    </div>
                </div>
                <div class="mb-4 bg-gradient-gray p-3 rounded position-relative">
                    <h3 id="hAgregarPersonalizado" runat="server" class="text-light mb-3">Agregar monto personalizado</h3>
                    <div class="d-flex d-inline-block">
                        <asp:Label ID="txtMonedaPersonalizado" runat="server" CssClass="text-white mt-2" Visible="true"></asp:Label>
                        <asp:TextBox ID="txtMontoPersonalizado" runat="server" CssClass="form-control bg-dark ms-2 text-white" Placeholder="Ingrese el monto" width="100" />
                    </div>
                    <div class="d-flex justify-content-end">
                        <asp:LinkButton ID="btnAgregarPersonalizado" runat="server" Text="Agregar fondos" CssClass="btn btn-success ms-2" OnClick="btnAgregarPersonalizado_Click"/>
                    </div>
                    <asp:Label ID="lblMensajeError" runat="server" CssClass="alert alert-danger mt-4" Visible="false" Width="100% "></asp:Label>
                </div>
            </div>

            <!-- Columna del balance actual -->
            <div class="col-md-6">
                <div class="mb-4">
                    <h4>Balance actual en cartera</h4>
                    <p id="pBalanceCartera" runat="server" class="display-4">S/.-</p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>



