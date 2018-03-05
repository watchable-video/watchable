this.menuView = (videos) ->

  selectHandler = (event) ->
    target = event.target
    menuItemDocument = target.parentNode.getFeature("MenuBarDocument")
    action = target.getAttribute("action")
    this[action](target, menuItemDocument)

  template = """
  <?xml version="1.0" encoding="UTF-8"?>
  <document>
    <menuBarTemplate>
      <menuBar>
        <menuItem action="subscriptions">
          <title>Subscriptions</title>
        </menuItem>
        <menuItem action="search">
          <title>Search</title>
        </menuItem>
      </menuBar>
    </menuBarTemplate>
  </document>
  """

  parser = new DOMParser();
  view = parser.parseFromString(template, "application/xml");

  view.addEventListener "select", selectHandler
  view
