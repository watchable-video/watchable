this.App.onLaunch = (options) ->
  loadingTemplate = loading()
  navigationDocument.pushDocument(loadingTemplate)

  request = new XMLHttpRequest
  request.onreadystatechange = ->
    if @readyState == 4 and @status == 200
      videos = JSON.parse(@responseText)
      template = shelf(videos)
      navigationDocument.replaceDocument(template, loadingTemplate)

  request.open "GET", "http://0.0.0.0:3000/tv/videos.json?cloudkit_id=me", true
  request.send()
