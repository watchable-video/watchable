this.data = {}

this.App.onLaunch = (options) ->
  data.options = options
  template = loading()
  navigationDocument.pushDocument template
  home()

this.home = ->
  request "GET", "/tv/videos.json"
    .then (response) ->
      render JSON.parse(response)
    .catch (error) ->
      console.log error
      template = alert "Unable to load videos", error
      navigationDocument.presentModal template

this.select = (event) ->
  item = event.target.dataItem
  template = videoTemplate item
  navigationDocument.pushDocument template

this.play = (event) ->
  item = event.target.dataItem

  nativeCode = Native.create()
  url = nativeCode.videoLocation(item.youtube_id)

  if url == ""
    template = alert "Error", "Unable to load video"
    navigationDocument.presentModal template
  else
    playVideo(url, item)

playVideo = (url, item, pop = true) ->
  player = new Player
  video = new MediaItem('video', url)
  video.title = item.data.title
  player.playlist = new Playlist
  player.playlist.push video
  player.play()


this.render = (videos) ->
  template = shelf()
  template.addEventListener "select", select
  template.addEventListener "play", play

  navigationDocument.clear()
  navigationDocument.pushDocument template

  shelfTag = template.getElementsByTagName("shelf").item(0)
  sectionTag = shelfTag.getElementsByTagName("section").item(0)
  sectionTag.dataItem = new DataItem

  data.dataItems = videos.map (video, index) ->
    item = new DataItem "video", video.id
    item.setPropertyPath "index", index
    for key, value of video
      item.setPropertyPath key, value
    item

  sectionTag.dataItem.setPropertyPath "items", data.dataItems
