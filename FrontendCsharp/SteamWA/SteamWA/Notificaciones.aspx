<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Notificaciones.aspx.cs" Inherits="SteamWA.Notificaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/Steam/NotificacionesStyles.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/mostrarModal.js"></script>
    <script src="Scripts/Steam/Notificaciones.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <h1 class="mt-4">Notificaciones</h1>
        <div class="container-fluid d-flex justify-content-end">
            <asp:LinkButton runat="server" ID="lbEliminarNotificaciones" CssClass="btn btn-outline-light ms-auto" Text="Eliminar todas" OnClick="btnEliminarTodasNotificaciones_Click"/>
        </div>
        <hr />
        <asp:ScriptManager runat="server"></asp:ScriptManager>

        <div class="container-fluid d-flex row pagination">
            <%--<asp:UpdatePanel runat="server" ID="UpdatePanelNotificaciones">
                <ContentTemplate>--%>
                    <asp:ListView ID="lvNotificaciones" runat="server" ItemPlaceholderID="itemPlaceholder" OnItemDataBound="lvNotificaciones_ItemDataBound" OnPagePropertiesChanging="lvNotificaciones_PagePropertiesChanging">
                        <LayoutTemplate>
                            <div id="itemPlaceholder" runat="server"></div>
                            <div class="data-pager">
                                <asp:DataPager runat="server" ID="dpNotificaciones" PagedControlID="lvNotificaciones" PageSize="4">
                                    <Fields>
                                        <asp:NumericPagerField
                                            ButtonCount="10" CurrentPageLabelCssClass="selected"/>
                                    </Fields>
                                </asp:DataPager>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="col-12 mb-3">
                                <div class="card bg-<%# (bool)Eval("revisada") ? "dark" : "navy-50" %> text-light full-width">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-11 card-info" style="cursor:pointer;" data-id-notificacion='<%# Eval("idNotificacion") %>' data-mensaje-completo='<%# Eval("mensaje") %>' data-revisada='<%# Eval("revisada") %>' data-fecha='<%# Eval("fecha", "{0:dd/MM/yyyy}") %>'>
                                                <h5 class="card-title"><%# Eval("tipo") %></h5>
                                                <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
                                            </div>
                                            <div class="dropdown col-md-1 d-flex justify-content-end">
                                                <button class="btn btn-link text-light p-0" type="button" id="ddMenuButton<%# Eval("idNotificacion") %>" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="fa-solid fa-ellipsis-vertical"></i>
                                                </button>
                                                <!-- Dropdown para mostrar opciones para notificación -->
                                                <div class="dropdown-menu dropdown-menu-right justify-content-end" aria-labelledby="ddMenuButton<%# Eval("idNotificacion") %>">
                                                    <asp:LinkButton runat="server" CssClass="dropdown-item" ID="btnMarcarLeidoNoLeido" Text="Marcar" CommandArgument='<%# Eval("idNotificacion") %>' OnClick="btnMarcarLeidoNoLeido_Click" />
                                                    <asp:LinkButton runat="server" CssClass="dropdown-item" ID="btnEliminar" Text="Eliminar" CommandArgument='<%# Eval("idNotificacion") %>' OnClick="btnEliminar_Click" />
                                                </div>
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
                    </asp:ListView>
                <%--</ContentTemplate>
            </asp:UpdatePanel>--%>
        </div>
    </div>

    <!-- Modal para eliminar todas las notificaciones -->
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

    <!-- Modal para modificar notificación -->
    <div class="modal fade" id="form-modal-ModificarNotificacion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel2" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblModificarNotificacion">Modificar Notificación</h5>
                    </div>
                    <div class="modal-body">
                        <p>¿Está seguro que desea modificar la notificación?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <asp:Button ID="btnMarcarNoLeidoModal" CssClass="btn btn-light" runat="server" Text="Marcar como no leído" OnClick="btnMarcarNoLeidoModal_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para eliminar notificación -->
    <div class="modal fade" id="form-modal-EliminarNotificacion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel3" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblEliminarNotificacion">Eliminar Notificación</h5>
                    </div>
                    <div class="modal-body">
                        <p>¿Está seguro que desea eliminar la notificación? Esta acción no se puede revertir.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <asp:Button ID="btnEliminarModal" CssClass="btn btn-danger" runat="server" Text="Eliminar" OnClick="btnEliminarModal_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para mostrar detalles de la notificación -->
    <div class="modal fade" id="form-modal-notificacion" tabindex="-1" role="dialog" aria-labelledby="modalNotificacionLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content bg-navy">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title border-white" id="lblModalNotificacion">Detalles de Notificación</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Tipo:</strong> <span id="tipoNotificacion"></span></p>
                    <p><strong>Mensaje:</strong> <span id="mensajeNotificacion"></span></p>
                    <p><strong>Fecha:</strong> <span id="fechaNotificacion"></span></p>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>
