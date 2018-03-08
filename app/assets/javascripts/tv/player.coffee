this.play = (video) ->
  buildMediaItem(video)
    .then (mediaItem) ->
      data.player.playlist = new Playlist
      data.player.playlist.push mediaItem
      data.player.play()
      enqueueNextItem(mediaItem)

this.enqueueNextItem = (mediaItem) ->
  id = mediaItem.externalID * 1
  currentIndex = indexOfVideoID(id)
  nextVideo = data.videos[currentIndex + 1]
  buildMediaItem(nextVideo)
    .then (nextMediaItem) ->
      data.player.playlist.push nextMediaItem

this.buildMediaItem = (video) ->
  new Promise (resolve, reject) ->
    location = data.nativeCode.videoLocation(video.youtube_id)
    if location == ""
      uri = url("media_location").addSearch({youtube_id: video.youtube_id})
      request "GET", uri
        .then (response) ->
          data = JSON.parse(response)
          resolve(newMediaItem(data["location"], video))
    else
      resolve(newMediaItem(location, video))

this.mediaItemDidChange = (event) ->
  mediaItem = event.target.currentMediaItem
  enqueueNextItem(mediaItem)

this.mediaItemWillChange = (event) ->
  if event.reason == "fastForwardedToEndOfMediaItem" || "playedToEndOfMediaItem"
    mediaItem = event.target.currentMediaItem
    id = mediaItem.externalID * 1
    index = indexOfVideoID(id)
    video = data.videos[index]
    toggleWatched(video.id, true)

this.newMediaItem = (url, video) ->
  mediaItem = new MediaItem('video', url)
  mediaItem.title = video.data.title
  mediaItem.externalID = video.id
  mediaItem