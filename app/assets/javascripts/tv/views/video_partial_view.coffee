this.videoPartialView = (video) ->
  """
  <lockup id="#{video.id}">
    <img src="#{video.data.thumbnail_url}" width="960" height="540" />
    <title><![CDATA[#{video.data.title}]]></title>
    <subtitle><![CDATA[#{video.subtitle}]]></subtitle>
  </lockup>
  """
