toggleWatched = function(video, watched) {
  const index = indexOfVideoID(video.id);
  data.videos[index].toggleWatched(watched)
  new VideoLockupView(data.videos[index]).update()
  new WatchedButtonView(data.videos[index]).update()
};

updateElement = function(id, newElement) {
  navigationDocument.documents.forEach(function(document) {
    var oldElement;
    if (document.getElementsByTagName("menuBar").length > 0) {
      const menuBar = document.getElementsByTagName("menuBar").item(0).getFeature("MenuBarDocument");
      const selected = menuBar.getSelectedItem();
      const menuDocument = menuBar.getDocument(selected);
      if (oldElement = menuDocument.getElementById(id)) {
        oldElement.innerHTML = newElement;
      }
    }

    if (oldElement = document.getElementById(id)) {
      oldElement.innerHTML = newElement;
    }
  });
}

setActiveDocument = function(document, method) {
  if (method == null) { method = "replace"; }
  if (method === "push") {
    navigationDocument.pushDocument(document);
  } else {
    navigationDocument.replaceDocument(document, data.activeDocument);
  }
  data.activeDocument = document;
};

getVideoByID = function(id) {
  const index = indexOfVideoID(id);
  return data.videos[index];
};

indexOfVideoID = function(id) {
  id = id * 1;
  return data.videos.findIndex(video => video.id === id);
};

indexOfChannelID = function(id) {
  id = id * 1;
  return data.channels.findIndex(channel => channel.id === id);
};

debounce = function(func, threshold, execAsap) {
  let timeout = null;
  return function(...args) {
    const obj = this;
    const delayed = function() {
      if (!execAsap) { func.apply(obj, args); }
      return timeout = null;
    };
    if (timeout) {
      clearTimeout(timeout);
    } else if (execAsap) {
      func.apply(obj, args);
    }
    return timeout = setTimeout(delayed, threshold || 100);
  };
};

poll = endpoint => new Promise(function(resolve, reject) {
  let intervalId;
  return intervalId = setInterval(( () =>
  request("GET", url(endpoint)).then(function(response) {
    clearInterval(intervalId);
    resolve(response);})
  ), 2000);
});

sleep = time => new Promise(function(resolve, reject) {
  return setTimeout(resolve, time);
});
