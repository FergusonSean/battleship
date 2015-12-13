// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

window.battleship = {
  playerIndex: 0,
  currentPlayerIndex: 0,
  lastShotId: null
}

$(document).on("click", ".js-firing-grid .battleship__cell", function(e){
  if(battleship.currentPlayerIndex === battleship.playerIndex){
    $.post("/fire", { 
      shot: {
        x: $(e.target).data("x"),
        y: $(e.target).data("y"),
        player: (battleship.playerIndex + 1) % 2
      }
    }).done(function(data){
      $(".battleship__cell[data-x='"+data.x+"'][data-y='"+data.y+"']").addClass(data.result)
      battleship.currentPlayerIndex = (battleship.playerIndex + 1) % 2
    }).fail(function(data){
      console.log("fail", data);
    });
  } else {
    alert("It is not your turn!");
  }
})

setInterval(function(){
  $.get("last_shot?player="+ battleship.playerIndex).done(function(data){
    if(data && data.id != lastShotId) {
      shot_cell = $(".js-my-grid "+
                    ".battleship__row:nth-child("+(data.x + 1)+") " +
                    ".battleship__cell:nth-child("+(data.y + 1)+")")
      shot_cell.addClass(data.result)

      battleship.currentPlayerIndex = (battleship.currentPlayerIndex + 1) % 2
      battleship.lastShotId = data.id
    }
  })

}, 2000)
