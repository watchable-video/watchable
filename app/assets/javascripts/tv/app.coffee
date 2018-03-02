this.data = {}

this.App.onLaunch = (options) ->
  data.options = options
  template = loading()
  navigationDocument.pushDocument(template)
  home()

this.home = ->
  request("GET", "/tv/videos.json").then((response) ->
    render JSON.parse(response)
  ).catch((error) ->
    console.log "error"
    template = alert("Unable to load videos", error)
    navigationDocument.presentModal(template)
  )

this.select = (event) ->
  item = event.target.dataItem
  console.log item

this.render = (videos) ->
  template = shelf()
  template.addEventListener "select", select

  navigationDocument.clear()
  navigationDocument.pushDocument template

  shelfTag = template.getElementsByTagName("shelf").item(0)
  sectionTag = shelfTag.getElementsByTagName("section").item(0)
  sectionTag.dataItem = new DataItem

  data.dataItems = videos.map (video, index) ->
    item = new DataItem("video", video.id)
    item.setPropertyPath("index", index)
    for key, value of video
      item.setPropertyPath(key, value)
    item

  sectionTag.dataItem.setPropertyPath "items", data.dataItems
