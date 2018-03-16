loginView = function(activationToken) {
  const template = `
    <document>
      <alertTemplate>
        <title>Activate your account by visiting:</title>
        <text style="font-weight: bold; font-size: 50;">${data.options.BASEURL}/activate/${activationToken}</text>
      </alertTemplate>
    </document>`;

  const parser = new DOMParser();
  return parser.parseFromString(template, "application/xml");
};
