class WatchedButtonView extends View {

  constructor(video) {
    super();
    this.video = video
  }

  template() {
    return `
    <buttonLockup action="toggleWatched" dataID="${this.video.id}" id="${this._id()}">
      ${this._innerHTML()}
    </buttonLockup>`;
  }

  _id() {
    return `${this.constructor.name}_${this.video.id}`;
  }

  _innerHTML() {
    return `
    <badge src="resource://button-checkmark" />
    <title>${this.video.watched ? "Unwatched" : "Watched"}</title>`;
  }

}
