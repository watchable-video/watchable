class SearchView extends View {

  render() {
    const view = super.render();
    const searchFields = view.getElementsByTagName('searchField');
    console.log(["view", view]);
    for (var i = searchFields.length - 1; i >= 0; i--) {
      var field = searchFields.item(i);
      var keyboard = field.getFeature("Keyboard");
      keyboard.onTextChange = debounce((event) => {
        const query = keyboard.text;
        this.displayResult(view, query);
      }, 400, false);
    }
    return view;
  }

  displayResult (view, query) {
    if ((query !== "") && (query !== null)) {
      let results;
      const uri = url("search");
      uri.addSearch({q: query});
      request("GET", uri).then(function(response) {
        data.videos = JSON.parse(response).map(data => new Video(data));
        const videos = data.videos.map((video, index) => new VideoPartialView(video).template());

        updateElement("searchResults", videos.join(""));
        updateElement("searchTitle", "Results");
      });
    }
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
          <grid>
            <header>
              <title id="searchTitle"></title>
            </header>
            <section id="searchResults">
            </section>
          </grid>
        </collectionList>
      </searchTemplate>
    </document>`;
  }

}
