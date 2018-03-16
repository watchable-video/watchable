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

this.activationPage = (error) ->
  if error.status == 404
    request "POST", url("activation_token")
      .then (response) ->
        data = JSON.parse(response)
        setActiveDocument loginView(data.token)

    poll "authenticate"
      .then (response) ->
        setActiveDocument loadingView("Loading your subscriptions…")
        poll "sync_status"
      .then (response) ->
        setActiveDocument menuView()
  else
    setActiveDocument alertView("Service Unavailable", "Please try again later.")

this.login = () ->
  request "GET", url("authenticate")
    .then (response) ->
      setActiveDocument menuView()
    .catch (error) ->
      activationPage(error)
