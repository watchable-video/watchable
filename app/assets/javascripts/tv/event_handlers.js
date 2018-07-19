class EventHandler {
  constructor(event) {
    this.eventHelper = new EventHelper(event);
    const action = this.eventHelper.elementAttribute("action");
    if (action) {
      this[action]();
    }
  }

  static newFromEvent(event) {
    return new EventHandler(event);
  }

  loadPage() {
    const page = this.eventHelper.elementAttribute("page");
    pages[page](this.eventHelper.event.target, this.eventHelper.menuItemDocument());
  }

  videoLockup() {
    if (this.eventHelper.event.type == "play") {
      const video = this.eventHelper.getVideoFromElement();
      const collection = this.eventHelper.getCollectionFromElement();
      play(video, collection);
    } else if (this.eventHelper.event.type == "select") {
      const video = this.eventHelper.getVideoFromElement();
      const view = new VideoDetailView(video, "subscriptions");
      return setActiveDocument(view.render(), "push");
    }
  }

  searchResultVideo() {
    const video = this.eventHelper.getVideoFromElement();
    const collection = this.eventHelper.getCollectionFromElement();
    play(video, collection);
  }

  searchResultChannel() {
    const channel = this.eventHelper.getChannelFromElement();
    const uri = url("channel", channel.youtube_id)
    request("GET", uri).then((response) => {
      const data = JSON.parse(response);
      const channel = new Channel(data);
      let view = new ChannelView(channel);
      setActiveDocument(view.render(), "push");
      new ChannelView(channel).update();
    });
  }

  videoPlay() {
    const video = this.eventHelper.getVideoFromElement();
    const collection = this.eventHelper.getCollectionFromElement();
    play(video, collection);
  }

  toggleWatched() {
    const video = this.eventHelper.getVideoFromElement();
    toggleWatched(video);
  }


}
