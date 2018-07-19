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
    pages[page](this.event.target, menuItemDocument);
  }

  videoLockup() {
    if (this.type == "play") {
      const video = this._getVideoFromElement();
      const collection = this._getCollectionFromElement();
      play(video, collection);
    } else if (this.type == "select") {
      const video = this._getVideoFromElement();
      const view = new VideoDetailView(video, "subscriptions");
      return setActiveDocument(view.render(), "push");
    }
  }

  searchResultVideo() {
    const video = this._getVideoFromElement();
    const collection = this._getCollectionFromElement();
    play(video, collection);
  }

  searchResultChannel() {
    const channel = this._getChannelFromElement();
    const uri = url("channel", channel.youtube_id)
    request("GET", uri).then((response) => {
      const data = JSON.parse(response);
      const channel = new Channel(data);
      let view = new ChannelView(channel);
      setActiveDocument(view.render(), "push");

      new ChannelSectionsView().update(channel);
    });
  }

  videoPlay() {
    const video = this._getVideoFromElement();
    const collection = this._getCollectionFromElement();
    play(video, collection);
  }

  toggleWatched() {
    const video = this._getVideoFromElement();
    toggleWatched(video);
  }

  _getVideoFromElement() {
    const id = this._elementAttribute("dataID") * 1;
    const collection = this._getCollectionFromElement();
    return getVideoByID(id, collection);
  };

  _getCollectionFromElement() {
    return this._elementAttribute("collection");
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
