this.loadingView = (text = "Loading…") ->

  template = """
  <document>
    <loadingTemplate>
      <activityIndicator>
        <title><![CDATA[#{text}]]></title>
      </activityIndicator>
    </loadingTemplate>
  </document>
  """
  parser = new DOMParser();
  parser.parseFromString(template, "application/xml");
