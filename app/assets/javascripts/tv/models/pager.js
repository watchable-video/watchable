class Pager {

  constructor(uri, id) {
    this.uri = uri;
    this.id = id;
    this.firstRequest = true;
  }

  loadMore(remaining) {
    this.remaining = remaining;

    return new Promise((resolve, reject) => {
      if (this._needsMore()) {
        request("GET", this._requestURI()).then((response) => {
          const json = JSON.parse(response);
          this.nextPageToken = json.next_page_token;
          resolve(json);
        }).catch(function(error) {
          reject(error);
        });
      } else {
        reject()
      }
    });
  }

  _needsMore() {
    if (!this.firstRequest) {
      if (this.remaining > 20) {
        return false;
      }
      if (!this.nextPageToken) {
        return false;
      }
      if (data.requests[this.uri.path()]) {
        return false
      }
    }

    this.firstRequest = false

    return true;
  }

  _requestURI() {
    if (this.nextPageToken) {
      this.uri.removeSearch("page_token");
      this.uri.addSearch({
        page_token: this.nextPageToken
      });
    }
    return this.uri;
  }

}
