class VideoLockupView extends View {

  constructor(video, action) {
    super();
    this.video = video
    this.action = action || "VideoLockup"
  }

  template() {
    return `
    <lockup action="${this.action}" videoID="${this.video.id}" id="${this._id()}">
      ${this._innerHTML()}
    </lockup>`;
  }

  _innerHTML() {
    return `
    <img src="${this.video.poster_frame}" class="image" />
    <title class="title"><![CDATA[${this.video.data.snippet.title}]]></title>
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
