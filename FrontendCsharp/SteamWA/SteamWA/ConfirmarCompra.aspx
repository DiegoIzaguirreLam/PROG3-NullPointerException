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
                <li class="breadcrumb-item"><a class="text-decoration-none text-white bg-transparent border-0" href="GestionarCartera.aspx">Cartera     <i class="fa-solid fa-caret-right"></i></a></li>
                <li class="breadcrumb-item"><a class="text-decoration-none text-white bg-transparent border-0" href="SeleccionarMetodoPago.aspx">Método de Pago     <i class="fa-solid fa-caret-right"></i></a></li>
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
                            <label class="form-check-label" for="chkTerminosCondiciones">Acepto los <a href="#" id="lnkTerminosCondiciones" runat="server" class="text-white">términos y condiciones</a></label>
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
                        <p id="txtFondosModal" runat="server"> </p>
                    </div>
                    <div class="modal-footer">
                        <button id="btnAceptarModal" runat="server" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Aceptar</button>
                        <asp:LinkButton ID="lbContinuarATienda" CssClass="btn btn-primary btn-success" runat="server" Text="Seguir Comprando" OnClick="lbContinuarATienda_OnClick" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal border-white fade fontSetterExo2" id="form-modal-terminos">
        <div class="modal-dialog modal-xl">
            <div class="modal-content bg-secondary bg-opacity-50">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title border-white align-content-center">Términos y Condiciones para Agregar Fondos a la Cartera en STREAM</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content">
                    <div class="container bg-dark">
                        <p>Bienvenido(a) a STREAM, la plataforma de compra de productos en línea. Antes de proceder a agregar fondos a tu cartera en STREAM, te solicitamos que leas y comprendas detenidamente los siguientes términos y condiciones:</p>
                        <ol>
                            <li><strong>Créditos de la Cartera:</strong> Al agregar fondos a tu cartera en STREAM, se te otorgarán créditos equivalentes al monto depositado. Estos créditos serán utilizados exclusivamente para realizar compras dentro de la plataforma STREAM.</li>
                            <li><strong>No Retirables:</strong> Los fondos agregados a tu cartera en STREAM no son retirables. Una vez que se haya realizado la transacción y los fondos se hayan acreditado en tu cartera, no podrán ser reembolsados ni transferidos a otra cuenta o método de pago.</li>
                            <li><strong>Uso Exclusivo en STREAM:</strong> Los créditos de la cartera en STREAM solo pueden ser utilizados para realizar compras dentro de la plataforma STREAM. No pueden ser canjeados por dinero en efectivo ni utilizados en otras plataformas de compra en línea.</li>
                            <li><strong>Descontados en Compras:</strong> Cada vez que realices una compra en STREAM, se descontará automáticamente el monto correspondiente de tu saldo de crédito en la cartera. Es tu responsabilidad asegurarte de tener suficientes créditos disponibles para completar la transacción.</li>
                            <li><strong>Métodos de Pago:</strong> En un futuro, STREAM podrá habilitar métodos de pago adicionales, como tarjetas de crédito, PayPal, entre otros. Sin embargo, el dinero depositado a través de estos métodos tampoco será retirable una vez que esté en tu cartera en STREAM.</li>
                            <li><strong>Política de Reembolso:</strong> Todos los pagos realizados en STREAM son finales y no son reembolsables, a menos que se indique lo contrario según nuestras políticas de reembolso. Te recomendamos revisar nuestras políticas de reembolso antes de realizar cualquier compra.</li>
                        </ol>
                        <p>Al agregar fondos a tu cartera en STREAM, aceptas y te comprometes a cumplir con estos términos y condiciones.</p>
                        <p>Gracias por ser parte de STREAM.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
