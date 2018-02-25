this.loading = ->
  template = """
  <?xml version="1.0" encoding="UTF-8" ?>
  <document>
    <loadingTemplate>
      <activityIndicator>
        <title><![CDATA[Loading…]]></title>
      </activityIndicator>
    </loadingTemplate>
  </document>
  """
  parser = new DOMParser();
  parser.parseFromString(template, "application/xml");
