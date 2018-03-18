class WatchedButtonView extends View {

  constructor(video) {
    super();
    this.video = video
  }

  template() {
    return `
    <badge src="resource://button-checkmark" />
    <title>${this.video.watched ? "Unwatched" : "Watched"}</title>`;
  }

}
