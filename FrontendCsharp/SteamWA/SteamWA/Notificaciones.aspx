﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Notificaciones.aspx.cs" Inherits="SteamWA.Notificaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/mostrarNotificacion.js"></script>
    <script src="Scripts/Steam/mostrarModal.js"></script>
    <%--<script type="text/javascript">
        $(document).ready(function () {
            $('#form-modal-notificacion').on('hidden.bs.modal', function () {
                __doPostBack('<%= UpdatePanelNotificaciones.ClientID %>', '');
            });
        });
    </script>--%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <style>
        .bgDesplegables {
            background-color: #392e47;
        }
    </style>
    <div class="container">
        <h1 class="mt-4">Notificaciones</h1>
        <div class="container-fluid d-flex justify-content-end">
            <asp:LinkButton runat="server" ID="lbEliminarNotificaciones" CssClass="btn btn-light ms-auto" Text="Eliminar todas <i class='fa-solid fa-trash'></i>" OnClick="btnEliminarTodasNotificaciones_Click" />
        </div>
        <hr />
        <asp:ScriptManager runat="server"></asp:ScriptManager>

        <div class="container-fluid d-flex row">
            <asp:UpdatePanel runat="server" ID="UpdatePanelNotificaciones">
                <ContentTemplate>
                    <asp:ListView ID="lvNotificaciones" runat="server" ItemPlaceholderID="itemPlaceholder">
                        <ItemTemplate>
                            <div class="col-12 mb-3">
                                <div class="card bg-<%# (bool)Eval("revisada") ? "dark" : "navy-50" %> text-light full-width">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-9">
                                                <h5 class="card-title"><%# Eval("tipo") %></h5>
                                                <p class="card-text"><%# Eval("mensaje") %></p>
                                            </div>
                                            <div class="col-md-3 d-flex justify-content-end">
                                                <asp:LinkButton runat="server" CssClass="text-light" Text="<i class='fa-solid fa-up-right-and-down-left-from-center'></i>" OnClick="ExpandirNotificacion_Click" CommandArgument='<%# Eval("idNotificacion") %>' />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <div class="d-flex justify-content-center align-items-center mt-3">
                                <asp:Label runat="server" Text="No hay notificaciones" CssClass="display-7 text-center" />
                            </div>
                        </EmptyDataTemplate>
                        <%--<LayoutTemplate>
                            <div id="itemPlaceholder" runat="server"></div>
                            <asp:DataPager ID="DataPager1" runat="server" PagedControlID="lvNotificaciones" PageSize="3">
                                <Fields>
                                    <asp:NumericPagerField ButtonCount="10" />
                                </Fields>
                            </asp:DataPager>
                        </LayoutTemplate>--%>
                    </asp:ListView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <!-- Modal para expandir notificacion -->
    <div class="modal border-white" id="form-modal-notificacion">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content bg-navy">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title border-white" id="tipoNotificacion"></h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div>
                        <p id="mensaje"></p>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-between">
                    <asp:Button ID="btnEliminar" CssClass="btn btn-danger" runat="server" Text="Eliminar" OnClientClick='<%# "confirmarEliminar(" + Eval("IdNotificacion") + ")" %>' OnClick="btnEliminar_Click" />
                    <asp:Button ID="btnMarcarNoLeido" CssClass="btn btn-light" runat="server" Text="Marcar como no leído" OnClick="btnMarcarNoLeido_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="form-modal-EliminarTodasNotificaciones" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblEliminarNotificaciones">Eliminar Notificaciones</h5>
                    </div>
                    <div class="modal-body">
                        <p>¿Está seguro que desea eliminar todas las notificaciones? Esta acción no se puede revertir.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <asp:Button ID="btnEliminarConfirmacion" CssClass="btn btn-primary btn-danger" runat="server" Text="Eliminar" OnClick="btnEliminarTodasNotificacionesModal_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
