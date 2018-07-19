class View {
  render() {
    const template = new DOMParser().parseFromString(this.template(), "application/xml");
    template.addEventListener("select", EventHandler.newFromEvent);
    template.addEventListener("play", EventHandler.newFromEvent);
    template.addEventListener("highlight", this.highlight);
    return template;
  }

  update() {
    navigationDocument.documents.forEach((document) => {
      if (document.getElementsByTagName("menuBar").length > 0) {
        const menuBar = document.getElementsByTagName("menuBar").item(0).getFeature("MenuBarDocument");
        const selected = menuBar.getSelectedItem();
        const menuDocument = menuBar.getDocument(selected);
        let oldElement = menuDocument.getElementById(this._id());
        if (oldElement) {
          oldElement.innerHTML = this._innerHTML();
        }
      }

      let oldElement = document.getElementById(this._id());
      if (oldElement) {
        oldElement.innerHTML = this._innerHTML();
      }
    });
  }

  highlight(event) {}

}