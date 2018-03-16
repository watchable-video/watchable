this.searchPage = function(menuItem, menuItemDocument) {
  data.activePage = "searchPage";
  const template = searchView();
  menuItemDocument.setDocument(template, menuItem);
};

this.subscriptionsPage = function(menuItem, menuItemDocument) {
  data.activePage = "subscriptionsPage";
  request("GET", url("videos")).then(function(response) {
    data.videos = JSON.parse(response);
    console.log(data.videos);
    console.log(menuItem);
    console.log(menuItemDocument);
    const template = shelfView(data.videos);
    console.log(template);
    menuItemDocument.setDocument(template, menuItem);
  }).catch(function(error) {
    console.log(error);
    const template = alertView("Unable to load videos", error);
    navigationDocument.presentModal(template);
  });
};

this.activationPage = function(error) {
  if (error.status === 404) {
    request("POST", url("activation_token")).then(function(response) {
      const data = JSON.parse(response);
      setActiveDocument(loginView(data.token));
    });

    poll("authenticate").then(function(response) {
      setActiveDocument(loadingView("Loading your subscriptions…"));
      return poll("sync_status");
    }).then(
      response => setActiveDocument(menuView())
    );
  } else {
    setActiveDocument(alertView("Service Unavailable", "Please try again later."));
  }
};

this.login = function() {
  request("GET", url("authenticate"))
    .then(response => setActiveDocument(menuView()))
    .catch(error => activationPage(error));
}
