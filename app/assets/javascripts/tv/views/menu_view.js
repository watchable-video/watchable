this.menuView = (videos) ->

  template = """
  <document>
    <menuBarTemplate>
      <menuBar>
        <menuItem action="LoadPage" page="subscriptionsPage">
          <title>Subscriptions</title>
        </menuItem>
        <menuItem action="LoadPage" page="searchPage">
          <title>Search</title>
        </menuItem>
      </menuBar>
    </menuBarTemplate>
  </document>
  """

  parser = new DOMParser();
  view = parser.parseFromString(template, "application/xml");

  view.addEventListener "select", eventHandler
  view
