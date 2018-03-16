this.toggleWatched = (video, watched) ->
  unless data.activePage == "searchPage"
    index = indexOfVideoID(video.id)

    if watched
      data.videos[index].watched = watched
    else
      data.videos[index].watched = !data.videos[index].watched

    updateElement "videoPartialView_#{video.id}", videoPartialInnerView(data.videos[index])
    updateElement "watchedButtonView_#{video.id}", watchedButtonView(data.videos[index])

    unless video.read_only
      request "POST", url("video_watch", video.id)

this.updateElement = (id, newElement) ->
  for document in navigationDocument.documents
    if document.getElementsByTagName("menuBar").length > 0
      menuBar = document.getElementsByTagName("menuBar").item(0).getFeature("MenuBarDocument")
      selected = menuBar.getSelectedItem()
      menuDocument = menuBar.getDocument(selected)
      if oldElement = menuDocument.getElementById(id)
        oldElement.innerHTML = newElement

    if oldElement = document.getElementById(id)
      oldElement.innerHTML = newElement

this.setActiveDocument = (document, method = "replace") ->
  if method == "push"
    navigationDocument.pushDocument document
  else
    navigationDocument.replaceDocument(document, data.activeDocument)
  data.activeDocument = document

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

this.poll = (endpoint) ->
  new Promise (resolve, reject) ->
    intervalId = setInterval ( ->
      request "GET", url(endpoint)
        .then (response) ->
          clearInterval intervalId
          resolve(response)
    ), 2000

this.sleep = (time) ->
  new Promise (resolve, reject) ->
    setTimeout(resolve, time)
