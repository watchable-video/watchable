class ChannelSectionsView extends View {

  constructor(query, title) {
    super();
    this.markup = `
    <header>
      <title>Loading...</title>
    </header>
    <section>
    </section>`

  }

  template() {
    return `
    <shelf id="${this._id()}">
      ${this._innerHTML()}
    </shelf>`;
  }

  _id() {
    return this.constructor.name;
  }

  _innerHTML() {
    return this.markup;
  }

  update(channel) {
    const uri = url("playlist_videos");
    uri.addSearch({playlist_id: channel.uploadsPlaylist()});

    request("GET", uri).then((response) => {

      const data = JSON.parse(response);
      const videos = data.videos.map(data => new Video(data));
      const videoMarkup = videos.map((video, index) => new VideoLockupView(video, "channel", "searchResultVideo").template()).join("");

      setVideos(videos, "channel");

      this.markup = `
      <header>
        <title>Uploads</title>
      </header>
      <section>
      ${videoMarkup}
      </section>`

      super.update()
    });
  }

}
