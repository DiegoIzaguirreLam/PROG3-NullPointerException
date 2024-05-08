<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="GestionarSubforo.aspx.cs" Inherits="SteamWA.GestionarSubforo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/crearForo.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container fontSetterExo2">
        <div class="row align-items-center">
            <div class="col-md-7 row align-items-center">
                <div class="col-md-auto align-items-lg-start">
                    <asp:Button ID="return" CssClass="h5 bg-transparent border-0" runat="server" Text="Comunidad" OnClick="btnVolverComunidad_Click" />
                    <i class="fa-solid fa-caret-right fa-1x" style="color: #ffffff;"></i>
                </div>
                <div class="col-md-auto align-items-lg-start">
                    <asp:Button ID="nombreForo" CssClass="h5 bg-transparent border-0" runat="server" Text="Comunidad" OnClick="btnVolverForo_Click" />
                    <i class="fa-solid fa-caret-right fa-1x" style="color: #ffffff;"></i>
                </div>
                <div class="col-md-auto justify-content-md-start">
                    <asp:Button ID="subforo" CssClass="h5 bg-transparent border-0" runat="server" Text="Comunidad" OnClick="btnActualizarSubforo_Click"/>
                </div>
            </div>
            <div class="col text-end">
                <asp:Button ID="btnCrearForo" CssClass="btn btn-dark col-sm-4 border-light" runat="server" Text="Crear Hilo" OnClick="btnCrearHilo_Click" />
            </div>
        </div>
    </div>
    <hr />
    <div class="container row fontSetterExo2">
        <asp:GridView ID="foros" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-responsive table-striped">
            <Columns>
                <asp:BoundField HeaderText="Nombre" DataField="nombre" />
                <%--Se mostrará el primer mensaje del hilo fijado en el foro--%>
                <asp:BoundField HeaderText="Mensaje" DataField="mensaje" />
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <div class="row mt-4 fontSetterExo2">
        <!-- tarjeta 1 -->
        <div class="col-md-4">
            <div class="card bg-dark-subtle border-black">
                <img src="https://assetsio.gnwcdn.com/2x1_NSwitchDS_BatmanArkhamTrilogy.jpg?width=690&quality=75&format=jpg&dpr=2&auto=webp" height="200" class="card-img-top" alt="Juego 1">
                <div class="card-body bg-dark">
                    <h6 class="card-title" style="color: white">¿Es un buen juego? - GianLukaGG
                        <img src="https://avatars.akamai.steamstatic.com/f698ccb1d89632d7f174c142b789b84d4ec2dab6_full.jpg" width="20" height="20" />
                    </h6>
                    <p class="card-text" style="color: white">
                        El mejor juego!
                        - Sr. Tomasto
                        <img src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/items/408410/0538306fa1cafff1035d125ebbe745f1f9ce2236.gif" width="20" height="20" />
                    </p>
                    <asp:Button ID="btn3" CssClass="btn btn-light col-sm-4 border-light fontSetterExo2" runat="server" Text="Abrir Hilo" OnClick="btnAbrirHilo_Click" />
                </div>
            </div>
        </div>
        <!-- tarjeta 2 -->
        <div class="col-md-4">
            <div class="card bg-dark-subtle border-black">
                <img src="https://cdn.hobbyconsolas.com/sites/navi.axelspringer.es/public/media/image/2013/10/256944-analisis-batman-arkham-origins.jpg?tf=1920x" height="200" class="card-img-top" alt="Juego 1">
                <div class="card-body bg-dark">
                    <h6 class="card-title" style="color: white">¿Es un buen juego? - GianLukaGG
                <img src="https://avatars.akamai.steamstatic.com/f698ccb1d89632d7f174c142b789b84d4ec2dab6_full.jpg" width="20" height="20" />
                    </h6>
                    <p class="card-text" style="color: white">
                        El mejor juego!
                - Sr. Tomasto
                <img src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/items/408410/0538306fa1cafff1035d125ebbe745f1f9ce2236.gif" width="20" height="20" />
                    </p>
                    <asp:Button ID="btn2" CssClass="btn btn-light col-sm-4 border-light fontSetterExo2" runat="server" Text="Abrir Hilo" OnClick="btnAbrirHilo_Click" />
                </div>
            </div>
        </div>
        <!-- tarjeta 3 -->
        <div class="col-md-4">
            <div class="card bg-dark-subtle border-black">
                <img src="https://articles-img.sftcdn.net/t_article_cover_xl/auto-mapping-folder/sites/2/2023/12/batman-arkham-knight.jpg" height="200" class="card-img-top" alt="Juego 1">
                <div class="card-body bg-dark">
                    <h6 class="card-title" style="color: white">¿Es un buen juego? - GianLukaGG
                <img src="https://avatars.akamai.steamstatic.com/f698ccb1d89632d7f174c142b789b84d4ec2dab6_full.jpg" width="20" height="20" />
                    </h6>
                    <p class="card-text" style="color: white">
                        El mejor juego!
                - Sr. Tomasto
                <img src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/items/408410/0538306fa1cafff1035d125ebbe745f1f9ce2236.gif" width="20" height="20" />
                    </p>
                    <asp:Button ID="btn1" CssClass="btn btn-light col-sm-4 border-light fontSetterExo2" runat="server" Text="Abrir Hilo" OnClick="btnAbrirHilo_Click" />
                </div>
            </div>
        </div>
        <!-- mas tarjetas -->
    </div>
    <%--Clase modal para la creación de un Hilo--%>
    <div class="modal border-white fade fontSetterExo2" id="form-modal-hilo">
        <div class="modal-dialog">
            <div class="modal-content bg-secondary bg-opacity-50">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title border-white">Creador de Hilos</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content">
                    <div class="container bg-dark">
                        <div class="container row">
                            <div class="mb-3">
                                <asp:Label ID="lblMensajeInicial" runat="server" Text="Mensaje:" CssClass="col-sm-3 col-form-label mt-1" />
                                <div class="col-sm-12">
                                    <asp:TextBox ID="txtMensajeInicial" runat="server" CssClass="form-control mt-1" Height="150" />
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
                                    CssClass="float-end btn btn-secondary bg-dark mb-2" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--Clase modal para la lectura y edición de un Hilo--%>
    <div class="modal border-white fade fontSetterExo2" id="form-modal-hilo-lector">
        <div class="modal-dialog">
            <div class="modal-content bg-secondary bg-opacity-50">
                <div class="modal-header bg-dark">
                    <h6 class="modal-title border-white col-8">¿Es un buen juego? - GianLukaGG</h6>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-content">
                    <div class="container bg-dark">
                        <div class="container row">
                            <div class="col-md-7">
                                <p class="mt-3">El mejor juego!</p>
                            </div>
                            <div class="col-md-5 text-end">
                                <p class="mt-3">
                                    - Sr. Tomasto
                                     <img src="https://cdn.akamai.steamstatic.com/steamcommunity/public/images/items/408410/0538306fa1cafff1035d125ebbe745f1f9ce2236.gif" width="20" height="20" />
                                </p>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="col-md-7">
                                <p class="mt-3">Es muy god!</p>
                            </div>
                            <div class="col-md-5 text-end">
                                <p class="mt-3">
                                    - Princesa Loopy
                                    <img src="Images/loopy.jpg" width="20" height="20" />
                                </p>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="col-md-7">
                                <p class="mt-3">El peor juego!</p>
                            </div>
                            <div class="col-md-5 text-end">
                                <p class="mt-3">
                                    - Sr. Tomasto Nojao
                                    <img src="Images/Captura%20de%20pantalla%202024-05-07%20185034.png" width="20" height="20" />
                                </p>
                            </div>
                        </div>
                        <div class="container row">
                            <div class="col-md-7">
                                <p class="mt-3">El mejor mejor juego!</p>
                            </div>
                            <div class="col-md-5 text-end">
                                <p class="mt-3">
                                    - Sr. Tomasto Feli
                                    <img src="Images/Captura%20de%20pantalla%202024-05-07%20185011.png" width="20" height="20" />
                                </p>
                            </div>
                        </div>
                        <div class="container row">
                            <asp:TextBox runat="server" CssClass="col-12 mb-3 rounded"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
