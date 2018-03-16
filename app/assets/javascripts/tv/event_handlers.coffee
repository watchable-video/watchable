this.eventHandler = (event) ->
  target = event.target
  if action = elementAttribute(target, "action")
    handler = "#{event.type}#{action}"
    this[handler](event)

this.selectLoadPage = (event) ->
  menuItemDocument = event.target.parentNode.getFeature("MenuBarDocument")
  page = elementAttribute(event.target, "page")
  this[page](event.target, menuItemDocument)

this.selectVideoLockup = (event) ->
  video = getVideoFromElement event.target
  template = videoDetailView video
  setActiveDocument template, "push"

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
  toggleWatched(video)

this.selectToggleWatched = (event) ->
  video = getVideoFromElement event.target
  toggleWatched(video)
