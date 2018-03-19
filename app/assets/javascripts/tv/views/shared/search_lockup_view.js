class SearchLockupView extends View {

  constructor(item) {
    super();
    this.item = item
  }

  template() {
    return `
    <lockup action="${this.action()}" dataID="${this.item.id}" id="${this._id()}">
      <img src="${this.item.poster_frame}" class="image" />
      <title class="title"><![CDATA[${this.item.title()}]]></title>
      <subtitle class="subtitle"><![CDATA[${this.item.subhead()}]]></subtitle>
    </lockup>`;
  }

  action() {
    if (this.item.type == "video") {
      return "searchResultVideo";
    } else if (this.item.type == "videochannel") {
      return "searchResultChannel";
    }
  }

  _id() {
    return `${this.constructor.name}_${this.item.id}`;
  }

}
