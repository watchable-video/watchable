this.loadingView = ->
  template = """
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
