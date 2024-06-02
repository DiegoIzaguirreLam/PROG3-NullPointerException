<%@ Page Title=""
    Language="C#"
    MasterPageFile="~/Steam.Master"
    AutoEventWireup="true"
    CodeBehind="Perfil.aspx.cs"
    Inherits="SteamWA.Perfil" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/bootstrap.css" rel="stylesheet" />
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <div class="card mb-3">
                    <img src="Images/user_profile_picture.jpg" class="card-img-top" alt="Avatar del Usuario">
                    <div class="card-body bg-dark-subtle">
                        <h5 class="card-title">PlayerUsername0884</h5>
                        <p class="card-text text-muted">
                            <i class="fa-solid fa-certificate" style="color: green;"></i> <span style="color: green;">Verificado por Steam</span>
                        </p>
                        <div class="online-indicator bg-success"></div>
                        <ul>
                            <li>UID: 45679764</li>
                            <li>Correo: 0884@gmail.com</li>
                            <li>Teléfono: 987127675</li>
                            <li>Fecha Nacimiento: 29/07/1989</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link active bg-dark-subtle" href="#">Actividad Reciente</a>
                    </li>
                    <!-- Posiblemente añadir una pestaña de Información Personal -->
                </ul>
                <div class="row mt-3">
                    <div class="col-md-6">
                        <div class="card bg-dark-subtle">
                            <img src="Images/portada_juego1.jpg" class="card-img-top img-fluid" alt="Phasmophobia">
                            <div class="card-body">
                                <h5 class="card-title">Phasmophobia</h5>
                                <p> Información del tiempo jugado desde que se compró. </p>
                                <div class="progress mb-2">
                                    <div class="progress-bar" role="progressbar" style="width: 80%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="88"></div>
                                </div>
                                <p class="card-text">Última vez jugado: 2024-05-01</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card bg-dark-subtle">
                            <img src="Images/portada_juego3.jpg" class="card-img-top img-fluid" alt="Dark Souls Remastered">
                            <div class="card-body">
                                <h5 class="card-title">Dark Souls Remastered</h5>
                                <p> Información del tiempo jugado desde que se compró. </p>
                                <div class="progress mb-2">
                                    <div class="progress-bar" role="progressbar" style="width: 21%;" aria-valuenow="21" aria-valuemin="0" aria-valuemax="98"></div>
                                </div>
                                <p class="card-text">Última vez jugado: 2024-04-29</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
