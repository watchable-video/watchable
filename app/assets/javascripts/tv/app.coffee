this.data = {}

this.App.onLaunch = (options) ->
  data.options = options
  template = loadingView()

  data.player = new Player
  data.player.addEventListener "mediaItemDidChange", mediaItemDidChange
  data.player.addEventListener "mediaItemWillChange", mediaItemWillChange

  data.nativeCode = Native.create()

  navigationDocument.pushDocument template
  home()

this.home = ->
  request "GET", "/tv/videos.json"
    .then (response) ->
      render JSON.parse(response)
    .catch (error) ->
      console.log error
      template = alertView "Unable to load videos", error
      navigationDocument.presentModal template

this.render = (videos) ->
  data.videos = videos
  template = shelfView(data.videos)

  navigationDocument.clear()
  navigationDocument.pushDocument template

this.getVideoFromLockup = (lockup) ->
  id = lockup.attributes.getNamedItem("id").value * 1
  index = indexOfVideoID(id)
  data.videos[index]

this.indexOfVideoID = (id) ->
  data.videos.findIndex (video) ->
    video.id == id
