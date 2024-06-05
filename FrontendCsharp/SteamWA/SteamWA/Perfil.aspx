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
            height: 220px; /* ajusta esta altura según tus necesidades */
        }

        .column-space {
            padding-right: 50px; /* Cambia el valor según tu preferencia */
        }

    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <div class="row">
            <!-- Información General del Usuario -->
            <div class="col-md-3">
                <div class="card mb-3">
                    <img src="Images/user_profile_picture.jpg" class="card-img-top" alt="Avatar del Usuario">
                    <div class="card-body bg-info-subtle">
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
            <div class="col-md-9 container-gradient rounded-4">

                <!-- Barra de Navegación -->
                <ul class="nav nav-tabs m-3" role="tablist">
                    <li class="nav-item">
                        <asp:LinkButton ID="lbLogros" CssClass="nav-link bg-navy text-light bg-gradient" runat="server" OnClick="lbLogros_Click">Logros Obtenidos</asp:LinkButton>
                    </li>
                    <li class="nav-item mx-4">
                        <asp:LinkButton ID="lbActividad" CssClass="nav-link bg-navy text-light" runat="server" OnClick="lbActividad_Click">Actividad Reciente</asp:LinkButton>
                    </li>
                    <li class="nav-item">
                        <asp:LinkButton ID="lbInfoPersonal" CssClass="nav-link bg-navy text-light" runat="server" OnClick="lbInfoPersonal_Click">Información Personal</asp:LinkButton>
                    </li>
                </ul>

                <!-- Contenido de cada Pestaña -->
                <asp:MultiView ID="MultiView1" runat="server">


                    <!-- Vista para Logros Obtenidos -->
                    <asp:View ID="ViewLogrosObtenidos" runat="server">
                        <asp:Label ID="lblNoLogros" runat="server" Text="Aún no has conseguido ningún logro. ¡Comienza a jugar para ganar logros y mejorar tu perfil!" Visible="False" CssClass="text-center" />

                        <!-- GridView para listar los logros del usuario -->
                        <asp:GridView ID="gvLogros" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="5"
                            OnPageIndexChanging="gvLogros_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField HeaderText="Logo">
                                    <ItemTemplate>
                                        <img src="Images/logo_juego4.jpg" style="height: 50px; width: 50px;" />
                                    </ItemTemplate>
                                    <ItemStyle CssClass="column-space" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="TituloJuego" HeaderText="Título">
                                    <ItemStyle CssClass="column-space" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NombreLogro" HeaderText="Logro">
                                    <ItemStyle CssClass="column-space" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DescripcionLogro" HeaderText="Descripción">
                                    <ItemStyle CssClass="column-space" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FechaDesbloqueo" HeaderText="Fecha" DataFormatString="{0:dd-MM-yyyy}">
                                    <ItemStyle CssClass="column-space" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>

                    </asp:View>




                    <!-- Vista para Actividad Reciente -->
                    <asp:View ID="ViewActividadReciente" runat="server">
                        <!-- Contenido de Actividad Reciente -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <div class="card bg-dark-subtle h-100">
                                    <img src="Images/portada_juego1.jpg" class="card-img-top img-fluid card-img-height" alt="Phasmophobia">
                                    <div class="card-body">
                                        <h5 class="card-title">Phasmophobia</h5>
                                        <p>Información del tiempo jugado desde que se compró. </p>
                                        <div class="progress mb-2">
                                            <div class="progress-bar" role="progressbar" style="width: 80%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="88"></div>
                                        </div>
                                        <p class="card-text">Última vez jugado: 2024-05-01</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card bg-dark-subtle h-100">
                                    <img src="Images/portada_juego3.jpg" class="card-img-top img-fluid card-img-height" alt="Dark Souls Remastered">
                                    <div class="card-body">
                                        <h5 class="card-title">Dark Souls Remastered</h5>
                                        <p>Información del tiempo jugado desde que se compró. </p>
                                        <div class="progress mb-2">
                                            <div class="progress-bar" role="progressbar" style="width: 21%;" aria-valuenow="21" aria-valuemin="0" aria-valuemax="98"></div>
                                        </div>
                                        <p class="card-text">Última vez jugado: 2024-04-29</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:View>




                    <!-- Vista para Información Personal -->
                    <asp:View ID="ViewInfoPersonal" runat="server">
                        <!-- Contenido de Información Personal -->
                        <div class="form-group row my-2">
                            <label for="txtNombre" class="col-sm-3 col-form-label">Nombre:</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" ReadOnly="true">John Doe</asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row my-2">
                            <label for="txtCorreo" class="col-sm-3 col-form-label">Correo electrónico:</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" ReadOnly="true">johndoe@example.com</asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row my-2">
                            <label for="txtTelefono" class="col-sm-3 col-form-label">Teléfono:</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" ReadOnly="true">1234567890</asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row my-2">
                            <label for="txtFechaNacimiento" class="col-sm-3 col-form-label">Fecha de nacimiento:</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" ReadOnly="true">01/01/1990</asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row my-2">
                            <div class="col-sm-12 text-right mt-4">
                                <asp:Button ID="btnEditarInfo" runat="server" Text="Editar Información" CssClass="btn btn-primary" />
                            </div>
                        </div>
                    </asp:View>




                </asp:MultiView>
            </div>
        </div>
    </div>
</asp:Content>