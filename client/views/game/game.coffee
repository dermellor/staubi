crumbleLength = 5
padding =  10
height = 10

Session.set('crumbleAmount', crumbleLength);

getCrumbleAmount = ->
  Session.get('crumbleAmount')

resetCrumbles = ->
  Session.set('crumbleAmount', crumbleLength)

checkCrumble = ->
  Session.set('crumbleAmount', getCrumbleAmount() - 1)

Template.game.helpers
  crumbs: ->
    crumbs = for i in [0 ... crumbleLength]
      do ->
        width: "#{100 / crumbleLength + padding}%"
        left: "#{100 / crumbleLength * i - padding}%"
        top: "#{100 * Math.random() - height}%"
        height: "#{height}%"
    return crumbs
  finished: ->
    (getCrumbleAmount() == 0)



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
      checkCrumble()
    , 1500
    vacuumSound.play()
  "click .replay" : ->
    resetCrumbles()