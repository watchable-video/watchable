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
      data.videos = JSON.parse(response).map(data => new Video(data));
      this.markup = data.videos
        .map((video, index) => new VideoLockupView(video, "searchResult").template())
        .join("");
      super.update()
    });
  }

}
