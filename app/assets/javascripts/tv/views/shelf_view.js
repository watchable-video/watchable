class ShelfView extends View {
  constructor(videos) {
    super();
    this.videos = videos
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
            <section>
              ${this._videosTemplate()}
            </section>
          </shelf>
        </collectionList>
      </stackTemplate>
    </document>`;
  }

  _videosTemplate() {
    return this.videos.map((video, index) => new VideoLockupView(video).template()).join("");
  }

}
