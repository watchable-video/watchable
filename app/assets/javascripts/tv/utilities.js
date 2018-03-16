toggleWatched = function(video, watched) {
  if (data.activePage !== "searchPage") {
    const index = indexOfVideoID(video.id);

    if (watched) {
      data.videos[index].watched = watched;
    } else {
      data.videos[index].watched = !data.videos[index].watched;
    }

    updateElement(`videoPartialView_${video.id}`, videoPartialInnerView(data.videos[index]));
    updateElement(`watchedButtonView_${video.id}`, watchedButtonView(data.videos[index]));

    if (!video.read_only) {
      request("POST", url("video_watch", video.id));
    }
  }
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

getVideoFromElement = function(element) {
  const id = elementAttribute(element, "videoID") * 1;
  const index = indexOfVideoID(id);
  return data.videos[index];
};

indexOfVideoID = function(id) {
  id = id * 1;
  return data.videos.findIndex(video => video.id === id);
};

elementAttribute = function(element, attribute) {
  let attr;
  if ((attr = element.attributes.getNamedItem(attribute))) {
    return attr.value;
  } else {
    return null;
  }
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
