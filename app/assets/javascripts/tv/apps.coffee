window.App.onLaunch = (options) ->
  alert = new Alert "Hello!", "It's working!"
  navigationDocument.presentModal(alert);