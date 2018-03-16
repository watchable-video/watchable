this.data = {}

this.App.onLaunch = (options) ->
  data.options = options
  data.player = new Player
  data.player.addEventListener "mediaItemDidChange", mediaItemDidChange
  data.player.addEventListener "mediaItemWillChange", mediaItemWillChange
  data.player.addEventListener "timeDidChange", timeDidChange, {interval: 1}
  data.nativeCode = Native.create()

  setActiveDocument loadingView(), "push"

  if data.options.CLOUDKITID
    login()
  else
    setActiveDocument alertView("Error", "Please sign-in to iCloud in Settings and try again.")

this.setActiveDocument = (document, method = "replace") ->
  if method == "push"
    navigationDocument.pushDocument document
  else
    navigationDocument.replaceDocument(document, data.activeDocument)
  data.activeDocument = document

this.login = () ->
  request "GET", url("authenticate")
    .then (response) ->
      setActiveDocument menuView()
    .catch (error) ->
      retryLogin(error)

this.retryLogin = (error) ->
  if error.status == 404
    request "POST", url("activation_token")
      .then (response) ->
        data = JSON.parse(response)
        setActiveDocument loginView(data.token)

    poll "authenticate"
      .then (response) ->
        setActiveDocument loadingView("Loading your subscriptions…")
        poll "sync_status"
      .then (response) ->
        setActiveDocument menuView()
  else
    setActiveDocument alertView("Service Unavailable", "Please try again later.")

this.poll = (endpoint) ->
  new Promise (resolve, reject) ->
    intervalId = setInterval ( ->
      request "GET", url(endpoint)
        .then (response) ->
          clearInterval intervalId
          resolve(response)
    ), 2000

# this.App.onError
# A callback function that is automatically called when an error is sent from the Apple TV.
#
# this.App.onExit
# A callback function that is automatically called when the app has been exited.
#
# this.App.onLaunch
# A callback function that is automatically called when the app has been launched.
#
# this.App.onResume
# A callback function that is automatically called when the app moves to the foreground.
#
# this.App.onSuspend
# A callback function that is automatically called when the app is sent to the background.