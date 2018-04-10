data = {}

App.onLaunch = function(options) {
  data.options = options;
  data.player = new Player;
  data.player.addEventListener("mediaItemDidChange", mediaItemDidChange);
  data.player.addEventListener("mediaItemWillChange", mediaItemWillChange);
  data.player.addEventListener("timeDidChange", timeDidChange, {interval: 1});
  data.nativeCode = Native.create();
  data.collections = {}
  data.searchRequest = {
    cancel: function() {}
  }

  let view = new LoadingView();
  setActiveDocument(view.render(), "push");

  if (data.options.CLOUDKITID) {
    request("GET", url("authenticate")).then(function(response) {
      let view = new MenuView();
      setActiveDocument(view.render());
    }).catch(function(error) {
      activationPage(error);
    });
  } else {
    let view = new AlertView("Error", "Please sign-in to iCloud in Settings and try again.");
    setActiveDocument(view.render());
  }
}

App.onResume = function(options) {
  request("GET", url("videos")).then(function(response) {
    let videos = JSON.parse(response).map(data => new Video(data));
    setVideos(videos, "subscriptions");
    new ShelfView().update()
  })
}

// this.App.onError
// A callback function that is automatically called when an error is sent from the Apple TV.
//
// this.App.onExit
// A callback function that is automatically called when the app has been exited.
//
// this.App.onResume
// A callback function that is automatically called when the app moves to the foreground.
//
// this.App.onSuspend
// A callback function that is automatically called when the app is sent to the background.