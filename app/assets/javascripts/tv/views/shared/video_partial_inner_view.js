class VideoPartialInnerView extends View {

  constructor(video) {
    super();
    this.video = video
  }

  template() {
    return `
    <img src="${this.video.poster_frame}" class="image" />
    <title class="title"><![CDATA[${this.video.data.snippet.title}]]></title>
    <subtitle class="subtitle"><![CDATA[${this.video.subtitle}]]></subtitle>
    ${this._watched()}`;
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
