# Event handlers
this.selectLoadPage = (event) ->
  menuItemDocument = event.target.parentNode.getFeature("MenuBarDocument")
  page = elementAttribute(event.target, "page")
  this[page](event.target, menuItemDocument)

this.selectVideoLockup = (event) ->
  video = getVideoFromElement event.target
  template = videoDetailView video
  navigationDocument.pushDocument template

this.playVideoLockup = (event) ->
  video = getVideoFromElement event.target
  play(video)

this.playVideoPlay = (event) ->
  video = getVideoFromElement event.target
  play(video)

this.selectVideoPlay = (event) ->
  video = getVideoFromElement event.target
  play(video)

this.playToggleWatched = (event) ->
  video = getVideoFromElement event.target
  toggleWatched(video.id)

this.selectToggleWatched = (event) ->
  video = getVideoFromElement event.target
  toggleWatched(video.id)

# Utitlities
this.eventHandler = (event) ->
  target = event.target
  if action = elementAttribute(target, "action")
    handler = "#{event.type}#{action}"
    this[handler](event)

this.getVideoFromElement = (element) ->
  id = elementAttribute(element, "videoID") * 1
  index = indexOfVideoID(id)
  data.videos[index]

this.indexOfVideoID = (id) ->
  data.videos.findIndex (video) ->
    video.id == id

this.elementAttribute = (element, attribute) ->
  if attr = element.attributes.getNamedItem(attribute)
    attr.value
  else
    null
