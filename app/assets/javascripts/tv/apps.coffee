this.data = {}

this.App.onLaunch = (options) ->
  loadingTemplate = loading()
  navigationDocument.pushDocument(loadingTemplate)

  request = new XMLHttpRequest
  request.onreadystatechange = ->
    if @readyState == 4 and @status == 200
      data.videos = JSON.parse(@responseText)
      template = shelf(data.videos)
      template.addEventListener("select", select);
      navigationDocument.replaceDocument(template, loadingTemplate)

  request.open "GET", "http://0.0.0.0:3000/tv/videos.json?cloudkit_id=me", true
  request.send()


this.select = (event) ->
  target = event.target
  index = target.getAttribute("index")
  console.log index
  console.log data.videos[index]
