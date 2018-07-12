class VideoLockupView extends View {

  constructor(video, collection, action) {
    super();
    this.video = video
    this.collection = collection
    this.action = action || "videoLockup"
  }

  template() {
    return `
    <lockup action="${this.action}" dataID="${this.video.id}" id="${this._id()}" collection="${this.collection}">
      ${this._innerHTML()}
    </lockup>`;
  }

  _innerHTML() {
    return `
    <img src="${this.video.poster_frame}" class="image" />
    <title class="title"><![CDATA[${this.video.title}]]></title>
    <subtitle class="subtitle"><![CDATA[${this.video.subtitle}]]></subtitle>
    ${this._watched()}`;
  }

  _id() {
    return `${this.constructor.name}_${this.video.id}`;
  }

  _watched() {
    if (this.video.watched) {
      return `
      <overlay class="overlay">
        <badge src="resource://overlay-checkmark" class="resource-watched" />
      </overlay>`;
    } else {
      return "";
    }
  }

}
