this.searchView = ->

  render = (query, view) ->
    uri = url("search")
    uri.addSearch({q: query})
    results = request "GET", uri
      .then (response) ->
        data.videos = JSON.parse(response)
        videos = data.videos.map (video, index) ->
          videoPartialView(video)
        view.getElementById("results").innerHTML = videos.join("")
        view.getElementsByTagName("header").item(0).getElementsByTagName("title").item(0).textContent = "Results"

  template = """
  <?xml version="1.0" encoding="UTF-8"?>
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
            <title></title>
          </header>
          <section id="results">
          </section>
        </grid>
      </collectionList>
    </searchTemplate>
  </document>
  """


  parser = new DOMParser();
  view = parser.parseFromString(template, "application/xml");

  searchFields = view.getElementsByTagName('searchField')
  for index in [0...searchFields.length]
    field = searchFields.item(index)
    keyboard = field.getFeature("Keyboard")
    keyboard.onTextChange = debounce((event) ->
      query = keyboard.text
      render(query, view)
    , 800, false)

  view.addEventListener "select", playVideoPlay
  view.addEventListener "play", playVideoPlay

  view
