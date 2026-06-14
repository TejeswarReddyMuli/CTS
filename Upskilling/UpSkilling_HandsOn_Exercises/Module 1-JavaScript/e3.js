const events = [
    {name:"Music Fest", seats:20, upcoming:true},
    {name:"Food Fair", seats:0, upcoming:true},
    {name:"Old Event", seats:15, upcoming:false}
];

events.forEach(event => {

    if(event.upcoming && event.seats > 0){
        document.getElementById("events").innerHTML +=
        `<p>${event.name}</p>`;
    }

});

try{

    let seats = 0;

    if(seats <= 0){
        throw "No Seats Available";
    }

}
catch(error){

    console.log(error);

}