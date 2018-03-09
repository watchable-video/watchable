this.searchPage = (menuItem, menuItemDocument) ->
  data.activePage = "searchPage"
  template = searchView()
  menuItemDocument.setDocument(template, menuItem)

this.subscriptionsPage = (menuItem, menuItemDocument) ->
  data.activePage = "subscriptionsPage"
  request "GET", url("videos")
    .then (response) ->
      data.videos = JSON.parse(response)
      template = shelfView(data.videos)
      menuItemDocument.setDocument(template, menuItem)

    .catch (error) ->
      console.log error
      template = alertView "Unable to load videos", error
      navigationDocument.presentModal template
