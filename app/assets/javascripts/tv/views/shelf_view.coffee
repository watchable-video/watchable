this.shelfView = (videos) ->

  selectHandler = (event) ->
    video = getVideoFromLockup(event.target)
    template = videoDetailView video
    navigationDocument.pushDocument template

  videos = videos.map (video, index) ->
    videoPartialView(video)

  template = """
  <?xml version="1.0" encoding="UTF-8"?>
  <document>
    <head>
      <style>
  		.overlay {
  			padding: 0;
  		}
  		.resource-watched {
  			tv-position: bottom-trailing;
  			tv-align: trailing;
  		}
      </style>
    </head>
    <stackTemplate>
      <banner>
        <title>Subscriptions</title>
      </banner>
      <collectionList>
        <shelf>
          <section>
            #{videos.join("")}
          </section>
        </shelf>
      </collectionList>
    </stackTemplate>
  </document>
  """

  parser = new DOMParser();
  view = parser.parseFromString(template, "application/xml");

  view.addEventListener "select", selectHandler
  view.addEventListener "play", playHandler
  view
