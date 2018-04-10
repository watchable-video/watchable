class SearchView extends View {

  render() {
    const view = super.render();
    view.addEventListener("highlight", (event) => {
    });
    const searchFields = view.getElementsByTagName("searchField");
    for (let index = searchFields.length - 1; index >= 0; index--) {
      let field = searchFields.item(index);
      let keyboard = field.getFeature("Keyboard");
      keyboard.onTextChange = debounce((event) => {
        const query = keyboard.text;
        if (query) {
          new SearchResultsView(query, "Results").update();
        }
      }, 400, false);
    }
    return view;
  }

  template() {
    return `
    <document>
      <head>
        <style>
          .title {
            font-weight: bold;
          }
          .title, .subtitle {
            text-align: left;
          }
          .image {
            width: 838;
            height: 471;
          }
        </style>
      </head>
      <searchTemplate>
        <searchField/>
        <collectionList>
          ${new SearchResultsView().template()}
        </collectionList>
      </searchTemplate>
    </document>`;
  }

}
