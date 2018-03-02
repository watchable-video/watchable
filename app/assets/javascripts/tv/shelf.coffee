this.shelf = ->
  template = """
  <?xml version="1.0" encoding="UTF-8"?>
  <document>
    <stackTemplate>
      <banner>
        <title>Subscriptions</title>
      </banner>
      <collectionList>
        <shelf>
          <prototypes>
            <lockup>
              <img binding="@src:{data.thumbnail_url};" width="960" height="540" />
              <title binding="textContent:{data.title};" />
              <subtitle binding="textContent:{subtitle};" />
            </lockup>
          </prototypes>
          <section binding="items:{items};" />
        </shelf>
      </collectionList>
    </stackTemplate>
  </document>
  """

  parser = new DOMParser();
  parser.parseFromString(template, "application/xml");
