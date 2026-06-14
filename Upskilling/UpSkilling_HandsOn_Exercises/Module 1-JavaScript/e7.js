const container =
document.querySelector("#eventContainer");

const card =
document.createElement("div");

card.className = "eventCard";

card.innerHTML =
"<h3>Music Festival</h3><p>Seats Available: 20</p>";

container.appendChild(card);

function registerEvent(){

    card.innerHTML =
    "<h3>Music Festival</h3><p>Registered Successfully</p>";

}

function cancelEvent(){

    card.innerHTML =
    "<h3>Music Festival</h3><p>Registration Cancelled</p>";

}