<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="ConfirmarCompra.aspx.cs" Inherits="SteamWA.ConfirmarCompra" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/ConfirmarCompra.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a class="text-decoration-none text-white bg-transparent border-0" href="GestionarCartera.aspx">Cartera  <i class="fa-solid fa-caret-right"></i></a></li>
                <li class="breadcrumb-item"><a class="text-decoration-none text-white bg-transparent border-0" href="AgregarFondos.aspx">Método de Pago  <i class="fa-solid fa-caret-right"></i></a></li>
                <li class="breadcrumb-item text-decoration-none text-white fw-bold active" aria-current="page">Confirmar Compra</li>
            </ol>
        </nav>
        <div class="row">
            <!-- Parte izquierda -->
            <div class="col-md-6">
                <!-- Recuadro de boleta de pago -->
                <div class="card mb-4 bg-dark text-white">
                    <div class="card-body">
                        <h5 class="card-title">Detalle de la compra</h5>
                        <!-- Detalle de la compra -->
                        <!-- Puedes insertar aquí los detalles de la compra -->
                        <div class="d-flex justify-content-between">
                            <p>Monto a ser agregado a su cartera: </p>
                            <p id="pMonto" runat="server"></p>
                        </div>
                        <!-- Línea horizontal -->
                        <hr />
                        <!-- Total -->
                        <div class="d-flex justify-content-between">
                            <p>Total: </p>
                            <p id="pTotal" runat="server" class="fw-bold">$10.00</p>
                        </div>
                    </div>
                </div>
                <!-- Recuadro de método de pago -->
                <div class="card mb-4 bg-dark text-white">
                    <div class="card-body">
                        <h5 class="card-title">Información de la transacción</h5>
                        <div class="d-flex d-inline-block">
                            <p id="pMetodoPago" runat="server">Método de pago: GiftCard</p>
                            <asp:LinkButton ID="lbCambiar" runat="server" class="text-decoration-underline text-white px-1" Text="(Cambiar)" OnClick="lbCambiar_Click" />
                        </div>
                        <p id="pCuenta" runat="server"></p>
                        <!-- Línea horizontal -->
                        <hr />
                        <!-- Términos y condiciones -->
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="chkTerminosCondiciones" runat="server" />
                            <label class="form-check-label" for="chkTerminosCondiciones">Acepto los términos y condiciones</label>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Parte derecha -->
            <div class="col-md-6">
                <!-- Recuadro de información de la compra -->
                <div class="card mb-4 bg-dark text-white">
                    <div class="card-body">
                        <h5 class="card-title">Comprando en STREAM</h5>
                        <p class="card-text">Una vez complete esta transacción, su método de pago escogido será debitado y recibirá un mensaje confirmando el recibo de su compra</p>
                        <asp:LinkButton ID="btnPagar" runat="server" CssClass="btn btn-success" Text="Pagar" OnClick="btnPagar_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="form-modal-FondosAgregados" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblFondos">Agregar Fondos</h5>
                    </div>
                    <div class="modal-body">
                        <p id="txtFondosModal" runat="server">Prueba aasdfasf </p>
                    </div>
                    <div class="modal-footer">
                        <button id="btnAceptarModal" runat="server" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Aceptar</button>
                        <asp:LinkButton ID="lbContinuarATienda" CssClass="btn btn-primary btn-success" runat="server" Text="Seguir Comprando" OnClick="lbContinuarATienda_OnClick" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
