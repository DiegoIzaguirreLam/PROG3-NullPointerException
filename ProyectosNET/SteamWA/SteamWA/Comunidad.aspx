<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Comunidad.aspx.cs" Inherits="SteamWA.Comunidad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/crearForo.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-7 row align-items-center">
                <div class="col-md-auto align-items-lg-start">
                    <asp:Button ID="return" CssClass="h5 bg-transparent border-0 fontSetterExo2" runat="server" Text="Comunidad" OnClick="btnActualizarComunidad_Click"/>
                </div>
            </div>
            <div class="col-md-5 d-grid gap-2 d-md-flex justify-content-md-end">
                <asp:Button ID="btnCrearForo" CssClass="btn btn-dark col-sm-4 border-light fontSetterExo2" runat="server" Text="Crear Foro" OnClick="btnCrearForo_Click" />
            </div>
        </div>
        <div class="search-bar">
            <input type="text" class="form-control mt-3 fontSetterExo2" placeholder="Buscar Foros...">
        </div>
    </div>
    <hr />
    <div class="container">
        <asp:GridView ID="gvForos" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-responsive table-striped table-dark">
            <Columns>
                <asp:BoundField HeaderText="Nombre" DataField="Nombre" HeaderStyle-CssClass="fontSetterExo2" ItemStyle-CssClass="fontSetterExo2"/>
                <asp:BoundField HeaderText="Descripción" DataField="Descripcion" HeaderStyle-CssClass="fontSetterExo2" ItemStyle-CssClass="fontSetterExo2"/>
                <%--<asp:ButtonField HeaderText="Descripción" Text="Descripcion..." ControlStyle-CssClass="text-white" ControlStyle-Font-Underline="false"/>--%>
                <asp:ImageField DataImageUrlField="FotoPerfil" ControlStyle-Width="25px" ItemStyle-HorizontalAlign="Left"></asp:ImageField>
                <asp:ButtonField HeaderText="Creador" DataTextField="Usuario" ControlStyle-CssClass="text-white" ControlStyle-Font-Underline="false" 
                                 HeaderStyle-CssClass="fontSetterExo2" ItemStyle-CssClass="fontSetterExo2" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" Text="<i class='fa-solid fa-up-right-and-down-left-from-center' style='color:#ffffff'></i>"
                            CommandArgument='<%# Eval("IdForo") %>' OnClick="lbAbrirForo_Click"></asp:LinkButton>
                        <asp:LinkButton runat="server" Text="<i class='fa-solid fa-edit ps-2' style='color:#ffffff'></i>"
                            CommandArgument='<%# Eval("IdForo") %>' OnClick="lbActualizarInfoForo_Click" />
                        <asp:LinkButton runat="server" Text="<i class='fa-solid fa-trash ps-2' style='color:#ffffff'></i>"
                            CommandArgument='<%# Eval("IdForo") %>' OnClick="lbEliminarForo_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
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
                                <asp:Label ID="lblTema" runat="server" Text="Tema:" CssClass="col-sm-3 col-form-label fontSetterExo2" />
                                <div class="col-sm-12 col-4">
                                    <asp:TextBox ID="txtTema" runat="server" CssClass="form-control" MaxLength="14"/>
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblDescripcion" runat="server" Text="Descripción:" CssClass="col-sm-3 col-form-label" />
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" Height="50" />
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblInicial" runat="server" Text="Subforo Inicial:" CssClass="col-sm-3 col-form-label" />
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtInicial" runat="server" CssClass="form-control" MaxLength="14"/>
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblMensajeInicial" runat="server" Text="Mensaje:" CssClass="col-sm-3 col-form-label" />
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtMensajeInicial" runat="server" CssClass="form-control" Height="150"/>
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
                                    CssClass="justify-content-md-end btn btn-secondary bg-dark mb-2" />
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
                                <asp:Label ID="lblNTema" runat="server" Text="Tema:" CssClass="col-sm-3 col-form-label" />
                                <div class="col-sm-12 col-4">
                                    <asp:TextBox ID="txtNTema" runat="server" CssClass="form-control" MaxLength="14"/>
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblNDescripcion" runat="server" Text="Descripción:" CssClass="col-sm-3 col-form-label" />
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtNDescripcion" runat="server" CssClass="form-control" Height="50"/>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:Button ID="btnActualizar" runat="server" Text="Guardar"
                                CssClass="float-end btn btn-secondary bg-dark mb-2" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
