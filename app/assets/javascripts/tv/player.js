play = function(video) {
  video.toMediaItem().then(function(mediaItem) {
    data.player.playlist = new Playlist;
    data.player.playlist.push(mediaItem);
    data.player.play();
    enqueueNextItem();
  })
}

enqueueNextItem = function() {
  const index = data.player.playlist.length - 1;
  const lastItem = data.player.playlist.item(index);
  const currentIndex = indexOfVideoID(lastItem.externalID);
  const nextVideo = data.videos[currentIndex + 1];
  nextVideo.toMediaItem().then(item => data.player.playlist.push(item));
};

mediaItemDidChange = (event => enqueueNextItem());

mediaItemWillChange = function(event) {
  const shouldMarkWatched = ((event.reason === 1) || (event.reason === 2));
  if (shouldMarkWatched) {
    const video = getVideoByID(event.target.previousMediaItem.externalID);
    toggleWatched(video, true);
  }
};

timeDidChange = function(event) {
  const video = getVideoByID(event.target.currentMediaItem.externalID);
  const videoLength = video.duration_in_seconds;
  const currentTime = event.time;
  const percentLeft = (videoLength - currentTime) / videoLength;
  const shouldMarkWatched = ((percentLeft < 0.2) && (video.watched === false));
  if (shouldMarkWatched) {
    toggleWatched(video, true);
  }
};
