this.data = {}

this.App.onLaunch = (options) ->
  data.options = options
  template = loading()

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
      template = alert "Unable to load videos", error
      navigationDocument.presentModal template

this.selectHandler = (event) ->
  item = event.target.dataItem
  template = videoTemplate item
  navigationDocument.pushDocument template

this.render = (videos) ->
  template = shelf()
  template.addEventListener "select", selectHandler
  template.addEventListener "play", playHandler

  navigationDocument.clear()
  navigationDocument.pushDocument template

  shelfTag = template.getElementsByTagName("shelf").item(0)
  sectionTag = shelfTag.getElementsByTagName("section").item(0)
  sectionTag.dataItem = new DataItem

  data.dataItems = videos.map (video, index) ->
    item = new DataItem "video", video.id
    item.setPropertyPath "index", index
    if video.watched
      item.setPropertyPath "watchedNew", "Watched"
    else
      item.setPropertyPath "watchedNew", "Not Watched"

    for key, value of video
      item.setPropertyPath key, value
    item

  sectionTag.dataItem.setPropertyPath "items", data.dataItems
