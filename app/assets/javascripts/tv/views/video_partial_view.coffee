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
  <lockup action="VideoLockup" videoID="#{video.id}" id="lockup_#{video.id}">
    <img src="#{video.data.thumbnail_url}" width="960" height="540" />
    <title class="title"><![CDATA[#{video.data.title}]]></title>
    <subtitle class="subtitle"><![CDATA[#{video.subtitle}]]></subtitle>
    #{watched()}
  </lockup>
  """
