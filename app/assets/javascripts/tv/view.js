class View {
  render() {
    const template = new DOMParser().parseFromString(this.template(), "application/xml");
    template.addEventListener("select", eventHandler);
    template.addEventListener("play", eventHandler);
    return template;
  }
}