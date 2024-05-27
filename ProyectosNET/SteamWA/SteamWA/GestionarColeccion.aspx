<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="GestionarColeccion.aspx.cs" Inherits="SteamWA.GestionarColeccion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/GestionarColeccion.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <h1 id="hGestionarColeccion" runat="server" class="mt-4 mb-4">Gestionar Colección</h1>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="nombreColeccion" class="form-label">Nombre</label>
                    <input id="txtNombreColeccion" runat="server" type="text" class="form-control" text="Nombre de la Colección">
                </div>
                <div class="mb-3">
                    <label class="form-label">Seleccione los programas</label>
                    <div class="table-responsive">
                        <table id="tablaProductos" runat="server" class="table table-striped table-dark">
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="d-flex justify-content-between">
                    <asp:Button ID="btnEliminar" CssClass="btn btn-primary btn-danger bg-navy-50 text-gray" runat="server" Text="Eliminar" OnClick="btnEliminarColeccion_OnClick"/>
                    <div>
                        <asp:Button ID="btnCancelar" CssClass="btn btn-secondary bg-navy-50 text-gray me-2" runat="server" Text="Cancelar" OnClick="btnCancelar_OnClick"/>
                        <asp:Button ID="btnGuardar" CssClass="btn btn-primary bg-navy text-gray" runat="server" Text="Guardar" OnClick="btnGuardar_OnClick"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- modal para eliminar-->
    <div class="modal fade" id="form-modal-EliminarColeccion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblEliminarColeccion">Eliminar Coleccion</h5>
                    </div>
                    <div class="modal-body">
                        <p>¿Está seguro que desea eliminar esta colección? Esta acción no se puede revertir.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <asp:Button ID="btnEliminarConfirmacion" CssClass="btn btn-primary btn-danger" runat="server" Text="Eliminar" OnClick="btnEliminar_OnClick"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
