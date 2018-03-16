searchView = function() {

  const render = function(query, view) {
    if ((query !== "") && (query !== null)) {
      let results;
      const uri = url("search");
      uri.addSearch({q: query});
      request("GET", uri).then(function(response) {
        data.videos = JSON.parse(response).map(data => new Video(data));
        const videos = data.videos.map((video, index) => videoPartialView(video));

        updateElement("searchResults", videos.join(""))
        updateElement("searchTitle", "Results")
      });
    }
  };

  const template = `
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


  const parser = new DOMParser();
  const view = parser.parseFromString(template, "application/xml");

  const searchFields = view.getElementsByTagName('searchField');

  for (var i = searchFields.length - 1; i >= 0; i--) {
    var field = searchFields.item(i);
    var keyboard = field.getFeature("Keyboard");
    keyboard.onTextChange = debounce(function(event) {
      const query = keyboard.text;
      render(query, view);
    }, 400, false);
  }

  view.addEventListener("select", playVideoPlay);
  view.addEventListener("play", playVideoPlay);

  return view;
};
