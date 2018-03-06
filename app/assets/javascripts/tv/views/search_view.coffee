this.searchView = ->
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
      </style>
    </head>
    <searchTemplate>
      <searchField/>
      <collectionList>
        <grid>
          <header>
            <title>Results</title>
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
    keyboard.onTextChange = (event) ->
      query = keyboard.text
      console.log("Search text changed #{query}")
      # searchResults(document, searchText);

  view
