class MenuView extends View {

  template() {
    return `
    <document>
      <menuBarTemplate>
        <menuBar>
          <menuItem action="loadPage" page="subscriptionsPage">
            <title>Subscriptions</title>
          </menuItem>
          <menuItem action="loadPage" page="searchPage">
            <title>Search</title>
          </menuItem>
        </menuBar>
      </menuBarTemplate>
    </document>`;
  }

}
