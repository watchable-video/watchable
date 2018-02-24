this.App.onLaunch = (options) ->
  modal = alert("Hello!", "It's working!")
  navigationDocument.presentModal(modal);