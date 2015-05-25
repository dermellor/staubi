crumbLength = 5
padding =  10
vacuumSound = new buzz.sound('/vacuumcleaner.mp3');

Template.game.helpers
  crumbs: ->
    crumbs = for i in [0 ... crumbLength]
      do ->
        width: "#{100 / crumbLength + padding}%"
        left: "#{100 / crumbLength * i - padding}%"
    return crumbs


Template.game.events
  "click .crumbs" :  (event) ->
    $(event.target).addClass('zoomOutRight')
    vacuumSound.play()