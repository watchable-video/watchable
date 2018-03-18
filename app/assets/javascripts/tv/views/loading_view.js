class LoadingView extends View {
  constructor(text) {
    super();
    this.text = text || "Loading…";
  }

  template() {
    return `
    <document>
      <loadingTemplate>
        <activityIndicator>
          <title><![CDATA[${this.text}]]></title>
        </activityIndicator>
      </loadingTemplate>
    </document>`;
  }
}
