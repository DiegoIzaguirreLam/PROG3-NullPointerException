﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="GestionarSubforo.aspx.cs" Inherits="SteamWA.GestionarSubforo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/crearForo.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <h1 class="mt-4">Comunidad</h1>
    </div>
    <div class="container fontSetterExo2">
        <div class="row align-items-center">
            <div class="col-md-7 row align-items-center">
                <div class="col-md-auto align-items-lg-start">
                    <asp:Button ID="return" CssClass="h5 bg-transparent border-0" runat="server" Text="Comunidad" OnClick="btnVolverComunidad_Click" />
                    <i class="fa-solid fa-caret-right fa-1x" style="color: #ffffff;"></i>
                </div>
                <div class="col-md-auto align-items-lg-start">
                    <asp:Button ID="nombreForo" CssClass="h5 bg-transparent border-0" runat="server" Text="Comunidad" OnClick="btnVolverForo_Click" />
                    <i class="fa-solid fa-caret-right fa-1x" style="color: #ffffff;"></i>
                </div>
                <div class="col-md-auto justify-content-md-start">
                    <asp:Button ID="subforo" CssClass="h5 bg-transparent border-0" runat="server" Text="Comunidad" OnClick="btnActualizarSubforo_Click"/>
                </div>
            </div>
            <div class="col text-end">
                <asp:Button ID="btnCrearForo" CssClass="btn btn-dark col-sm-4 border-light" runat="server" Text="Crear Hilo" OnClick="btnCrearHilo_Click" />
            </div>
        </div>
    </div>
    <hr />
    <div class="container row fontSetterExo2">
        <asp:GridView ID="foros" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-responsive table-striped">
            <Columns>
                <asp:BoundField HeaderText="Nombre" DataField="nombre" />
                <%--Se mostrará el primer mensaje del hilo fijado en el foro--%>
                <asp:BoundField HeaderText="Mensaje" DataField="mensaje" />
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <div class="row mt-4 fontSetterExo2">
        <div class="rounded-3">
            <div class="px-3">
                <div class="row mt-3 pb-4">
                    <asp:ListView ID="lvHilos" runat="server" ItemPlaceholderID="itemPlaceholder">
                        <ItemTemplate>
                            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                            <div class="card bg-dark-subtle border-black">
                                <img src="<%# Eval("URLImagen") %>" height="200" class="card-img-top" alt="Juego 1">
                                <div class="card-body bg-dark">
                                    <h6 class="card-title" style="color: white"><%# Eval("NombreUsuario") %> </h6>
                                    <asp:LinkButton ID="btn2" CssClass="btn btn-light border-light fontSetterExo2" runat="server" Text="Abrir Hilo" OnClick="btnAbrirHilo_Click" CommandArgument='<%# Eval("idHilo")%>'/>
                                </div>
                            </div>
                                </div>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <div class="d-flex justify-content-center align-items-center mt-3">
                                <asp:Label runat="server" Text="Este subforo aún no tiene hilos." CssClass="display-7 text-center" />
                            </div>
                        </EmptyDataTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
    </div>
    <%--Clase modal para la creación de un Hilo--%>
    <div class="modal border-white fade fontSetterExo2" id="form-modal-hilo">
        <div class="modal-dialog">
            <div class="modal-content bg-secondary bg-opacity-50">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title border-white">Creador de Hilos</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content">
                    <div class="container bg-dark">
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblMensajeInicial" runat="server" Text="Mensaje:" CssClass="col-sm-3 col-form-label mt-1" />
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtMensajeInicial" runat="server" CssClass="form-control mt-1" Height="150" />
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="col-md-5">
                                <asp:Button ID="btnImagen" runat="server" Text="Imagen"
                                    CssClass="justify-content-md-start btn btn-secondary bg-dark mb-2" />
                            </div>
                            <div class="col-md-7 d-grid gap-2 d-md-flex justify-content-md-end">
                                <asp:Button ID="btnGuardar" runat="server" Text="Crear"
                                    CssClass="float-end btn btn-secondary bg-dark mb-2" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--Clase modal para la lectura y edición de un Hilo--%>
    <div class="modal border-white fade fontSetterExo2" id="form-modal-hilo-lector">
        <div class="modal-dialog">
            <div class="modal-content bg-secondary bg-opacity-50">
                <div class="modal-header bg-dark">
                    <h6 class="modal-title border-white col-8">¿Es un buen juego? - GianLukaGG</h6>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content">
                    <div class="container bg-dark">
                        <div class="container row">
                            <div class="col-md-7">
                                <p class="mt-3">El mejor juego!</p>
                            </div>
                            <div class="col-md-5 text-end">
                                <p class="mt-3">
                                    - Sr. Tomasto
                                     <img src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/items/408410/0538306fa1cafff1035d125ebbe745f1f9ce2236.gif" width="20" height="20" />
                                </p>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="col-md-7">
                                <p class="mt-3">Es muy god!</p>
                            </div>
                            <div class="col-md-5 text-end">
                                <p class="mt-3">
                                    - Princesa Loopy
                                    <img src="Images/loopy.jpg" width="20" height="20" />
                                </p>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="col-md-7">
                                <p class="mt-3">El peor juego!</p>
                            </div>
                            <div class="col-md-5 text-end">
                                <p class="mt-3">
                                    - Sr. Tomasto Nojao
                                    <img src="Images/Captura%20de%20pantalla%202024-05-07%20185034.png" width="20" height="20" />
                                </p>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="col-md-7">
                                <p class="mt-3">El mejor mejor juego!</p>
                            </div>
                            <div class="col-md-5 text-end">
                                <p class="mt-3">
                                    - Sr. Tomasto Feli
                                    <img src="Images/Captura%20de%20pantalla%202024-05-07%20185011.png" width="20" height="20" />
                                </p>
                            </div>
                        </div>
                        <div class="container row">
                            <asp:TextBox runat="server" CssClass="col-12 mb-3 rounded"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
