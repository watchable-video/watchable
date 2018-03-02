this.request = (method, path) ->
  new Promise (resolve, reject) ->
    xhr = new XMLHttpRequest
    url = "#{data.options.BASEURL + path}?cloudkit_id=me"
    xhr.open method, url

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