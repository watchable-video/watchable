toggleWatched = function(video, watched) {
  video.toggleWatched(watched)
  new VideoLockupView(video).update()
  new WatchedButtonView(video).update()
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
  id = id * 1
  return getVideos().find(function(video, index, array) {
    return video.id === id;
  });
};

getVideoByIndex = function(index) {
  return data.videos[index];
};

getVideos = function(index) {
  return data.videos;
};

setVideos = function(videos) {
  data.videos = videos;
  return getVideos();
};

getNextVideo = function(currentVideo) {
  const currentIndex = getVideos().findIndex(video => video.id === currentVideo.id);
  return getVideos().find(function(item, index, array) {
    return index > currentIndex && item.type === "video" && item.watched === false;
  });
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
