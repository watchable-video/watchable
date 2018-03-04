this.playHandler = (event) ->
  video = getVideoFromLockup(event.target)
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
    markAsWatched(id)

this.markAsWatched = (id) ->
  request "POST", url("tv_video_watch", id)

this.url = (key, id = null) ->
  config.paths[key].replace("999", id)

