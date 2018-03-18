searchPage = function(menuItem, menuItemDocument) {
  let view = new SearchView();
  menuItemDocument.setDocument(view.render(), menuItem);
};

subscriptionsPage = function(menuItem, menuItemDocument) {
  request("GET", url("videos")).then(function(response) {
    data.videos = JSON.parse(response).map(data => new Video(data));
    let view = new ShelfView(data.videos);
    menuItemDocument.setDocument(view.render(), menuItem);
  }).catch(function(error) {
    const view = new AlertView("Unable to load videos", error);
    navigationDocument.presentModal(view.render());
  });
};

activationPage = function(error) {
  if (error.status === 404) {
    request("POST", url("activation_token")).then(function(response) {
      const data = JSON.parse(response);
      let view = new LoginView(data.token);
      setActiveDocument(view.render());
    });

    poll("authenticate").then(function(response) {
      setActiveDocument(loadingView("Loading your subscriptions…"));
      return poll("sync_status");
    }).then(function(response) {
      let view = new MenuView();
      setActiveDocument(view.render());
    });
  } else {
    const view = new AlertView("Service Unavailable", "Please try again later.");
    setActiveDocument(view.render());
  }
};

