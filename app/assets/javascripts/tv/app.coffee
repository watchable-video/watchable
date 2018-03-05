this.data = {}

this.App.onLaunch = (options) ->
  data.options = options
  data.player = new Player
  data.player.addEventListener "mediaItemDidChange", mediaItemDidChange
  data.player.addEventListener "mediaItemWillChange", mediaItemWillChange
  data.nativeCode = Native.create()

  loading = loadingView()
  navigationDocument.pushDocument loading

  menu = menuView()
  navigationDocument.replaceDocument(menu, loading)



  # home()

this.search = (menuItem, menuItemDocument) ->
  template = searchView()
  menuItemDocument.setDocument(template, menuItem)


this.subscriptions = (menuItem, menuItemDocument) ->
  request "GET", url("videos")
    .then (response) ->
      data.videos = JSON.parse(response)
      template = shelfView(data.videos)
      menuItemDocument.setDocument(template, menuItem)

    .catch (error) ->
      console.log error
      template = alertView "Unable to load videos", error
      navigationDocument.presentModal template

this.getVideoFromLockup = (lockup) ->
  id = lockup.attributes.getNamedItem("id").value * 1
  index = indexOfVideoID(id)
  data.videos[index]

this.indexOfVideoID = (id) ->
  data.videos.findIndex (video) ->
    video.id == id



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