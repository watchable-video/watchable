class ChannelSectionView extends View {

  constructor(title, uri) {
    super();
    this.title = title;
    this.uri = uri;
    this.pager = new Pager(this.uri, this._id());
  }

  template() {
    this._loadItems(null).then(() => {
      currentDocument().addEventListener("highlight", (event) => this._highlight(event));
    });
    return `
    <section id="${this._id()}">
      <header>
        <title>Uploads</title>
      </header>
    </section>`;
  }

  _highlight(event) {
    const eventHelper = new EventHelper(event);
    const remaining = eventHelper.remaining();
    this._loadItems(remaining);
  }

  _loadItems(remaining) {
    return this.pager.loadMore(remaining).then((json) => {
      const videos = json.videos.map(item => new Video(item));

      const markup = videos.map((video, index) => {
        return new VideoLockupView(video, this._id(), "searchResultVideo").template();
      }).join("");

      appendTo(this._id(), markup)
      appendVideos(videos, this._id());
    });
  }

  _id() {
    return `${this.constructor.name}_${this.title}`;
  }


}
