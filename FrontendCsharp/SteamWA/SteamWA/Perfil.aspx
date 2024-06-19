<%@ Page Title=""
    Language="C#"
    MasterPageFile="~/Steam.Master"
    AutoEventWireup="true"
    CodeBehind="Perfil.aspx.cs"
    Inherits="SteamWA.Perfil" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <style>
        .container-gradient {
            border-top: 1px solid;
            border-image-slice: 1;
            border-width: 1px;
            border-image-source: linear-gradient(90deg, #24282f 0%, #ffffff 45%, #ffffff 55%, #24282f 100%);
            background-image: linear-gradient(#364458, #24282f);
        }

        .nav-tabs .nav-item .nav-link.active {
            background-color: rgb(67, 70, 73);
        }

        .card-img-height {
            height: 220px;
        }

        .column-space {
            padding-right: 50px;
        }

        .pagination a, .pagination span {
            margin: 0 3px;
            padding: 4px 8px;
            text-decoration: none;
            color: #007bff;
        }

            .pagination a:hover {
                background-color: #f8f9fa;
                border-color: #dee2e6;
            }

        .pagination span {
            background-color: #007bff;
            color: #fff;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/mostrarModal.js"></script>

    <script type="text/javascript">
        function validateInput() {
            var input = document.getElementById('<%= inputIdBloquear.ClientID %>');
            var button = document.getElementById('<%= lbBloquearID.ClientID %>');
            if (input.value && input.value > 0) {
                button.classList.remove('disabled');
                button.classList.remove('aspNetDisabled');
            } else {
                button.classList.add('disabled');
                button.classList.add('aspNetDisabled');
            }
        }
    </script>

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <div class="row">
            <!-- Información General del Usuario -->
            <div class="col-md-4">
                <div class="card mb-3 bg-info-subtle">
                    <div class="d-flex justify-content-center align-items-center" style="height: 100%; padding: 1rem;">
                        <asp:Image ID="imgPerfil" AlternateText="Avatar del Usuario" CssClass="card-img-top"
                            style="border-radius:0.4rem; max-width:250px; max-height:250px; box-shadow: 0 4px 16px rgba(0, 0, 0, 0.5);" runat="server" />
                    </div>
                    <div class="card-body">
                        <h5 class="card-title" id="lblNombreCuenta" runat="server">UserName</h5>
                        <p class="card-text text-muted">
                            <i class="fa-solid fa-certificate" id="iconVerificado" runat="server" style="color: green;"></i>
                            <span id="lblVerificado" runat="server" style="color: green;">Verificado por Steam</span>
                        </p>
                        <div id="onlineIndicator" class="online-indicator bg-success" runat="server"></div>
                        <ul>
                            <li>UID:
                    <asp:Label ID="lblUID" runat="server">UserUID</asp:Label></li>
                            <li>Correo:
                    <asp:Label ID="lblCorreo" runat="server">UserMail</asp:Label></li>
                            <li>Teléfono:
                    <asp:Label ID="lblTelefono" runat="server">UserPhone</asp:Label></li>
                            <li>Fecha Nacimiento:
                    <asp:Label ID="lblFechaNacimiento" runat="server">UserBirth</asp:Label></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-8 container-gradient rounded-4">

                <!-- Barra de Navegación -->
                <ul class="nav nav-tabs m-3" role="tablist">
                    <li class="nav-item">
                        <asp:LinkButton ID="lbLogros" CssClass="nav-link bg-navy text-light bg-gradient" runat="server" OnClick="lbLogros_Click">Logros Obtenidos</asp:LinkButton>
                    </li>
                    <li class="nav-item">
                        <asp:LinkButton ID="lbUsuariosBloqueados" CssClass="nav-link bg-navy text-light" runat="server" OnClick="lbUsuariosBloqueados_Click">Usuarios Bloqueados</asp:LinkButton>
                    </li>
                </ul>

                <div class="m-3">
                    <!-- Contenido de cada Pestaña -->
                    <asp:MultiView ID="MultiView1" runat="server">

                        <!-- Vista para Logros Obtenidos -->
                        <asp:View ID="ViewLogrosObtenidos" runat="server">
                            <!-- GridView para listar los logros del usuario -->
                            <asp:GridView ID="gvLogros" runat="server" AutoGenerateColumns="False"
                                AllowPaging="True" PageSize="5"
                                CssClass="table table-responsive table-striped table-dark"
                                OnPageIndexChanging="gvLogros_PageIndexChanging"
                                OnRowDataBound="gvLogros_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Logo">
                                        <ItemTemplate>
                                            <img src="Images/logo_juego4.jpg" style="height: 50px; width: 50px;" />
                                        </ItemTemplate>
                                        <ItemStyle CssClass="column-space" />
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Título">
                                        <ItemStyle CssClass="column-space" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Logro">
                                        <ItemStyle CssClass="column-space" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Descripción">
                                        <ItemStyle CssClass="column-space" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Fecha" DataFormatString="{0:dd-MM-yyyy}">
                                        <ItemStyle CssClass="column-space" />
                                    </asp:BoundField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="d-flex justify-content-center align-items-center mt-3">
                                        <asp:Label runat="server" Text="Aún no has conseguido ningún logro. ¡Comienza a jugar para ganar logros y mejorar tu perfil!" CssClass="display-7 text-center" />
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>

                        </asp:View>

                        <!-- Vista para Información Personal -->
                        <asp:View ID="ViewInfoPersonal" runat="server">
                            <!-- GridView de usuarios bloqueados -->
                            <div style="margin-bottom: 12px;">
                                <h4>Bloquear un usuario</h4>
                                <asp:Label runat="server" Text="Bloquear a un usuario es una acción permanente. Puedes bloquear a un usuario que sea tu amigo o ingresando su ID de usuario:" CssClass="text-light" Style="margin-top: 100px;"></asp:Label>
                                <div class="col my-3">
                                    <input id="inputIdBloquear" runat="server" type="number" placeholder="Ingresa un ID para bloquear" class="col-5" style="margin-right: 20px; height: 38px;" oninput="validateInput()" />
                                    <asp:LinkButton ID="lbBloquearID" runat="server" Text="Bloquear" CssClass="btn btn-danger disabled" OnClick="lbBloquearID_Click" />
                                </div>
                            </div>
                            <asp:GridView ID="gvBloqueados" runat="server"
                                AllowPaging="true" PageSize="2"
                                OnPageIndexChanging="gvBloqueados_PageIndexChanging"
                                AutoGenerateColumns="false"
                                CssClass="table table-responsive table-striped table-dark"
                                PagerStyle-CssClass="pagination"
                                PagerStyle-Width="0">
                                <Columns>
                                    <asp:TemplateField HeaderText="UID">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUID" runat="server" Text='<%# Eval("uid") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Nombre del Perfil" DataField="nombrePerfil" />
                                    <asp:BoundField HeaderText="Nombre de la Cuenta" DataField="nombreCuenta" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="d-flex justify-content-center align-items-center mt-3">
                                        <asp:Label runat="server" Text="No has bloqueado a ningún usuario." CssClass="display-7 text-center" />
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </asp:View>
                    </asp:MultiView>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de Confirmación de Bloqueo de Usuario -->
    <div id="modalBloquearUsuario" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblEliminarAmigo">Bloquear un Usuario</h5>
                    </div>
                    <div class="modal-body">
                        <asp:Label ID="lblConfirmacionUsuario" CssClass="text-light" Text="TODO: Cambiar texto" runat="server"/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <asp:LinkButton runat="server" ID="btnBloquearModal" type="button" CssClass="btn btn-primary btn-danger" OnClick="btnBloquearModal_Click" Visible="false" Text="Bloquear" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>