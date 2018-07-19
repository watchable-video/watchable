class EventHelper {
  constructor(event) {
    this.event = event;
  }

  menuItemDocument() {
    return this.event.target.parentNode.getFeature("MenuBarDocument");
  }

  remaining() {
    const video = this.getVideoFromElement();
    const collection = this.getCollectionFromElement();
    return videosRemaining(video, collection);
  }

  getVideoFromElement() {
    const id = this.elementAttribute("dataID") * 1;
    const collection = this.getCollectionFromElement();
    return getVideoByID(id, collection);
  };

  getCollectionFromElement() {
    return this.elementAttribute("collection");
  };

  getChannelFromElement() {
    const id = this.elementAttribute("dataID") * 1;
    const index = indexOfChannelID(id);
    return data.channels[index];
  };

  elementAttribute(attribute) {
    let attr = this.event.target.attributes.getNamedItem(attribute);
    if (attr) {
      return attr.value;
    } else {
      return null;
    }
  };


}
