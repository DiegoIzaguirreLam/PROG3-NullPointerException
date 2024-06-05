function filtrarAmigos() {
    var input = document.getElementById('buscarAmigosInput');
    var filter = input.value.toLowerCase();
    var cards = document.getElementsByClassName('amigo-card');

    for (var i = 0; i < cards.length; ++i) {
        var card = cards[i];
        var nombrePerfil = card.getElementsByClassName('card-title')[0].innerText.toLowerCase();

        if (nombrePerfil.includes(filter)) {
            card.parentElement.style.display = "";
        } else {
            card.parentElement.style.display = "none";
        }
    }
}