class MenuView extends View {

  template() {
    return `
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
  }

}
