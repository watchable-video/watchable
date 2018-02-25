this.showcase = (videos) ->
  lockups = videos.map (video) ->
    """
    <lockup>
      <img src="#{video.data.thumbnail_url}" width="960" height="540" />
      <title><![CDATA[#{video.data.title}]]></title>
      <subtitle><![CDATA[#{video.data.channel_title} - #{video.date}]]></subtitle>
    </lockup>
    """
  template = """
  <?xml version="1.0" encoding="UTF-8" ?>
  <document>
    <showcaseTemplate>
      <banner>
        <title>Subscriptions</title>
      </banner>
      <carousel>
        <section>
            #{lockups.join("\n")}
        </section>
      </carousel>
    </showcaseTemplate>
  </document>
  """
  parser = new DOMParser();
  parser.parseFromString(template, "application/xml");
