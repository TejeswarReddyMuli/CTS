function addEvent(name){
    console.log(`${name} Added`);
}

function registerUser(user){
    console.log(`${user} Registered`);
}

function filterEventsByCategory(events, callback){
    return events.filter(callback);
}

function registrationTracker(){

    let count = 0;

    return function(){

        count++;

        console.log(`Total Registrations: ${count}`);

    };

}

const track = registrationTracker();

track();
track();

addEvent("Sports Meet");

registerUser("John");

const events = [
    {name:"Music Fest", category:"Music"},
    {name:"Sports Day", category:"Sports"}
];

const result =
filterEventsByCategory(
events,
event => event.category === "Music"
);

console.log(result);