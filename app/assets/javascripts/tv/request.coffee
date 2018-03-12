this.request = (method, uri) ->
  new Promise (resolve, reject) ->
    xhr = new XMLHttpRequest

    base = URI(data.options.BASEURL)
    uri.hostname(base.hostname())
    uri.protocol(base.protocol())
    uri.port(base.port())
    uri.addSearch
      cloudkit_id: "me"

    href = uri.href()
    xhr.open method, href

    xhr.onload = ->
      if @status >= 200 and @status < 300
        resolve xhr.response
      else
        reject
          status: @status
          statusText: xhr.statusText

    xhr.onerror = ->
      reject
        status: @status
        statusText: xhr.statusText

    xhr.send()