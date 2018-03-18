class AlertView extends View {
  constructor(title, description) {
    super();
    this.title = title
    this.description = description
  }

  template() {
    return `
    <document>
      <alertTemplate>
        <title>${this.title}</title>
        <description>${this.description}</description>
      </alertTemplate>
    </document>`;
  }
}
