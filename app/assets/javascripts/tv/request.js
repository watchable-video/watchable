request = (method, uri, cancel = false) => new Promise(function(resolve, reject) {
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
    delete(data.requests[uri.path()]);
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
    delete(data.requests[uri.path()]);
    reject({
      status: this.status,
      statusText: xhr.statusText
    });
  };

  if (cancel && data.requests[uri.path()]) {
    data.requests[uri.path()].abort()
  }

  data.requests[uri.path()] = xhr;

  xhr.open(method, href);
  xhr.send();

});