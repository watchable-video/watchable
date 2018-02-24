this.alert = (title, description) ->
  template = """
  <?xml version="1.0" encoding="UTF-8" ?>
    <document>
    <alertTemplate>
      <title>#{title}</title>
      <description>#{description}</description>
    </alertTemplate>
  </document>
  """
  parser = new DOMParser();
  parser.parseFromString(template, "application/xml");
