eventHandler = function(event) {
  let action;
  if (action = elementAttribute(event.target, "action")) {
    const handler = `${event.type}${action}`;
    return this[handler](event);
  }
};

selectLoadPage = function(event) {
  const menuItemDocument = event.target.parentNode.getFeature("MenuBarDocument");
  const page = elementAttribute(event.target, "page");
  this[page](event.target, menuItemDocument);
};

selectVideoLockup = function(event) {
  const video = getVideoFromElement(event.target);
  const template = videoDetailView(video);
  return setActiveDocument(template, "push");
};

playVideoLockup = function(event) {
  const video = getVideoFromElement(event.target);
  play(video);
};

playVideoPlay = function(event) {
  const video = getVideoFromElement(event.target);
  play(video);
};

selectVideoPlay = function(event) {
  const video = getVideoFromElement(event.target);
  play(video);
};

playToggleWatched = function(event) {
  const video = getVideoFromElement(event.target);
  toggleWatched(video);
};

selectToggleWatched = function(event) {
  const video = getVideoFromElement(event.target);
  toggleWatched(video);
};
