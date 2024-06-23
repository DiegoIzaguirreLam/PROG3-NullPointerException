<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="GestionarSubforo.aspx.cs" Inherits="SteamWA.GestionarSubforo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/crearForo.js"></script>
    <link href="Content/Steam/Comunidad.css" rel="stylesheet" />
    <script src="Scripts/Steam/Comunidad.js?v4"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <div class="container">
        <h1 class="mt-4">Comunidad</h1>
    </div>
    <div class="container fontSetterExo2">
        <div class="row align-items-center">
            <div class="col-md-9 row align-items-center">
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
                <asp:Button ID="btnCrearHilo" CssClass="btn btn-dark col-sm-4 border-light" runat="server" Text="Crear Hilo" OnClick="btnCrearHilo_Click" />
            </div>
        </div>
    </div>
    <hr />
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
                                    <h6 class="card-title" style="color: white"><%# Eval("NombreUsuario") %> -  
                                    <img src="<%# Eval("FotoPerfil") %>" width="20" height="20" /></h6>
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
                                <asp:Label ID="lblMensajeInicial" runat="server" Text="Mensaje:" CssClass="col-sm-3 col-form-label mt-1" /><sup style="color:red">*</sup>
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtMensajeInicial" runat="server" CssClass="form-control mt-1" MaxLength="40" />
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="col-md-5">
                                <asp:FileUpload ID="fileUpdloadFotoHilo" runat="server" 
                                        CssClass="form-control mb-2"/>
                            </div>
                            <div class="col-md-7 d-grid gap-2 d-md-flex justify-content-md-end">
                                <asp:Button ID="btnGuardar" runat="server" Text="Crear"
                                    CssClass="float-end btn btn-secondary bg-dark mb-2" OnClick="btnGuardar_Click" />
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
                    <h6>
                        <asp:Label runat="server" ID="lblTitulo"></asp:Label></h6>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content">
                    <div class="container bg-dark">
                        <asp:UpdatePanel runat="server" UpdateMode="Always" >
                            <ContentTemplate>
                                <div class="liste" style="height:500px; overflow:auto;">
                                    <asp:ListView ID="lvMensajes" runat="server">
                                        <ItemTemplate>
                                            <div class="listview-item border-dark">
                                                <div class="container row">
                                                    <div class="col-md-7 text-start">
                                                        <p class="mt-3"><%# Eval("Contenido") %></p>
                                                    </div>
                                                    <div class="col-md-5 text-end">
                                                        <p class="mt-3">
                                                            - <%# Eval("Creador") %>
                                                            <img src="<%# Eval("URLImagen") %>" width="20" height="20" />
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <EmptyDataTemplate><p class="align-middle">Aún no hay respuestas:(</p></EmptyDataTemplate>
                                    </asp:ListView>
                                  </div>
                                <div class="container row">
                                    <asp:TextBox runat="server" ID="txtCrearMensaje" CssClass="col-11 mb-3 rounded mt-2" MaxLength="40" onkeydown="enviarMensaje_js(event, 'cphContenido_btnEnviarMensaje')"></asp:TextBox>
                                    <div class="container text-end col-1 mt-2 mb-3">
                                        <asp:LinkButton runat="server" ID="btnEnviarMensaje" CssClass="btn btn-light" Text="<i class='fa-regular fa-paper-plane' style='color: #000000;'></i>" OnClick="btnEnviarMensaje_Click" />
                                    </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnEnviarMensaje" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal border-white fade fontSetterExo2" id="form-modal-faltan-datos">
        <div class="modal-dialog">
            <div class="modal-content bg-danger bg-opacity-50 rounded-5">
                <div class="modal-header bg-danger">
                    <h5 class="modal-title border-white">Campos Incompletos</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content rounded bg-danger">
                    <div class="container bg-danger mt-3">
                        <asp:Label runat="server" Text="Tiene que llenar todos los campos!"></asp:Label>
                    </div>
                    <asp:Label runat="server" Text="." CssClass="text-danger bg-danger"></asp:Label>
                </div>
            </div>
        </div>
    </div>

    <div class="modal border-white fade fontSetterExo2" id="form-modal-falta">
        <div class="modal-dialog">
            <div class="modal-content bg-danger bg-opacity-50 rounded-5">
                <div class="modal-header bg-danger">
                    <h5 class="modal-title border-white">Sancionado</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content rounded bg-danger">
                    <div class="container bg-danger mt-3">
                        <asp:Label runat="server" ID="txtMensajeFalta" Text="Presione + en la lista para agregar más foros."></asp:Label>
                    </div>
                    <asp:Label runat="server" Text="." CssClass="text-danger bg-danger"></asp:Label>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
