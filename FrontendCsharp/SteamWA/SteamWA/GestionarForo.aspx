<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="GestionarForo.aspx.cs" Inherits="SteamWA.GestionarForo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/crearForo.js"></script>
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
        <div class="search-bar">
            <input type="text" class="form-control mt-3" placeholder="Buscar Subforos...">
        </div>
    </div>
    <hr />
    <div class="container fontSetterExo2">
        <asp:GridView ID="gvSubforos" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-responsive table-striped table-dark" OnRowDataBound="gvSubforos_RowDataBound">
            <Columns>
                <asp:BoundField HeaderText="Nombre" />
                <%--Se mostrará el primer mensaje del hilo fijado en el foro--%>
                <asp:TemplateField ItemStyle-CssClass="text-end">
                    <ItemTemplate>
                        <asp:LinkButton runat="server" Text="<i class='fa-solid fa-up-right-and-down-left-from-center' style='color:#ffffff'></i>"
                            CommandArgument='<%# Eval("idSubforo") %>' OnClick="lbAbrirSubforo_Click"></asp:LinkButton>
                        <asp:LinkButton runat="server" Text="<i class='fa-solid fa-edit ps-2' style='color:#ffffff'></i>"
                            CommandArgument='<%# Eval("idSubforo") %>' OnClick="lbActualizarSubforo_Click" />
                        <asp:LinkButton runat="server" Text="<i class='fa-solid fa-trash ps-2' style='color:#ffffff'></i>"
                            CommandArgument='<%# Eval("idSubforo") %>' OnClick="lbEliminarSubforo_Click" />
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
                                <asp:Label ID="lblSubforo" runat="server" Text="Subforo:" CssClass="col-sm-3 col-form-label mt-1" />
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtSubforo" runat="server" CssClass="form-control mt-1" MaxLength="14" Required="true"/>
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblMensajeInicial" runat="server" Text="Mensaje:" CssClass="col-sm-3 col-form-label mt-1" />
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtMensajeInicial" runat="server" CssClass="form-control mt-1" Height="150" Required="true"/>
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
                                <asp:Label ID="lblNSubforo" runat="server" Text="Subforo:" CssClass="col-sm-3 col-form-label" />
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtNSubforo" runat="server" CssClass="form-control" MaxLength="14" Required="true"/>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:Button ID="Button1" runat="server" Text="Actualizar"
                                CssClass="float-end btn btn-secondary bg-dark mb-2" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
