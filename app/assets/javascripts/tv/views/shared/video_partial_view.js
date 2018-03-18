class VideoPartialView extends View {

  constructor(video) {
    super();
    this.video = video
  }

  template() {
    return `
    <lockup action="VideoLockup" videoID="${this.video.id}" id="videoPartialView_${this.video.id}">
      ${this._videoPartialInnerView()}
    </lockup>`;
  }

  _videoPartialInnerView() {
    return new VideoPartialInnerView(this.video).template()
  }

}
