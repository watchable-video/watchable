this.loadingView = function(text) {

  if (text == null) { text = "Loading…"; }
  const template = `
    <document>
      <loadingTemplate>
        <activityIndicator>
          <title><![CDATA[${text}]]></title>
        </activityIndicator>
      </loadingTemplate>
    </document>`;
  const parser = new DOMParser();
  return parser.parseFromString(template, "application/xml");
};
