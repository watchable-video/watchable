class EventHandler {
  constructor(event) {
    this.event = event;
    this.type = event.type;

    const action = this._elementAttribute("action");
    if (action) {
      this[action]();
    }
  }

  static newFromEvent(event) {
    return new EventHandler(event);
  }

  loadPage() {
    const menuItemDocument = this.event.target.parentNode.getFeature("MenuBarDocument");
    const page = this._elementAttribute("page");
    console.log(["page", page]);
    pages[page](this.event.target, menuItemDocument);
  }

  videoLockup() {
    if (this.type == "play") {
      const video = this._getVideoFromElement();
      play(video);
    } else if (this.type == "select") {
      const video = this._getVideoFromElement();
      const view = new VideoDetailView(video);
      return setActiveDocument(view.render(), "push");
    }
  }

  searchResultVideo() {
    const video = this._getVideoFromElement();
    play(video);
  }

  searchResultChannel() {
    const channel = this._getChannelFromElement();
    console.log(channel);
  }

  videoPlay() {
    const video = this._getVideoFromElement();
    play(video);
  }

  toggleWatched() {
    const video = this._getVideoFromElement();
    toggleWatched(video);
  }

  _getVideoFromElement() {
    const id = this._elementAttribute("dataID") * 1;
    const index = indexOfVideoID(id);
    return data.videos[index];
  };

  _getChannelFromElement() {
    const id = this._elementAttribute("dataID") * 1;
    const index = indexOfChannelID(id);
    return data.channels[index];
  };

  _elementAttribute(attribute) {
    let attr = this.event.target.attributes.getNamedItem(attribute);
    if (attr) {
      return attr.value;
    } else {
      return null;
    }
  };


}
