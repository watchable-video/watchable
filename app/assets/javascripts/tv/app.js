this.data = {};

this.App.onLaunch = function(options) {
  data.options = options;
  data.player = new Player;
  data.player.addEventListener("mediaItemDidChange", mediaItemDidChange);
  data.player.addEventListener("mediaItemWillChange", mediaItemWillChange);
  data.player.addEventListener("timeDidChange", timeDidChange, {interval: 1});
  data.nativeCode = Native.create();

  setActiveDocument(loadingView(), "push");

  if (data.options.CLOUDKITID) {
    login();
  } else {
    setActiveDocument(alertView("Error", "Please sign-in to iCloud in Settings and try again."));
  }
};

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