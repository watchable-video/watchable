class PlaylistsView extends View {

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
    request("GET", url("video_channel", channel.youtube_id)).then((response) => {

      const data = JSON.parse(response);
      var videos = data.videos.map(data => new Video(data));
      videos = videos.map((video, index) => new VideoLockupView(video, "channel", "searchResultVideo").template()).join("");

      console.log(videos);

      this.markup = `
      <header>
        <title>Uploads</title>
      </header>
      <section>
      ${videos}
      </section>`

      super.update()
    });
  }

}
