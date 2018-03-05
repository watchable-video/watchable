this.videoPartialView = (video) ->

  watched = ->
    if video.watched
      """
      <overlay class="overlay">
        <badge src="resource://overlay-checkmark" class="resource-watched" />
      </overlay>
      """
    else
      ""

  """
  <lockup id="#{video.id}">
    <img src="#{video.data.thumbnail_url}" width="960" height="540" />
    <title><![CDATA[#{video.data.title}]]></title>
    <subtitle><![CDATA[#{video.subtitle}]]></subtitle>
    <overlay>
      <progressBar value="0.6" />
    </overlay>
    #{watched()}
  </lockup>
  """
