this.playHandler = (event) ->
  item = event.target.dataItem
  mediaItem = buildMediaItem(item)

  data.player.playlist = new Playlist
  data.player.playlist.push mediaItem
  data.player.play()
  enqueueNextItem(mediaItem)

this.enqueueNextItem = (mediaItem) ->
  index = mediaItem.externalID * 1 + 1
  next = data.dataItems[index]
  nextMediaItem = buildMediaItem(next)
  data.player.playlist.push nextMediaItem

this.buildMediaItem = (item) ->
  url = data.nativeCode.videoLocation(item.youtube_id)
  video = new MediaItem('video', url)
  video.title = item.data.title
  video.externalID = item.index
  video

this.mediaItemDidChange = (event) ->
  mediaItem = event.target.currentMediaItem
  enqueueNextItem(mediaItem)

this.mediaItemWillChange = (event) ->
  if event.reason == "fastForwardedToEndOfMediaItem" || "playedToEndOfMediaItem"
    mediaItem = event.target.currentMediaItem
    index = mediaItem.externalID * 1
    markAsWatched(index)

this.markAsWatched = (index) ->
  data.dataItems[index].watched = true
  item = data.dataItems[index]
  request "DELETE", url("mark_watched_tv_video", item.id)

this.url = (key, id = null) ->
  config.paths[key].replace("999", id)