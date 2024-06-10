<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="SeleccionarMetodoPago.aspx.cs" Inherits="SteamWA.AgregarFondos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <style>
        .container-gradient {
            border-top: 1px solid;
            border-image-slice: 1;
            border-width: 1px;
            border-image-source: linear-gradient(90deg, #24282f 0%, #ffffff 45%, #ffffff 55%, #24282f 100%);
            background-image: linear-gradient(#364458, #24282f);
        }

        .bgDesplegables {
            background-color: #392e47;
        }
    </style>
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a class="text-decoration-none text-white bg-transparent border-0" href="GestionarCartera.aspx">Cartera     <i class="fa-solid fa-caret-right"></i></a></li>
                <li class="breadcrumb-item text-decoration-none text-white fw-bold active" aria-current="page">Método de Pago</li>
            </ol>
        </nav>
        <h1 class="mt-4 mb-4">Seleccionar método de pago</h1>
        <div class="rounded-3 p-4 container-gradient">
            <!-- Selección de método de pago -->
            <div class="mb-4">
                <div class="dropdown d-flex d-inline-block justify-content-between">
                    <p>Por favor seleccione un método de pago</p>
                    <button class="btn bg-navy btn-outline-light dropdown-toggle" type="button" id="dropdownMetodo"
                        runat="server" data-bs-toggle="dropdown" aria-expanded="false">
                    </button>
                    <ul class="dropdown-menu bgDesplegables" aria-labelledby="dropdownMetodosPago">
                        <li>
                            <asp:LinkButton ID="btnGiftCard" runat="server" Text="Gift Card" CssClass="btn ps-2 text-white" OnClick="btnGiftCard_Click" />
                        </li>
                        <%--<li>
                            <asp:LinkButton ID="btnPaypal" runat="server" Text="PayPal" CssClass="btn ps-2 text-white" OnClick="btnPaypal_Click" />
                        </li>
                        <li>
                            <asp:LinkButton ID="btnTarjeta" runat="server" Text="Tarjeta" CssClass="btn ps-2 text-white" OnClick="btnTarjeta_Click" />
                        </li>--%>
                    </ul>
                </div>
            </div>
            <!-- Monto a pagar -->
            <div class="mb-4 d-flex justify-content-between">
                <asp:Label ID="lblMontoTxt" runat="server" Text="Monto a pagar: " />
                <asp:Label ID="lblMontoNumero" runat="server" Text="" />
            </div>
            <hr />
            <p id="pNoSoportado" class="text-warning" runat="server">Este método de pago aún no se encuentra soportado por Stream</p>
            <!-- Botones de pago -->
            <div id="divBotonesPago" class="mb-4 d-flex justify-content-end">
                <asp:LinkButton ID="btnPagar" CssClass="btn btn-primary btn-success" runat="server" Text="Pagar" Visible="false" OnClick="btnPagar_Click" />
            </div>

        </div>
    </div>
</asp:Content>
