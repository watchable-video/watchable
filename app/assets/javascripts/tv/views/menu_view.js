this.menuView = function(videos) {

  const template = `
    <document>
      <menuBarTemplate>
        <menuBar>
          <menuItem action="LoadPage" page="subscriptionsPage">
            <title>Subscriptions</title>
          </menuItem>
          <menuItem action="LoadPage" page="searchPage">
            <title>Search</title>
          </menuItem>
        </menuBar>
      </menuBarTemplate>
    </document>`;

  const parser = new DOMParser();
  const view = parser.parseFromString(template, "application/xml");

  view.addEventListener("select", eventHandler);
  return view;
};
