this.alertView = function(title, description) {
  const template = `
    <document>
      <alertTemplate>
        <title>${title}</title>
        <description>${description}</description>
      </alertTemplate>
    </document>`;
  const parser = new DOMParser();
  return parser.parseFromString(template, "application/xml");
};
