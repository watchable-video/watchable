class SearchLockupView extends View {

  constructor(item, collection) {
    super();
    this.item = item
    this.collection = collection;
  }

  template() {
    return `
    <lockup action="${this.action()}" dataID="${this.item.id}" id="${this._id()}" collection="${this.collection}">
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
