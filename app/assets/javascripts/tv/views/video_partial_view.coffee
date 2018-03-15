this.videoPartialView = (video) ->

  """
  <lockup action="VideoLockup" videoID="#{video.id}" id="videoPartialView_#{video.id}">
    #{videoPartialInnerView(video)}
  </lockup>
  """

this.videoPartialInnerView = (video) ->
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
  <img src="#{video.poster_frame}" class="image" />
  <title class="title"><![CDATA[#{video.data.snippet.title}]]></title>
  <subtitle class="subtitle"><![CDATA[#{video.subtitle}]]></subtitle>
  #{watched()}
  """
