class Video {
  constructor(data) {
    for (var property in data) {
      this[property] = data[property];
    }
  }

  toMediaItem() {
    return new Promise((resolve, reject) => {
      const location = data.nativeCode.videoLocation(this.youtube_id);
      if (location === "") {
        const uri = url("media_location").addSearch({youtube_id: this.youtube_id});
        request("GET", uri).then((response) => {
          const data = JSON.parse(response);
          resolve(this._mediaItem(data["location"]));
        });
      } else {
        return resolve(this._mediaItem(location));
      }
    });
  }

  _mediaItem(url) {
    const mediaItem = new MediaItem("video", url);
    mediaItem.externalID = this.id;
    mediaItem.title = this.data.snippet.title;
    mediaItem.subtitle = this.data.snippet.channel_title;
    mediaItem.description = this.data.snippet.description;
    mediaItem.artworkImageURL = this.poster_frame;
    return mediaItem;
  }

}