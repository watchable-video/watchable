request = (method, uri, token) => new Promise(function(resolve, reject) {
  const xhr = new XMLHttpRequest();

  const base = URI(data.options.BASEURL);
  uri.hostname(base.hostname());
  uri.protocol(base.protocol());
  uri.port(base.port());
  uri.addSearch({
    cloudkit_id: data.options.CLOUDKITID
  });

  const href = uri.href();

  xhr.onload = function() {
    if ((this.status >= 200) && (this.status < 300)) {
      resolve(xhr.response);
    } else {
      reject({
        status: this.status,
        statusText: xhr.statusText
      });
    }
  };

  xhr.onerror = function() {
    reject({
      status: this.status,
      statusText: xhr.statusText
    });
  };

  if (token) {
    token.cancel = function() {
      xhr.abort();
      reject();
    };
  }

  xhr.open(method, href);
  xhr.send();
});