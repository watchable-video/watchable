this.videoDetailView = (video) ->

  hd = ->
    if video.data.hd
      hd = """
      <badge src="resource://hd" />
      """
    else
      ""

  template = """
  <?xml version="1.0" encoding="UTF-8" ?>
  <document>
    <productTemplate theme="dark">
      <banner>

        <stack>
          <title style="font-size: 45pt;"><![CDATA[#{video.data.title}]]></title>
          <row>
            <text><![CDATA[#{video.timecode}]]></text>
            <text><![CDATA[#{video.full_date}]]></text>
            #{hd()}
          </row>

          <description><![CDATA[#{video.data.description}]]></description>
          <row>
            <buttonLockup type="play">
              <badge src="resource://button-play" />
              <title>Play</title>
            </buttonLockup>
          </row>
        </stack>

        <heroImg src="#{video.data.thumbnail_url}" style="width: 800pt;" />
      </banner>

    </productTemplate>
  </document>
  """
  parser = new DOMParser();
  parser.parseFromString(template, "application/xml");
