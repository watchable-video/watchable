this.eventHandler = function(event) {
  let action;
  if (action = elementAttribute(event.target, "action")) {
    const handler = `${event.type}${action}`;
    return this[handler](event);
  }
};

this.selectLoadPage = function(event) {
  const menuItemDocument = event.target.parentNode.getFeature("MenuBarDocument");
  const page = elementAttribute(event.target, "page");
  this[page](event.target, menuItemDocument);
};

this.selectVideoLockup = function(event) {
  const video = getVideoFromElement(event.target);
  const template = videoDetailView(video);
  return setActiveDocument(template, "push");
};

this.playVideoLockup = function(event) {
  const video = getVideoFromElement(event.target);
  return play(video);
};

this.playVideoPlay = function(event) {
  const video = getVideoFromElement(event.target);
  return play(video);
};

this.selectVideoPlay = function(event) {
  const video = getVideoFromElement(event.target);
  return play(video);
};

this.playToggleWatched = function(event) {
  const video = getVideoFromElement(event.target);
  return toggleWatched(video);
};

this.selectToggleWatched = function(event) {
  const video = getVideoFromElement(event.target);
  return toggleWatched(video);
};
