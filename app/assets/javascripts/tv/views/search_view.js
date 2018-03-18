class SearchView extends View {

  render() {
    const view = super.render();
    const searchFields = view.getElementsByTagName("searchField");
    for (let index = searchFields.length - 1; index >= 0; index--) {
      let field = searchFields.item(index);
      let keyboard = field.getFeature("Keyboard");
      keyboard.onTextChange = debounce((event) => {
        const query = keyboard.text;
        if (query) {
          this.displayResult(query);
        }
      }, 400, false);
    }
    return view;
  }

  displayResult (query) {
    const uri = url("search");
    uri.addSearch({q: query});
    request("GET", uri).then((response) => {
      data.videos = JSON.parse(response).map(data => new Video(data));
      updateElement("searchResults", this._searchResults("Results", data.videos));
    });
  }

  template() {
    return `
    <document>
      <head>
        <style>
          .title {
            font-weight: bold;
          }
          .title, .subtitle {
            text-align: left;
          }
          .image {
            width: 838;
            height: 471;
          }
        </style>
      </head>
      <searchTemplate>
        <searchField/>
        <collectionList>
          <grid id="searchResults">
          ${this._searchResults()}
          </grid>
        </collectionList>
      </searchTemplate>
    </document>`;
  }

  _searchResults(title = "", videos) {
    const markup = videos ? videos.map((video, index) => new VideoLockupView(video).template()).join("") : "";
    return `
    <header>
      <title><![CDATA[${title}]]></title>
    </header>
    <section>
      ${markup}
    </section>`;
  }
}
