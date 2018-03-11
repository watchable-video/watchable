this.play = (video) ->
  buildMediaItem(video)
    .then (mediaItem) ->
      data.player.playlist = new Playlist
      data.player.playlist.push mediaItem
      data.player.play()
      enqueueNextItem()

this.enqueueNextItem = () ->
  index = data.player.playlist.length - 1
  lastItem = data.player.playlist.item(index)
  currentIndex = indexOfVideoID(lastItem.externalID)
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

this.newMediaItem = (url, video) ->
  mediaItem = new MediaItem("video", url)
  mediaItem.externalID = video.id
  mediaItem.title = video.data.snippet.title
  mediaItem.subtitle = video.data.snippet.channel_title
  mediaItem.description = video.data.snippet.description
  mediaItem.artworkImageURL = video.poster_frame
  mediaItem

this.mediaItemDidChange = (event) ->
  enqueueNextItem()

this.mediaItemWillChange = (event) ->
  shouldMarkWatched = (event.reason == "fastForwardedToEndOfMediaItem" || event.reason == "playedToEndOfMediaItem")
  if shouldMarkWatched
    video = getVideoByID(event.target.previousMediaItem.externalID)
    toggleWatched(video, true)

this.timeDidChange = (event) ->
  video = getVideoByID(event.target.currentMediaItem.externalID)
  videoLength = video.data.duration
  currentTime = event.time
  percentLeft = (videoLength - currentTime) / videoLength
  shouldMarkWatched = (percentLeft < 0.15 && video.watched == false)
  if shouldMarkWatched
    toggleWatched(video, true)
