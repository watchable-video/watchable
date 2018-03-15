this.alertView = (title, description) ->
  template = """
  <document>
    <alertTemplate>
      <title>#{title}</title>
      <description>#{description}</description>
    </alertTemplate>
  </document>
  """
  parser = new DOMParser();
  parser.parseFromString(template, "application/xml");
