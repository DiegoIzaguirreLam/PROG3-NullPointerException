<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="GestionarLogros.aspx.cs" Inherits="SteamWA.GestionarLogros" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    .btn-volver {
        position: fixed;
        bottom: 20px;
        left: 20px;
        z-index: 9999;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/GestionarLogros.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container fontSetterExo2">
        <h1 id="hGestionarLogros" runat="server" class="mt-4 d-inline-block">Gestionar logros</h1>
        <p id="pLogros" runat="server"></p>
        <h2 id="h2LogrosDesbloqueados" runat="server">Logros Desbloqueados</h2>
        <p id="pLogrosDesbloqueados" runat="server"></p>
        <asp:GridView ID="gvLogrosDesbloqueados" runat="server" AutoGenerateColumns="false"
            CssClass="table table-hover table-responsive table-striped table-dark" OnRowDataBound="gvLogrosDesbloqueados_RowDataBound" OnPageIndexChanging="gvLogrosDesbloqueados_PageIndexChanging">
            <Columns>
                <asp:BoundField HeaderText="Nombre" />
                <asp:BoundField HeaderText="Descripcion" />
                <asp:BoundField HeaderText="Fecha adquirido" />
                <asp:TemplateField ItemStyle-CssClass="text-end">
                    <ItemTemplate>
                        <asp:LinkButton runat="server" Text="<i class='fa-solid fa-x ps-2' style='color:#f32013'></i>" CommandArgument='<%# Eval("idLogroDesbloqueado") %>' OnClick="btnEliminarLogroDesbloqueado_Click"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <hr />
        <h2 id="h2LogrosPorDesbloquear" runat="server">Logros por Desbloquear</h2>
        <p id="pLogrosPorDesbloquear" runat="server"></p>
        <asp:GridView ID="gvLogrosPorDesbloquear" runat="server" AutoGenerateColumns="false"
            CssClass="table table-hover table-responsive table-striped table-dark" OnRowDataBound="gvLogrosPorDesbloquear_RowDataBound" OnPageIndexChanging="gvLogrosPorDesbloquear_PageIndexChanging">
            <Columns>
                <asp:BoundField HeaderText="Nombre" />
                <asp:BoundField HeaderText="Descripcion" />
                <asp:TemplateField ItemStyle-CssClass="text-end">
                    <ItemTemplate>
                        <asp:LinkButton runat="server" Text="<i class='fa-solid fa-check-double ps-2' style='color:#4BB543'></i>" CommandArgument='<%# Eval("idLogro") %>' OnClick="btnDesbloquearLogro_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:LinkButton ID="lbVolver" runat="server" CssClass="btn bg-navy btn-outline-light" Text="<i class='fa-solid fa-arrow-left'></i> Volver" OnClick="lbVolver_Click"/>
    </div>

    <div class="modal fade" id="form-modal-EliminarLogroDesbloqueado" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblEliminarLogroDesbloqueado">Eliminar Logro Desbloqueado</h5>
                    </div>
                    <div class="modal-body">
                        <p>¿Está seguro que desea eliminar este logro desbloqueado? Deberá volver a desbloquear el logro para adquirirlo.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <asp:Button ID="btnEliminarConfirmacionModal" CssClass="btn btn-primary btn-danger" runat="server" Text="Eliminar" OnClick="btnEliminarLogroDesbloqueadoConfirmacionModal_OnClick" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="form-modal-DesbloquearLogro" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblDesbloquearLogro">Desbloquear Logro</h5>
                    </div>
                    <div class="modal-body">
                        <p>¿Desea marcar este logro como desbloqueado?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <asp:Button ID="btnDesbloquearLogroConfirmacionModal" CssClass="btn btn-primary btn-success" runat="server" Text="Desbloquear" OnClick="btnDesbloquearLogroConfirmacionModal_OnClick" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
