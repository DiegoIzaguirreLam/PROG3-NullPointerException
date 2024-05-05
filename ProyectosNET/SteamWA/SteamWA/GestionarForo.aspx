<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="GestionarForo.aspx.cs" Inherits="SteamWA.GestionarForo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <asp:Label ID="nombreForo" CssClass="h1" runat="server">Comunidad</asp:Label>
            </div>
            <div class="col-md-6 d-grid gap-2 d-md-flex justify-content-md-end">
                <asp:Button ID="btnCrearForo" CssClass="btn btn-dark col-sm-4 border-light" runat="server" Text="Crear Subforo" OnClick="btnCrearSubforo_Click" />
            </div>
        </div>
        <div class="search-bar">
            <input type="text" class="form-control mt-3" placeholder="Buscar Subforos...">
        </div>
    </div>
    <hr />
    <div class="container row">
        <asp:GridView ID="foros" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-responsive table-striped">
            <Columns>
                <asp:BoundField HeaderText="Nombre" DataField="nombre" />
                <asp:BoundField HeaderText="Descripción" DataField="descripcion" />
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <!--Clase modal para la creación de un subforo-->
    <!--<div class="modal border-white" id="form-modal-foro">
        <div class="modal-dialog">
            <div class="modal-content bg-secondary bg-opacity-50">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title border-white">Creador de Foros</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content">
                    <div class="container bg-dark">
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblTema" runat="server" Text="Tema:" CssClass="col-sm-3 col-form-label" />
                                <div class="col-sm-12 col-4">
                                    <asp:TextBox ID="txtTema" runat="server" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblDescripcion" runat="server" Text="Descripción:" CssClass="col-sm-3 col-form-label" />
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblInicial" runat="server" Text="Subforo Inicial:" CssClass="col-sm-3 col-form-label" />
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtInicial" runat="server" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblMensajeInicial" runat="server" Text="Mensaje:" CssClass="col-sm-3 col-form-label" />
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtMensajeInicial" runat="server" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:Button ID="btnGuardar" runat="server" Text="Crear"
                                CssClass="float-end btn btn-secondary bg-dark mb-2" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>-->
</asp:Content>
