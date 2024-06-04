<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="AgregarFondos.aspx.cs" Inherits="SteamWA.AgregarFondos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <style>
        .bgDesplegables {
            background-color: #392e47;
        }
    </style>
    <div class="container">
        <div class="container">
            <h1 class="mt-4 mb-4">Método de pago</h1>
            <div class="bg-navy-50 p-4 rounded">
                <!-- Selección de método de pago -->
                <div class="mb-4">
                    <div class="dropdown d-flex d-inline-block justify-content-between">
                        <p>Por favor seleccione un método de pago</p>
                        <button class="btn bg-navy btn-outline-light dropdown-toggle" type="button" id="dropdownMetodo"
                            runat="server" data-bs-toggle="dropdown" aria-expanded="false">
                        </button>
                        <ul class="dropdown-menu bgDesplegables" aria-labelledby="dropdownMetodosPago">
                            <li>
                                <asp:LinkButton id="btnGiftCard" runat="server" Text="Gift Card" CssClass="btn ps-2 text-white" OnClick="btnGiftCard_Click" />
                            </li>
                            <li>
                                <asp:LinkButton id="btnPaypal" runat="server" Text="PayPal" CssClass="btn ps-2 text-white" OnClick="btnPaypal_Click" />
                            </li>
                            <li>
                                <asp:LinkButton id="btnTarjeta" runat="server" Text="Tarjeta" CssClass="btn ps-2 text-white" OnClick="btnTarjeta_Click" />
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- Monto a pagar -->
                <div class="mb-4 d-flex justify-content-between">
                    <asp:Label id="lblMontoTxt" runat="server" Text="Monto a pagar: "/>
                    <asp:Label id="lblMontoNumero" runat="server" Text=""/>
                </div>
                <hr />
                <p id="pNoSoportado" runat="server">Este método de pago aún no es soportado por Stream</p>
                <!-- Botones de pago -->
                <div id="divBotonesPago" class="mb-4 d-flex justify-content-end">
                    <asp:LinkButton ID="btnPagar" CssClass="btn btn-primary btn-success" runat="server" Text="Pagar" Visible="false" OnClick="btnPagar_Click" />
                </div>

            </div>
        </div>
    </div>
</asp:Content>
