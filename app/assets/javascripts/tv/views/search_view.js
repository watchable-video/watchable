searchView = function() {

  const render = function(query, view) {
    if ((query !== "") && (query !== null)) {
      let results;
      const uri = url("search");
      uri.addSearch({q: query});
      return results = request("GET", uri)
        .then(function(response) {
          data.videos = JSON.parse(response);
          const videos = data.videos.map((video, index) => videoPartialView(video));
          view.getElementById("results").innerHTML = videos.join("");
          return view.getElementById("title").textContent = "Results";
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
              <title id="title"></title>
            </header>
            <section id="results">
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
