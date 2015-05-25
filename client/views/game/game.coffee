crumbLength = 5
padding =  10
height = 10

Template.game.helpers
  crumbs: ->
    crumbs = for i in [0 ... crumbLength]
      do ->
        width: "#{100 / crumbLength + padding}%"
        left: "#{100 / crumbLength * i - padding}%"
        top: "#{100 * Math.random() - height}%"
        height: "#{height}%"
    return crumbs


Template.game.events
  "click .crumbs" :  (event) ->
    vacuumSound = new buzz.sound('/vacuumcleaner.mp3');
    staubiImage = $('.staubi')
    position =
      top: rwindow.innerHeight() * (parseInt(@.top) / 100) - (Math.round(staubiImage.height()) * 0.9)
      left: rwindow.innerWidth() * (parseInt(@.left) / 100) + (Math.round(staubiImage.width()) / 2)
    staubiImage.css
        transform: "translate(#{position.left}px, #{position.top}px)"
    staubiImage.find('.animated').removeClass('wobble')
    setTimeout ->
      staubiImage.find('.animated').addClass('wobble')
      $(event.target).addClass('zoomOutRight')
    , 1500
    vacuumSound.play()