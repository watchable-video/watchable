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
