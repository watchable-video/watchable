class SearchResultsView extends View {

  constructor(query, title) {
    super();
    this.query = query
    this.title = title || ""
    this.markup = ""
  }

  template() {
    return `
    <grid id="${this._id()}">
      ${this._innerHTML()}
    </grid>`;
  }

  _id() {
    return this.constructor.name;
  }

  _innerHTML() {
    return `
    <header>
      <title><![CDATA[${this.title}]]></title>
    </header>
    <section>
      ${this.markup}
    </section>`;
  }

  update() {
    const uri = url("search");
    uri.addSearch({q: this.query});
    request("GET", uri).then((response) => {

      let videos = [];
      let channels = [];

      let items = JSON.parse(response).map(function(item) {
        if (item.type == "video") {
          let video = new Video(item);
          videos.push(video);
          return video;
        } else if (item.type == "videochannel") {
          let channel = new Channel(item);
          channels.push(channel);
          return channel;
        }
      });

      setVideos(videos);
      data.channels = channels;

      this.markup = items.map((item, index) => {
        return new SearchLockupView(item).template();
      }).join("");

      super.update()
    });
  }

}
