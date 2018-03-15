# Event handlers
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

this.toggleWatched = (video, watched) ->
  unless data.activePage == "searchPage"
    index = indexOfVideoID(video.id)

    if watched
      data.videos[index].watched = watched
    else
      data.videos[index].watched = !data.videos[index].watched

    updateUI "videoPartialView_#{video.id}", videoPartialInnerView(data.videos[index])
    updateUI "watchedButtonView_#{video.id}", watchedButtonView(data.videos[index])

    unless video.read_only
      request "POST", url("video_watch", video.id)

this.updateUI = (domID, newElement) ->
  for document in navigationDocument.documents
    if document.getElementsByTagName("menuBar").length > 0
      menuBar = document.getElementsByTagName("menuBar").item(0).getFeature("MenuBarDocument")
      selected = menuBar.getSelectedItem()
      menuDocument = menuBar.getDocument(selected)
      if element = menuDocument.getElementById(domID)
        element.innerHTML = newElement

    if element = document.getElementById(domID)
      element.innerHTML = newElement

# Utitlities
this.eventHandler = (event) ->
  target = event.target
  if action = elementAttribute(target, "action")
    handler = "#{event.type}#{action}"
    this[handler](event)

this.getVideoByID = (id) ->
  index = indexOfVideoID(id)
  data.videos[index]

this.getVideoFromElement = (element) ->
  id = elementAttribute(element, "videoID") * 1
  index = indexOfVideoID(id)
  data.videos[index]

this.indexOfVideoID = (id) ->
  id = id * 1
  data.videos.findIndex (video) ->
    video.id == id

this.elementAttribute = (element, attribute) ->
  if attr = element.attributes.getNamedItem(attribute)
    attr.value
  else
    null

this.debounce = (func, threshold, execAsap) ->
  timeout = null
  (args...) ->
    obj = this
    delayed = ->
      func.apply(obj, args) unless execAsap
      timeout = null
    if timeout
      clearTimeout(timeout)
    else if (execAsap)
      func.apply(obj, args)
    timeout = setTimeout delayed, threshold || 100

this.sleep = (time) ->
  new Promise (resolve, reject) ->
    setTimeout(resolve, time)
