this.data = {}

this.App.onLaunch = (options) ->
  data.options = options
  data.player = new Player
  data.player.addEventListener "mediaItemDidChange", mediaItemDidChange
  data.player.addEventListener "mediaItemWillChange", mediaItemWillChange
  data.player.addEventListener "timeDidChange", timeDidChange, {interval: 1}
  data.nativeCode = Native.create()

  loading = loadingView()
  navigationDocument.pushDocument loading

  if data.options.CLOUDKITID
    login(loading)
  else
    alert = alertView("Error", "Please sign-in to iCloud in Settings and try again.")
    navigationDocument.replaceDocument(alert, loading)

this.login = (initialDocument) ->
  request "GET", url("authenticate")
    .then (response) ->
      loadInterface(initialDocument, false)
    .catch (error) ->
      retryLogin(error, initialDocument)

this.retryLogin = (error, initialDocument) ->
  if error.status == 404
    login = loginView()
    navigationDocument.replaceDocument(login, initialDocument)
    intervalId = setInterval ( ->
      request "GET", url("authenticate")
        .then (response) ->
          clearInterval intervalId
          loadInterface(initialDocument, true)
    ), 2000
  else
    alert = alertView("Serivce Unavailable", "Please try again later.")
    navigationDocument.replaceDocument(alert, initialDocument)

this.loadInterface = (initialDocument, wait) ->
  showMenu = (initial) ->
    menu = menuView()
    navigationDocument.replaceDocument(menu, initial)

  if wait
    loading = loadingView()
    navigationDocument.replaceDocument(loading, initialDocument)
    sleep(10000)
      .then (result) ->
        showMenu(loading)
  else
    showMenu(initialDocument)


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