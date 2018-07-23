class Pager {

  constructor(uri, id) {
    this.uri = uri;
    this.id = id;
    this.firstRequest = true;
  }

  loadMore(remaining) {
    this.remaining = remaining;
    if (this._needsMore()) {
      const requestURI = this.uri;
      if (this.nextPageToken) {
        requestURI.addSearch({
          page_token: this.nextPageToken
        });
      }
      request("GET", requestURI).then((response) => {
        const json = JSON.parse(response);
        this.nextPageToken = json.next_page_token;
      });
    }
  }

  _needsMore() {

    if (!this.firstRequest) {
      if (this.remaining > 20) {
        return false;
      }
      if (!this.nextPageToken) {
        return false;
      }
      if (data.requests[uri.path()]) {
        return false
      }
    }

    this.firstRequest = false

    return true;
  }


}
