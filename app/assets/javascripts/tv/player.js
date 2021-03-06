play = function(video, collection) {
  data.currentCollection = collection;
  video.toMediaItem().then(function(mediaItem) {
    data.player.playlist = new Playlist;
    data.player.playlist.push(mediaItem);
    data.player.play();
    enqueueNextItem();
  })
}

enqueueNextItem = function() {
  const currentVideo = getVideoByID(data.player.currentMediaItem.externalID, data.currentCollection);
  const nextVideo = getNextVideo(currentVideo, data.currentCollection);
  if (nextVideo && !playlistIncludes(nextVideo)) {
    nextVideo.toMediaItem().then(item => data.player.playlist.push(item));
  }
};

mediaItemDidChange = (event => enqueueNextItem());

mediaItemWillChange = function(event) {
  const shouldMarkWatched = ((event.reason === 1) || (event.reason === 2));
  if (shouldMarkWatched) {
    const video = getVideoByID(event.target.previousMediaItem.externalID, data.currentCollection);
    toggleWatched(video, true);
  }
};

timeDidChange = function(event) {
  const video = getVideoByID(event.target.currentMediaItem.externalID, data.currentCollection);
  const videoLength = video.duration_in_seconds;
  const currentTime = event.time;
  const percentLeft = (videoLength - currentTime) / videoLength;
  const shouldMarkWatched = ((percentLeft < 0.2) && (video.watched === false));
  if (shouldMarkWatched) {
    toggleWatched(video, true);
  }
};

playlistIncludes = function(video) {
  for (let index = data.player.playlist.length - 1; index >= 0; index--) {
    let item = data.player.playlist.item(index);
    let playlistVideo = getVideoByID(item.externalID, data.currentCollection);
    if (playlistVideo.id === video.id) {
      return true;
    }
  }
  return false;
}

