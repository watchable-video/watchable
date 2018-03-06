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

this.toggleWatched = (id, watched) ->
  index = indexOfVideoID(id)

  if watched
    data.videos[index].watched = watched
  else
    data.videos[index].watched = !data.videos[index].watched

  newView = videoPartialView(data.videos[index])

  for doc in navigationDocument.documents

    if doc.getElementsByTagName("menuBar").length > 0
      menuBar = doc.getElementsByTagName("menuBar").item(0).getFeature("MenuBarDocument")
      selected = menuBar.getSelectedItem()
      menuDoc = menuBar.getDocument(selected)
      if lockup = menuDoc.getElementById("lockup_#{id}")
        lockup.outerHTML = newView

    if button = doc.getElementById("watchedButton_#{id}")
      title = button.getElementsByTagName("title").item(0)
      if title.textContent == "Watched"
        newText = "Unwatched"
      else
        newText = "Watched"
      title.textContent = newText


  request "POST", url("video_watch", id)


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