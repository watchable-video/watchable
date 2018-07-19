class ChannelSectionView extends View {

  constructor(title, videos) {
    super();
    this.title = title;
    this.videos = videos;
  }

  template() {
    return `
    <section id="${this._id()}">
      ${this._innerHTML()}
    </section>`;
  }

  _id() {
    return `${this.constructor.name}_${this.title}`;
  }

  _innerHTML() {
    return `
    <header>
      <title>Uploads</title>
    </header>
    ${this._videoMarkup()}`;
  }

  _videoMarkup() {
    const collection = this._id();
    setVideos(this.videos, collection);
    return this.videos.map((video, index) => {
      return new VideoLockupView(video, collection, "searchResultVideo").template();
    }).join("");
  }

}
