//This will containg the backbone or javascript object for the games models.
alert('Testing')
var Game = Backbone.Model.extend(function(){

})

var game = new Game({
    title: baked.title,
    link: baked.link,
    description: baked.description
})

rivets.bind(document.getElementById('main'), {
  game: game

})

