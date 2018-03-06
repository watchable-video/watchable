this.play = (video) ->
  mediaItem = buildMediaItem(video)

  data.player.playlist = new Playlist
  data.player.playlist.push mediaItem
  data.player.play()
  enqueueNextItem(mediaItem)

this.enqueueNextItem = (mediaItem) ->
  id = mediaItem.externalID * 1
  currentIndex = indexOfVideoID(id)
  nextVideo = data.videos[currentIndex + 1]
  nextMediaItem = buildMediaItem(nextVideo)
  data.player.playlist.push nextMediaItem

this.buildMediaItem = (video) ->
  url = data.nativeCode.videoLocation(video.youtube_id)
  mediaItem = new MediaItem('video', url)
  mediaItem.title = video.data.title
  mediaItem.externalID = video.id
  mediaItem

this.mediaItemDidChange = (event) ->
  mediaItem = event.target.currentMediaItem
  enqueueNextItem(mediaItem)

this.mediaItemWillChange = (event) ->
  if event.reason == "fastForwardedToEndOfMediaItem" || "playedToEndOfMediaItem"
    mediaItem = event.target.currentMediaItem
    id = mediaItem.externalID * 1
    toggleWatched(id, true)

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
