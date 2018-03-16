this.play = video => buildMediaItem(video)
  .then(function(mediaItem) {
    data.player.playlist = new Playlist;
    data.player.playlist.push(mediaItem);
    data.player.play();
    enqueueNextItem();
  }
);

this.enqueueNextItem = function() {
  const index = data.player.playlist.length - 1;
  const lastItem = data.player.playlist.item(index);
  const currentIndex = indexOfVideoID(lastItem.externalID);
  const nextVideo = data.videos[currentIndex + 1];
  buildMediaItem(nextVideo)
    .then(nextMediaItem => data.player.playlist.push(nextMediaItem));
};

this.buildMediaItem = video => new Promise(function(resolve, reject) {
  const location = data.nativeCode.videoLocation(video.youtube_id);
  if (location === "") {
    const uri = url("media_location").addSearch({youtube_id: video.youtube_id});
    request("GET", uri).then(function(response) {
      const data = JSON.parse(response);
      resolve(newMediaItem(data["location"], video));
    });
  } else {
    return resolve(newMediaItem(location, video));
  }
});

this.newMediaItem = function(url, video) {
  const mediaItem = new MediaItem("video", url);
  mediaItem.externalID = video.id;
  mediaItem.title = video.data.snippet.title;
  mediaItem.subtitle = video.data.snippet.channel_title;
  mediaItem.description = video.data.snippet.description;
  mediaItem.artworkImageURL = video.poster_frame;
  return mediaItem;
};

this.mediaItemDidChange = event => enqueueNextItem();

this.mediaItemWillChange = function(event) {
  const shouldMarkWatched = ((event.reason === 1) || (event.reason === 2));
  if (shouldMarkWatched) {
    const video = getVideoByID(event.target.previousMediaItem.externalID);
    toggleWatched(video, true);
  }
};

this.timeDidChange = function(event) {
  const video = getVideoByID(event.target.currentMediaItem.externalID);
  const videoLength = video.duration_in_seconds;
  const currentTime = event.time;
  const percentLeft = (videoLength - currentTime) / videoLength;
  const shouldMarkWatched = ((percentLeft < 0.2) && (video.watched === false));
  if (shouldMarkWatched) {
    toggleWatched(video, true);
  }
};
