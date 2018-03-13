this.loginView = ->
  template = """
  <?xml version="1.0" encoding="UTF-8" ?>
    <document>
    <alertTemplate>
      <title>Login</title>
      <description style="margin-bottom: 20;">Visit #{data.options.BASEURL}/accounts/new and enter this code to login:</description>
      <text style="font-weight: bold; font-size: 50;">#{data.options.CLOUDKITID}</text>
    </alertTemplate>
  </document>
  """
  parser = new DOMParser();
  parser.parseFromString(template, "application/xml");
