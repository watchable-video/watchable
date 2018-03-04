this.videoPartialView = (video) ->

  watched = ->
    if video.watched
      """
      <overlay style="padding: 363 0 0 651;">
        <badge src="resource://overlay-checkmark" />
      </overlay>
      """
    else
      ""

  """
  <lockup id="#{video.id}">
    <img src="#{video.data.thumbnail_url}" width="960" height="540" />
    <title><![CDATA[#{video.data.title}]]></title>
    <subtitle><![CDATA[#{video.subtitle}]]></subtitle>
    #{watched()}
  </lockup>
  """
