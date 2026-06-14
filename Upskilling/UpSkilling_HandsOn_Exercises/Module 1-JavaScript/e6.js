let events = [];

events.push({
    name:"Music Festival",
    category:"Music"
});

events.push({
    name:"Baking Workshop",
    category:"Workshop"
});

events.push({
    name:"Rock Concert",
    category:"Music"
});

const musicEvents =
events.filter(
event => event.category === "Music"
);

console.log(musicEvents);

const displayCards =
events.map(
event => `Workshop on ${event.name}`
);

console.log(displayCards);