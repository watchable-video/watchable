class ChannelSectionView extends View {

  constructor(title, channel) {
    super();
    this.title = title;
    this.channel = channel;
    this.videos = null;
    this.nextPageToken = null;
  }

  template() {
    const uri = url("playlist_videos");
    uri.addSearch({playlist_id: this.channel.uploadsPlaylist()});
    request("GET", uri).then((response) => {
      const json = JSON.parse(response);
      this.videos = json.videos.map(item => new Video(item));
      this.nextPageToken = json.next_page_token;
      this.markup = this._markup();

      setVideos(this.videos, this._id());

      super.update()
    });

    return `
    <section id="${this._id()}">
      ${this._innerHTML()}
    </section>`;
  }

  loadMore(remaining) {
    const uri = url("playlist_videos");

    if (this.needsMore(remaining, uri)) {
      uri.addSearch({
        playlist_id: this.channel.uploadsPlaylist(),
        page_token: this.nextPageToken
      });

      request("GET", uri).then((response) => {
        const json = JSON.parse(response);
        const videos = json.videos.map(item => new Video(item));
        const markup = this._videoMarkup(videos)
        appendTo(this._id(), markup)
        appendVideos(videos, this._id());
        this.nextPageToken = json.next_page_token;
      });

    }

  }

  needsMore(remaining, uri) {
    if (remaining > 20) {
      return false;
    }

    if (!this.nextPageToken) {
      return false;
    }

    if (data.requests[uri.path()]) {
      return false
    }

    return true;
  }

  _id() {
    return `${this.constructor.name}_${this.title}`;
  }

  _innerHTML() {
    return this.markup;
  }

  _markup() {
    return `<header>
      <title>Uploads</title>
    </header>
    ${this._videoMarkup(this.videos)}`
  }

  _videoMarkup(videos) {
    return videos.map((video, index) => {
      return new VideoLockupView(video, this._id(), "searchResultVideo").template();
    }).join("");
  }

}
