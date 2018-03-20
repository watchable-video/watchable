pages = {
  searchPage: function(menuItem, menuItemDocument) {
    let view = new SearchView();
    menuItemDocument.setDocument(view.render(), menuItem);
  },
  subscriptionsPage: function(menuItem, menuItemDocument) {
    if (data.collections.subscriptions) {
      let view = new ShelfView();
      menuItemDocument.setDocument(view.render(), menuItem);
    } else {
      request("GET", url("videos")).then(function(response) {
        let videos = JSON.parse(response).map(data => new Video(data));
        setVideos(videos, "subscriptions");
        let view = new ShelfView();
        menuItemDocument.setDocument(view.render(), menuItem);
      }).catch(function(error) {
        const view = new AlertView("Unable to load videos", error);
        navigationDocument.presentModal(view.render());
      });
    }
  }
}

activationPage = function(error) {
  if (error.status === 404) {
    request("POST", url("activation_token")).then(function(response) {
      const data = JSON.parse(response);
      let view = new LoginView(data.token);
      setActiveDocument(view.render());
    });

    poll("authenticate").then(function(response) {
      let view = new LoadingView("Loading your subscriptions…");
      setActiveDocument(view.render());
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

