class Video {

  constructor(data) {
    for (var property in data) {
      this[property] = data[property];
    }
  }

  duration() {
    const seconds = this.duration_in_seconds;
    if (seconds < 60) {
      return `${seconds} sec`;
    } else {
      const minutes = Math.round(seconds / 60);
      return `${minutes} min`;
    }
  }

  title() {
    return this.data.snippet.title;
  }

  subhead() {
    return this.subtitle;
  }

  viewCount() {
    return this._formatNumber(this.data.statistics.view_count)
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
        resolve(this._mediaItem(location));
      }
    });
  }

  toggleWatched(watchedStatus) {
    if (watchedStatus) {
      this.watched = watchedStatus;
    } else {
      this.watched = !this.watched;
    }
    if (!this.read_only) {
      if (this.watched) {
        request("DELETE", url("video_watch", this.id));
      } else {
        request("POST", url("video_watch", this.id));
      }
    }
  }

  _formatNumber(number) {
    const numberFormat = new Intl.NumberFormat();
    return numberFormat.format(number);
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