document.body.style.backgroundColor = '#24282f';

function autoCompletarBarraBusqueda(item) {
    const autocompleteInput = document.getElementById("search_autocomplete")
    autocompleteInput.value = item

}
//Se ejecuta cuando la pagin ya se ha cargado
window.onload = function () {
    const suggestionsList = document.querySelector('#suggestions');
    suggestionsList.style.visibility = "hidden"
    const autocompleteInput = document.getElementById("search_autocomplete")
    const data = ['Dark souls 1', 'Elden Ring', 'Batman Arkham Origins', 'Hollow Knight', 'Phasmophobia'];

    // Función para filtrar los resultados
    const dataFilter = (value) => {
        return data.filter((item) => {
            return item.toLowerCase().includes(value.toLowerCase());
        });
    };

    // Evento de entrada en el campo de búsqueda
    autocompleteInput.addEventListener('input', () => {
        const inputValue = autocompleteInput.value;
        const filteredData = dataFilter(inputValue);

        suggestionsList.innerHTML = '';
        if (inputValue === "") {
            suggestionsList.style.visibility = "hidden"
        } else {


            // Agrega las sugerencias filtradas a la lista desplegable
            if (filteredData.length === 0) {
                suggestionsList.style.visibility = "hidden";
            } else {
                filteredData.forEach((item) => {
                    console.log("ad");


                    const option = document.createElement('li');
                    const option2 = document.createElement('a');
                    option2.setAttribute("class", "dropdown-item desplegableBusqueda");
                    aut = "autoCompletarBarraBusqueda(" + "'" + item + "'" + ")"
                    option2.setAttribute("onclick", aut)
                    option2.innerHTML = item
                    option.appendChild(option2)

                    suggestionsList.appendChild(option);

                    suggestionsList.style.visibility = "visible"


                });
            }
            console.log(filteredData);
        }
    });
}

window.onload = function () {
    
}



function desplegarFiltros() {


    new bootstrap.Collapse(document.getElementById('desplegableFiltro'), { toggle: true });


}

function enviarInformacion(info) {
    var json = JSON.parse(info)
    const contenedor = document.getElementById("contenedorProductos");
    contenedor.innerHTML = "";
    console.log(json);
    for (var i = 0; i < json.length; i++) {
        var id = json[i].idProducto;
        console.log(id);
        
        const card = document.createElement("div");
        card.setAttribute("class", "col-md-4");
        card.innerHTML = `<div class="card bg-dark-subtle border-shadow mb-4 ` + "contenedor" + id + ` ">
                <img src=`+ json[i].portadaUrl+` height="200" class="card-img-top" alt="Juego 3">
                   
            </div>`

        contenedor.appendChild(card);
        var el = document.querySelector(".contenedor" + id);
        el.innerHTML += `<div class="card-body">
                        <h5 class="card-title">`+ json[i].titulo +`</h5>
                        <p class="card-text">`+json[i].descripcion+`</p>
                        <p class="card-text">Precio: `+ parseFloat(json[i].precio) +`</p>
                          <asp:LinkButton ID="btnCarrito`+ id +`" class="btn btn-primary" 
                            runat="server" OnClick="btnCarrito1_Click"
                            data-bs-toggle="modal" data-bs-target="#form-modal-añadido-carrito">Añadir al Carrito</asp:LinkButton> 
                    </div>`;
    }
}


function guardarPosicionDesplazamiento() {
    var posicionDesplazamiento = window.pageYOffset || document.documentElement.scrollTop;
    sessionStorage.setItem('posicionDesplazamiento', posicionDesplazamiento);
}

// Función para restaurar la posición de desplazamiento guardada
function restaurarPosicionDesplazamiento() {
    var posicionDesplazamiento = sessionStorage.getItem('posicionDesplazamiento');
    if (posicionDesplazamiento !== null) {
        window.scrollTo(0, posicionDesplazamiento);
        sessionStorage.removeItem('posicionDesplazamiento');
    }
}

