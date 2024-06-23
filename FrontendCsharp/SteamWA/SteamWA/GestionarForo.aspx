<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="GestionarForo.aspx.cs" Inherits="SteamWA.GestionarForo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/crearForo.js"></script>
    <script src="Scripts/Steam/Comunidad.js?v5"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <h1 class="mt-4">Comunidad</h1>
        <div class="row align-items-center fontSetterExo2">
            <div class="col-md-7 row align-items-center">
                <div class="col-md-auto align-items-lg-start">
                    <asp:Button ID="return" CssClass="h5 bg-transparent border-0" runat="server" Text="Comunidad" OnClick="btnVolverComunidad_Click" />
                    <i class="fa-solid fa-caret-right fa-1x" style="color: #ffffff;"></i>
                </div>
                <div class="col-md-auto justify-content-md-start">
                    <asp:Button ID="foro" CssClass="h5 bg-transparent border-0" runat="server" Text="Comunidad" OnClick="btnActualizarForo_Click" />
                </div>
            </div>
            <div class="col text-end">
                <asp:Button ID="btnCrearForo" CssClass="btn btn-dark col-sm-4 border-light" runat="server" Text="Crear Subforo" OnClick="btnCrearSubforo_Click" />
            </div>
        </div>
    </div>
    <hr />
    <div class="container fontSetterExo2">
        <asp:GridView ID="gvSubforos" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-responsive table-striped table-dark" PageSize="5" AllowPaging="true" OnPageIndexChanging="gvSubforos_PageIndexChanging" OnRowCommand="gvSubforos_RowCommand">
            <Columns>
                <asp:ButtonField HeaderText="Nombre" DataTextField="nombre" HeaderStyle-CssClass="fontSetterExo2" ControlStyle-CssClass="text-white" ControlStyle-Font-Underline="false" ItemStyle-CssClass="fontSetterExo2" CommandName="AbrirSubforo" />
                <%--Se mostrará el primer mensaje del hilo fijado en el foro--%>
                <asp:TemplateField ItemStyle-CssClass="text-end">
                    <ItemTemplate>
                        <asp:LinkButton runat="server" Text="<i class='fa-solid fa-edit ps-2' style='color:#ffffff'></i>"
                            CommandArgument='<%# Eval("idSubforo") %>' OnClick="lbActualizarSubforo_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <!--Clase modal para la creación de un subforo-->
    <div class="modal border-white fade fontSetterExo2" id="form-modal-subforo">
        <div class="modal-dialog">
            <div class="modal-content bg-secondary bg-opacity-50">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title border-white">Creador de Subforos</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content">
                    <div class="container bg-dark">
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblSubforo" runat="server" Text="Subforo:" CssClass="col-sm-3 col-form-label mt-1" /><sup style="color:red">*</sup>
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtSubforo" runat="server" CssClass="form-control mt-1" MaxLength="25"/>
                                </div>
                            </div>
                        </div>
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
                                    CssClass="float-end btn btn-secondary bg-dark mb-2" OnClick="btnGuardar_Click"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Clase modal para la actualización de un subforo-->
    <div class="modal border-white fade fontSetterExo2" id="form-modal-actualizar">
        <div class="modal-dialog">
            <div class="modal-content bg-secondary bg-opacity-50">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title border-white">Editor de Subforos</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content">
                    <div class="container bg-dark">
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblNSubforo" runat="server" Text="Subforo:" CssClass="col-sm-3 col-form-label" /><sup style="color:red">*</sup>
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtNSubforo" runat="server" CssClass="form-control" MaxLength="25"/>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:Button ID="btnActualizaSubforo" runat="server" Text="Actualizar"
                                CssClass="float-end btn btn-secondary bg-dark mb-2" OnClick="btnActualizaSubforo_Click" />
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
