class ShelfView extends View {
  constructor() {
    super();
    this.videos = getVideos("subscriptions")
  }

  highlight(event) {
    const eventHelper = new EventHelper(event);
    const remaining = eventHelper.remaining();
    console.log(remaining);
  }

  template() {
    return `
    <document>
      <head>
        <style>
          .overlay {
            padding: 0;
          }
          .resource-watched {
            tv-position: bottom-trailing;
            tv-align: trailing;
          }
          .title {
            font-weight: bold;
          }
          .title, .subtitle {
            text-align: left;
          }
          .image {
            width: 960;
            height: 540;
          }
        </style>
      </head>
      <stackTemplate>
        <banner>
          <title>Subscriptions</title>
        </banner>
        <collectionList>
          <shelf>
            <section id="${this._id()}">
              ${this._innerHTML()}
            </section>
          </shelf>
        </collectionList>
      </stackTemplate>
    </document>`;
  }

  _innerHTML() {
    return this.videos.map((video, index) => new VideoLockupView(video, "subscriptions").template()).join("");
  }

  _id() {
    return this.constructor.name;
  }


}
