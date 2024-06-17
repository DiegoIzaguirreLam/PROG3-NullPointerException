<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Comunidad.aspx.cs" Inherits="SteamWA.Comunidad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/crearForo.js"></script>
    <script src="Scripts/Steam/Comunidad.js?v5"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <link href="Content/Steam/FontAdder.css" rel="stylesheet" />
    <asp:ScriptManager runat="server"></asp:ScriptManager>

    <div class="container">
        <h1 class="mt-4">Comunidad</h1>
        <div class="row align-items-center">
            <div class="col-md-7 row align-items-start">
                <div class="col-md-auto align-items-lg-start">
                    <asp:Button ID="return" CssClass="h5 bg-transparent border-0 fontSetterExo2" runat="server" Text="Comunidad" OnClick="btnActualizarComunidad_Click" />
                </div>
            </div>
            <div class="col text-end">
                <asp:Button ID="btnCrearForo" CssClass="btn btn-dark col-sm-4 border-light fontSetterExo2" runat="server" Text="Crear Foro" OnClick="btnCrearForo_Click" />
            </div>
        </div>

        <div class="search-bar">
            <asp:TextBox runat="server" ID="txtBusquedaForo" CssClass="form-control mt-3 fontSetterExo2" OnTextChanged="txtBusquedaForo_TextChanged" AutoPostBack="true" oninput="buscarForo_js()"></asp:TextBox>
        </div>
    </div>
    <div class="container mt-3 fontSetterExo2">
        <div class="row align-items-center">
            <div class="col-sm-4 text-start">
                <asp:Button ID="btnSuscritos" runat="server" CssClass="btn btn-dark border-light" Text="Suscritos" OnClick="btnSuscritos_Click" />
            </div>
            <div class="col text-center">
                <asp:LinkButton ID="lbReporte" runat="server" CssClass="btn btn-primary align-middle btn-info" Text="<i class='fa-solid fa-file'></i> Generar Reporte de Mensajes" />
            </div>
            <div class="col text-end">
                <asp:Button ID="btnCreados" runat="server" CssClass="btn btn-dark border-light" Text="Creados" OnClick="btnCreados_Click" />
            </div>
        </div>
    </div>
    <hr "/>
    <asp:UpdatePanel runat="server" UpdateMode="Always">
        <ContentTemplate>
            <div class="container fontSetterExo2 mb-5">
                <asp:GridView ID="gvForos" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-responsive table-striped table-dark" PageSize="5" OnPageIndexChanging="gvForos_PageIndexChanging" OnRowCommand="gvForos_RowCommand" AllowPaging="true">
                    <Columns>
                        <asp:ButtonField HeaderText="Nombre" DataTextField="nombre" HeaderStyle-CssClass="fontSetterExo2" ControlStyle-CssClass="text-white" ControlStyle-Font-Underline="false" ItemStyle-CssClass="fontSetterExo2" CommandName="AbrirForo" />
                        <asp:BoundField HeaderText="Descripción" DataField="descripcion" HeaderStyle-CssClass="fontSetterExo2" ItemStyle-CssClass="fontSetterExo2" />
                        <%--<asp:ButtonField HeaderText="Descripción" Text="Descripcion..." ControlStyle-CssClass="text-white" ControlStyle-Font-Underline="false"/>--%>
                        <%--<asp:ImageField DataImageUrlField="FotoPerfil" ControlStyle-Width="25px" ItemStyle-HorizontalAlign="Left"></asp:ImageField>--%>
                        <asp:ButtonField HeaderText="Creador" DataTextField="nombreCreador" ControlStyle-CssClass="text-white" ControlStyle-Font-Underline="false"
                            HeaderStyle-CssClass="fontSetterExo2" ItemStyle-CssClass="fontSetterExo2" />
                        <asp:TemplateField ItemStyle-CssClass="text-end">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" Text="<i class='fa-solid fa-plus' style='color: #ffffff;'></i>"
                                    CommandArgument='<%# Eval("idForo") %>' OnClick="lbSuscribirForo_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="txtBusquedaForo" EventName="TextChanged" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:Label runat="server" CssClass="bg-transparent text-dark" Text="."></asp:Label>
    <!--Clase modal para la creación de un foro-->
    <div class="modal border-white fade fontSetterExo2" id="form-modal-foro">
        <div class="modal-dialog">
            <div class="modal-content bg-secondary bg-opacity-50">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title border-white fontSetterExo2">Creador de Foros</h5>
                    <button type="button" class="btn-close bg-white fontSetterExo2" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content">
                    <div class="container bg-dark">
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblTema" runat="server" Text="Tema:" CssClass="col-sm-3 col-form-label fontSetterExo2" /><sup style="color:red">*</sup>
                                <div class="col-sm-12 col-4">
                                    <asp:TextBox ID="txtTema" runat="server" CssClass="form-control" MaxLength="14"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblDescripcion" runat="server" Text="Descripción:" CssClass="col-sm-3 col-form-label" /><sup style="color:red">*</sup>
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" Height="50" />
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblInicial" runat="server" Text="Subforo Inicial:" CssClass="col-sm-3 col-form-label" /><sup style="color:red">*</sup>
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtInicial" runat="server" CssClass="form-control" MaxLength="14" />
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblMensajeInicial" runat="server" Text="Mensaje:" CssClass="col-sm-3 col-form-label" /><sup style="color:red">*</sup>
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtMensajeInicial" runat="server" CssClass="form-control" Height="150" />
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="col-md-5">
                                <asp:Button ID="btnImagen" runat="server" Text="Imagen"
                                    CssClass="justify-content-md-start btn btn-secondary bg-dark mb-2" />
                            </div>
                            <div class="col-md-7 d-grid gap-2 d-md-flex justify-content-md-end">
                                <asp:Button ID="btnGuardarForoModal" runat="server" Text="Crear"
                                    CssClass="justify-content-md-end btn btn-secondary bg-dark mb-2" OnClick="btnGuardarForoModal_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Clase modal para la Edición de un foro-->
    <div class="modal border-white fade fontSetterExo2" id="form-modal-edicion">
        <div class="modal-dialog">
            <div class="modal-content bg-secondary bg-opacity-50">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title border-white">Editor de Foros</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content">
                    <div class="container bg-dark">
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblNTema" runat="server" Text="Tema:" CssClass="col-sm-3 col-form-label" /><sup style="color:red">*</sup>
                                <div class="col-sm-12 col-4">
                                    <asp:TextBox ID="txtNTema" runat="server" CssClass="form-control" MaxLength="14" />
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblNDescripcion" runat="server" Text="Descripción:" CssClass="col-sm-3 col-form-label" /><sup style="color:red">*</sup>
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtNDescripcion" runat="server" CssClass="form-control" Height="50" />
                                </div>
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:Button ID="btnActualizarForo" runat="server" Text="Guardar"
                                CssClass="float-end btn btn-secondary bg-dark mb-2" OnClick="btnActualizarForo_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Clase modal para mostrar Foros creados-->
    <div class="modal border-white fade fontSetterExo2" id="form-modal-creados">
        <div class="modal-dialog">
            <div class="modal-content bg-secondary bg-opacity-50">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title border-white">Mis Foros</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content">
                    <div class="container bg-dark">
                        <asp:GridView ID="gvCreados" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-responsive table-striped table-dark" PageSize="5" OnPageIndexChanging="gvCreados_PageIndexChanging" OnRowCommand="gvForos_RowCommand" AllowPaging="true">
                            <Columns>
                                <asp:ButtonField HeaderText="Nombre" DataTextField="nombre" HeaderStyle-CssClass="fontSetterExo2" ControlStyle-CssClass="text-white" ControlStyle-Font-Underline="false" ItemStyle-CssClass="fontSetterExo2" CommandName="AbrirForoCreado" />
                                <asp:BoundField HeaderText="Descripción" DataField="descripcion" HeaderStyle-CssClass="fontSetterExo2" ItemStyle-CssClass="fontSetterExo2" />
                                <%--<asp:ButtonField HeaderText="Descripción" Text="Descripcion..." ControlStyle-CssClass="text-white" ControlStyle-Font-Underline="false"/>--%>
                                <%--<asp:ImageField DataImageUrlField="FotoPerfil" ControlStyle-Width="25px" ItemStyle-HorizontalAlign="Left"></asp:ImageField>--%>
                                <asp:ButtonField HeaderText="Creador" DataTextField="nombreCreador" ControlStyle-CssClass="text-white" ControlStyle-Font-Underline="false"
                                    HeaderStyle-CssClass="fontSetterExo2" ItemStyle-CssClass="fontSetterExo2" />
                                <asp:TemplateField ItemStyle-CssClass="text-end">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" Text="<i class='fa-solid fa-edit ps-2' style='color:#ffffff'></i>"
                                            CommandArgument='<%# Eval("idForo") %>' OnClick="lbActualizarInfoForo_Click" />
                                        <asp:LinkButton runat="server" Text="<i class='fa-solid fa-trash ps-2' style='color:#ffffff'></i>"
                                            CommandArgument='<%# Eval("idForo") %>' OnClick="lbEliminarForo_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Clase modal para mostrar Foros suscritos-->
    <div class="modal border-white fade fontSetterExo2" id="form-modal-suscritos">
        <div class="modal-dialog">
            <div class="modal-content bg-secondary bg-opacity-50">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title border-white">Mis Suscripciones</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content">
                    <div class="container bg-dark">
                        <asp:GridView ID="gvSuscritos" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-responsive table-striped table-dark" PageSize="5" OnPageIndexChanging="gvSuscritos_PageIndexChanging" OnRowCommand="gvForos_RowCommand" AllowPaging="true">
                            <Columns>
                                <asp:ButtonField HeaderText="Nombre" DataTextField="nombre" HeaderStyle-CssClass="fontSetterExo2" ControlStyle-CssClass="text-white" ControlStyle-Font-Underline="false" ItemStyle-CssClass="fontSetterExo2" CommandName="AbrirForoSuscrito" />
                                <asp:BoundField HeaderText="Descripción" DataField="descripcion" HeaderStyle-CssClass="fontSetterExo2" ItemStyle-CssClass="fontSetterExo2" />
                                <%--<asp:ButtonField HeaderText="Descripción" Text="Descripcion..." ControlStyle-CssClass="text-white" ControlStyle-Font-Underline="false"/>--%>
                                <%--<asp:ImageField DataImageUrlField="FotoPerfil" ControlStyle-Width="25px" ItemStyle-HorizontalAlign="Left"></asp:ImageField>--%>
                                <asp:ButtonField HeaderText="Creador" DataTextField="nombreCreador" ControlStyle-CssClass="text-white" ControlStyle-Font-Underline="false"
                                    HeaderStyle-CssClass="fontSetterExo2" ItemStyle-CssClass="fontSetterExo2" />
                                <asp:TemplateField ItemStyle-CssClass="text-end">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" Text="<i class='fa-solid fa-trash ps-2' style='color:#ffffff'></i>"
                                            CommandArgument='<%# Eval("idForo") %>' OnClick="lbDesuscribir_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--Modal para mostrar que no hay que mostrar--%>
    <div class="modal border-white fade fontSetterExo2" id="form-modal-sin-suscritos">
        <div class="modal-dialog">
            <div class="modal-content bg-danger bg-opacity-50 rounded-5">
                <div class="modal-header bg-danger">
                    <h5 class="modal-title border-white">Sin Suscripciones</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content rounded bg-danger">
                    <div class="container bg-danger mt-3">
                        <asp:Label runat="server" Text="Presione + en la lista para agregar más foros."></asp:Label>
                    </div>
                    <asp:Label runat="server" Text="." CssClass="text-danger bg-danger"></asp:Label>
                </div>
            </div>
        </div>
    </div>
    <div class="modal border-white fade fontSetterExo2" id="form-modal-sin-creados">
        <div class="modal-dialog">
            <div class="modal-content bg-danger bg-opacity-50 rounded-5">
                <div class="modal-header bg-danger">
                    <h5 class="modal-title border-white">Sin Creaciones</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content rounded bg-danger">
                    <div class="container bg-danger mt-3">
                        <asp:Label runat="server" Text="Presione 'Crear Foro' para crear en nuestra comunidad!."></asp:Label>
                    </div>
                    <asp:Label runat="server" Text="." CssClass="text-danger bg-danger"></asp:Label>
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
</asp:Content>
